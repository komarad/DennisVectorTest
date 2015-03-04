import mathematik.*;
import teilchen.*;
import teilchen.force.*;
import teilchen.constraint.*;
import teilchen.util.CollisionManager;

private final int numOfAgents = 10;
private Physics physics;
private Attractor mAttractor;
private Attractor mDeflector;
private final float deflectorConfig = 0.7f;
private final int radius = 20;
private CollisionManager mCollision;

void setup() {
  size(640, 480, OPENGL);
  smooth();
  noFill();
  
  physics = new Physics();
  
  Gravity mGravity = new Gravity();
  mGravity.force().set(0, 30, 0);  

  /* create a viscous force that slows down all motion */
  ViscousDrag myDrag = new ViscousDrag();
  myDrag.coefficient = 4f;
  physics.add(myDrag);

  mCollision = new CollisionManager();
  mCollision.distancemode(CollisionManager.DISTANCE_MODE_FIXED);
  mCollision.minimumDistance(radius*2);

  for(int i = 0; i < numOfAgents; i++) {
    CircleCreature creature = new CircleCreature((int)random(width), (int)random(height), radius);
    agents.add(creature);
    physics.add(creature);
    mCollision.collision().add(creature);
  }

  /* create an attractor */
  mAttractor = new Attractor();
  mAttractor.radius(500);
  mAttractor.strength(20);
  mAttractor.position().set(width/2, 2*height/3);
  physics.add(mAttractor);

  /* create an attractor */
  mDeflector = new Attractor();
  mDeflector.radius(70);
  mDeflector.strength(-1000);
  physics.add(mDeflector);

  Box myBox = new Box();
  myBox.min().set(radius, radius, 0);
  myBox.max().set(width - radius, height - radius, 0);
  myBox.coefficientofrestitution(deflectorConfig);
  myBox.reflect(true);
  physics.add(myBox);
  
}

void draw() {

  /* create particles */
  if (mousePressed) {
    final Particle myParticle = physics.makeParticle(new Vector3f(mouseX, mouseY, 0), 10);
    mCollision.collision().add(myParticle);
  }

  final float mDeltaTime = 1.0 / frameRate;
 
  /* collision handler */
  mCollision.createCollisionResolvers();
  mCollision.loop(mDeltaTime);
  
  physics.step(mDeltaTime);
 
  /* set attractor to mouse position */
  mDeflector.position().set(mouseX, mouseY);

  background(23, 68, 250);
  stroke(255);
  noFill();

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
  if (mDeflector.strength() < 0) {
    fill(255, 0, 0, 50);
  } 
  else {
    fill(0, 255, 0, 50);
  }
  ellipse(mDeflector.position().x, mDeflector.position().y,
  mDeflector.radius(), mDeflector.radius());

  fill(0, 255, 0, 50);
  ellipse(mAttractor.position().x, mAttractor.position().y,
  mAttractor.radius(), mAttractor.radius());
}
