class Agent {

  public static final float maxSpeed = 50;
  public static final float maxAcceleration = 25;

  public Vector2f position = new Vector2f();
  public Vector2f velocity = new Vector2f();
  public Vector2f acceleration = new Vector2f();
  public float radius = 0;
  
  private float goToPlaceX = 0;
  private float goToPlaceY = 0;
  private int goToPlaceDuration = 0;

  public Agent() {
    position.set(random(320), random(240));
    velocity.set(0f, 0f);
    acceleration.set(-4.0f, -3.0f);
    radius = 15;
  }

  void loop(float theDeltaTime) {

    float myAccelerationSpeed = acceleration.length();
    if (myAccelerationSpeed > maxAcceleration) {
      acceleration.normalize();
      acceleration.multiply(maxAcceleration);
    }

    Vector2f myTimerAcceleration = new Vector2f();
    myTimerAcceleration.set(acceleration);
    myTimerAcceleration.multiply(theDeltaTime);
    velocity.add(myTimerAcceleration);

    float mySpeed = velocity.length();
    if(mySpeed > myAccelerationSpeed) {
      velocity.normalize();
      velocity.multiply(myAccelerationSpeed);
    }
    mySpeed = velocity.length();
    if(mySpeed > maxSpeed) {
      velocity.normalize();
      velocity.multiply(maxSpeed);
    }

    Vector2f myTimerVelocity = new Vector2f();
    myTimerVelocity.set(velocity);
    myTimerVelocity.multiply(theDeltaTime);

    position.add(myTimerVelocity);
  }

  void goToMouse() {
    Vector2f myAccelerationDirection = new Vector2f();
    if(goToPlaceDuration == 0) {
      myAccelerationDirection.set(mouseX, mouseY);
    } else {
      myAccelerationDirection.set(goToPlaceX, goToPlaceY);
      goToPlaceDuration -= 1;
    }
    myAccelerationDirection.sub(position);
    acceleration.set(myAccelerationDirection);
  }
  
  void setToPlace(float x, float y, int duration) {
    goToPlaceX= x;
    goToPlaceY = y;
    goToPlaceDuration = duration;
  }

  void draw() {
    stroke(0, 0, 0);
    ellipse(position.x, position.y, radius, radius);
    //stroke(255, 0, 0);
    //line(position.x, position.y, position.x + velocity.x, position.y + velocity.y);
    //stroke(0, 255, 0);
    //line(position.x + velocity.x, position.y + velocity.y, position.x + velocity.x + acceleration.x, position.y + velocity.y + acceleration.y);
  }
}

