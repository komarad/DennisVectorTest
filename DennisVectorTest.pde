import mathematik.*;

private Timer myTimer;
private ArrayList<Agent> agents = new ArrayList<Agent>(50);
private final int numOfAgents = 50;
private Physics physics = new Physics();

void setup() {
  size(320, 240);
  smooth();
  noFill();
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
}
