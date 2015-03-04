import mathematik.*;
<<<<<<< HEAD
import teilchen.*;
import teilchen.force.*;
import teilchen.constraint.*;
import teilchen.behavior.*;
=======
>>>>>>> parent of e4c06ea... Now Physics is Implemented

private Timer myTimer;
private ArrayList<Agent> agents = new ArrayList<Agent>(50);
private final int numOfAgents = 50;
<<<<<<< HEAD
private Physics physics;
private Attractor mAttractor;
private final float deflectorConfig = 0.99f;
private final int radius = 10;
private Arrival arrival;
=======
private Physics physics = new Physics();
>>>>>>> parent of e4c06ea... Now Physics is Implemented

void setup() {
  size(320, 240);
  smooth();
  noFill();
<<<<<<< HEAD
  
  physics = new Physics();
  
  Gravity mGravity = new Gravity();
  mGravity.force().set(0, 30, 0);  
  //physics.add(mGravity);


  
  /* create a viscous force that slows down all motion */
  ViscousDrag myDrag = new ViscousDrag();
  myDrag.coefficient = 4f;
  physics.add(myDrag);

 arrival = new Arrival();
 
  for(int i = 0; i < numOfAgents; i++) {
    CircleCreature creature = new CircleCreature((int)random(width), (int)random(height), radius);
    agents.add(creature);
    physics.add(creature);
   
    arrival.breakforce(creature.maximumInnerForce() * 0.25f);
    arrival.breakradius(creature.maximumInnerForce() * 0.25f);
    creature.behaviors().add(arrival);  
  }

  /* create an attractor */
  /*mAttractor = new Attractor();
  mAttractor.radius(500);
  mAttractor.strength(150);
  physics.add(mAttractor);*/


  /* create a deflector and add it to the particle system.
   * the that defines the deflection area is defined by an
   * origin and a normal. this also means that the plane s size
   * is infinite.
   * note that there is also a triangle delfector that is constraint
   * by three points.
   */
  PlaneDeflector mDeflectorBottom = new PlaneDeflector();
  /* set plane origin into the center of the screen */
  mDeflectorBottom.plane().origin.set(0, (height-radius), 0);
  mDeflectorBottom.plane().normal.set(0, -1, 0);
  /* the coefficient of restitution defines how hard particles bounce of the deflector */
  mDeflectorBottom.coefficientofrestitution(deflectorConfig);
  physics.add(mDeflectorBottom);
  
  PlaneDeflector mDeflectorRight = new PlaneDeflector();
  /* set plane origin into the center of the screen */
  mDeflectorRight.plane().origin.set((width-radius), 0, 0);
  mDeflectorRight.plane().normal.set(-1, 0, 0);
  /* the coefficient of restitution defines how hard particles bounce of the deflector */
  mDeflectorRight.coefficientofrestitution(deflectorConfig);
  physics.add(mDeflectorRight);

  PlaneDeflector mDeflectorLeft = new PlaneDeflector();
  /* set plane origin into the center of the screen */
  mDeflectorLeft.plane().origin.set(radius, 0, 0);
  mDeflectorLeft.plane().normal.set(1, 0, 0);
  /* the coefficient of restitution defines how hard particles bounce of the deflector */
  mDeflectorLeft.coefficientofrestitution(deflectorConfig);
  physics.add(mDeflectorLeft);

  PlaneDeflector mDeflectorTop = new PlaneDeflector();
  /* set plane origin into the center of the screen */
  mDeflectorTop.plane().origin.set(0, radius, 0);
  mDeflectorTop.plane().normal.set(0, 1, 0);
  /* the coefficient of restitution defines how hard particles bounce of the deflector */
  mDeflectorTop.coefficientofrestitution(deflectorConfig);
  physics.add(mDeflectorTop);

}

void mousePressed() {  
  /* flip the direction of the attractors strength. */
  //float myInvertedStrength = -1 * mAttractor.strength();
  /* a negative strength turns the attractor into a repulsor */
  //mAttractor.strength(myInvertedStrength);
}

void draw() {

  physics.step(1.0 / frameRate);
 
  /* set attractor to mouse position */
  //mAttractor.position().set(mouseX, mouseY);

  background(23, 68, 250);
  stroke(255);
  noFill();
  
  for(int i = 0; i < agents.size(); i++) {
    agents.get(i).display();
  }

  /* draw attractor. green if it is attracting and red if it is repelling */
  /*noStroke();
  if (mAttractor.strength() < 0) {
    fill(255, 0, 0, 50);
  } 
  else {
    fill(0, 255, 0, 50);
  }
  ellipse(mAttractor.position().x, mAttractor.position().y,
  mAttractor.radius(), mAttractor.radius());*/
  
    arrival.position().set(mouseX, mouseY);
    if(arrival.arrived()) {
      stroke(0, 255, 0);
      fill(0, 255, 0, 30);
    } else {
      stroke(255, 0, 189);
      fill(255, 0, 189, 30);
    }
  
    ellipse(arrival.position().x, arrival.position().y,
    arrival.breakradius() * 2, arrival.breakradius() * 2);
=======
  ellipseMode(CENTER);
  myTimer = new Timer();
  for(int i = 0; i < numOfAgents; i++) {
    agents.add(new Agent());
  }
}

void mousePressed() {
  for(int i = 0; i < numOfAgents; i++) {
    agents.get(i).setToPlace(random(320), random(240), 100);
  }
  Boolean b = new Boolean(true);
  Boolean c = new Boolean(false);

}

void draw() {
  background(255);
  
  for(int i = 0; i < agents.size(); i++) {
    Agent a = agents.get(i);
    a.goToMouse();
    a.loop(myTimer.getDeltaTime());
    a.draw();
  }
  myTimer.loop();
>>>>>>> parent of e4c06ea... Now Physics is Implemented
}
