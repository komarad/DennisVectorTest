/*
* the agent
 * step 07 - introducing time.
 *
 * introducing:
 * delta time
 *
 * import Vector2f
 */


Agent myAgent;
Timer myTimer;

void setup() {
  size(320, 240);
  smooth();
  noFill();
  ellipseMode(CENTER);

  myAgent = new Agent();
  myAgent.position.set(320, 240);
  myAgent.velocity.set(0f, 0f);
  myAgent.acceleration.set(-4.0f, -3.0f);
  myAgent.radius = 15;
  myAgent.maxspeed = 30f;
  myAgent.maxacceleration = 20f;

  myTimer = new Timer();
}

void draw() {
  background(255);

  goToMouse(myAgent);

  myAgent.loop(myTimer.getDeltaTime());
  myAgent.draw();

  myTimer.loop();
}

void goToMouse(Agent theAgent) {
  /*
    * this method is just for quickly observing different
   * acceleration settings.
   * actually the code below already describes a first
   * simple behavior. the agent adjust its acceleration
   * vector to 'go to' the mouseposition.
   * enjoy.
   */
  Vector2f myAccelerationDirection = new Vector2f();
  myAccelerationDirection.set(mouseX, mouseY);
  myAccelerationDirection.sub(myAgent.position);
  theAgent.acceleration.set(myAccelerationDirection);
}

class Agent {

  Vector2f position = new Vector2f();
  Vector2f velocity = new Vector2f();
  Vector2f acceleration = new Vector2f();
  float maxspeed = 0;
  float maxacceleration = 0;
  float radius = 0;

  void loop(float theDeltaTime) {

    float myAccelerationSpeed = acceleration.length();

    if (myAccelerationSpeed > maxacceleration) {
      acceleration.normalize();
      acceleration.multiply(maxacceleration);
    }

    Vector2f myTimerAcceleration = new Vector2f();
    myTimerAcceleration.set(acceleration);
    myTimerAcceleration.multiply(theDeltaTime);

    velocity.add(myTimerAcceleration);

    float mySpeed = velocity.length();
    if (mySpeed > maxspeed) {
      velocity.normalize();
      velocity.multiply(maxspeed);
    }

    Vector2f myTimerVelocity = new Vector2f();
    myTimerVelocity.set(velocity);
    myTimerVelocity.multiply(theDeltaTime);

    position.add(myTimerVelocity);
  }

  void draw() {
    stroke(0, 0, 0);
    ellipse(position.x, position.y, radius, radius);
    stroke(255, 0, 0);
    line(position.x,
    position.y,
    position.x + velocity.x,
    position.y + velocity.y);
    stroke(0, 255, 0);
    line(position.x + velocity.x,
    position.y + velocity.y,
    position.x + velocity.x + acceleration.x,
    position.y + velocity.y + acceleration.y);
  }
}

class Timer {
  float _myTime = millis();
  float _myDeltaTime = 0;

  float getDeltaTime() {
    return _myDeltaTime;
  }

  void loop() {
    _myDeltaTime = (millis() - _myTime)/1000.0f;
    _myTime = millis();
  }
}
