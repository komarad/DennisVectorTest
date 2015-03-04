import mathematik.*;
import teilchen.*;
import teilchen.force.*;
import teilchen.constraint.*;
import teilchen.util.CollisionManager;

private final int initNumOfAgents = 100;
private final int goalNumOfAgents = 400;
private Physics physics;
private final float deflectorConfig = 0.5f;
private final int radius = 20;
private final int numOfDeflectors = 10;
private CollisionManager mCollision;
private ArrayList<Attractor> deflectors = new ArrayList<Attractor>();

void setup() {
  size(640, 480, OPENGL);
  smooth();
  noFill();
  
  physics = new Physics();
  
  /* create a viscous force that slows down all motion */
  ViscousDrag myDrag = new ViscousDrag();
  myDrag.coefficient = 4f;
  physics.add(myDrag);
  
  Gravity mGravity = new Gravity();
  mGravity.force().set(0, 30, 0);
  physics.add(mGravity);

  mCollision = new CollisionManager();
  mCollision.distancemode(CollisionManager.DISTANCE_MODE_FIXED);
  mCollision.minimumDistance(radius*3);

  for(int i = 0; i < initNumOfAgents; i++) {
    createCreature((int)random(width), (int)random(height));
  }

  /* create defelctors */
  for(int i = 0; i < numOfDeflectors; i++) {
    Attractor mDeflector = new Attractor();
    mDeflector.radius(100);
    mDeflector.strength(-10000);
    physics.add(mDeflector);
    deflectors.add(mDeflector);
  }

  /*Box myBox = new Box();
  myBox.min().set(radius, radius, 0);
  myBox.max().set(width - radius, height - radius, 0);
  myBox.coefficientofrestitution(deflectorConfig);
  myBox.reflect(true);
  physics.add(myBox);*/

  PlaneDeflector mDeflectorBottom = new PlaneDeflector();
  /* set plane origin into the center of the screen */
  mDeflectorBottom.plane().origin.set(0, (height+200), 0);
  mDeflectorBottom.plane().normal.set(0, -1, 0);
  /* the coefficient of restitution defines how hard particles bounce of the deflector */
  mDeflectorBottom.coefficientofrestitution(deflectorConfig);
  physics.add(mDeflectorBottom);
  
  PlaneDeflector mDeflectorRight = new PlaneDeflector();
  /* set plane origin into the center of the screen */
  mDeflectorRight.plane().origin.set((width+200), 0, 0);
  mDeflectorRight.plane().normal.set(-1, 0, 0);
  /* the coefficient of restitution defines how hard particles bounce of the deflector */
  mDeflectorRight.coefficientofrestitution(deflectorConfig);
  physics.add(mDeflectorRight);

  PlaneDeflector mDeflectorLeft = new PlaneDeflector();
  /* set plane origin into the center of the screen */
  mDeflectorLeft.plane().origin.set(-200, 0, 0);
  mDeflectorLeft.plane().normal.set(1, 0, 0);
  /* the coefficient of restitution defines how hard particles bounce of the deflector */
  mDeflectorLeft.coefficientofrestitution(deflectorConfig);
  physics.add(mDeflectorLeft);
  
}

void mousePressed() {  
  /* flip the direction of the attractors strength. */
  //float myInvertedStrength = -1 * mDeflector.strength();
  /* a negative strength turns the attractor into a repulsor */
  //mDeflector.strength(myInvertedStrength);
}

void draw() {

  if(physics.particles().size() < goalNumOfAgents) {
    createCreature((int)random(width), -5*radius);  
  }
  
  final float mDeltaTime = 1.0 / frameRate;
 
  /* collision handler */
  mCollision.createCollisionResolvers();
  mCollision.loop(mDeltaTime);
  
  physics.step(mDeltaTime);
  
  background(23, 68, 250);
  


  /* particles */
  fill(255);
  stroke(164);
  for (int i = 0; i < physics.particles().size(); ++i) {
    Particle myParticle = physics.particles().get(i);
    pushMatrix();
    translate(myParticle.position().x, myParticle.position().y, myParticle.position().z);
    ellipse(0, 0, myParticle.radius(), myParticle.radius());
    popMatrix();
  }
  
  

  
  mCollision.removeCollisionResolver();

    /* draw attractor. green if it is attracting and red if it is repelling */
  noStroke();
  for(int i = 0; i < deflectors.size(); i++) {
    Attractor deflector = deflectors.get(i);
    int remainder = i % 2;
    int disposition = (remainder == 0 ? 1 : -1);
    if(frameCount%10 == 0) {
       deflector.position().set(mouseX + disposition*(20+random(20)), mouseY + (i/2)*(30+random(30)));
    }
    
    if (deflector.strength() < 0) {
      fill(255, 0, 0, 50);
    } 
    else {
      fill(0, 255, 0, 50);
    }
    ellipse(deflector.position().x, deflector.position().y, deflector.radius(), deflector.radius());
  }

}

void createCreature(int x, int y) {
  CircleCreature creature = new CircleCreature(x, y, (int)(radius*random(2,3)/2.0));
  physics.add(creature);
  mCollision.collision().add(creature);
}
