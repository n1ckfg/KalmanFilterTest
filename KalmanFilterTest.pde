KalmanFilter kfx = new KalmanFilter();
KalmanFilter kfy = new KalmanFilter();
PVector pos, ppos, noisyMouse, pnoisyMouse;
float spread = 20;

void setup() {
  size(640,480,P2D);
  pos = new PVector(width/2, height/2);
  ppos = new PVector(width/2, height/2);
  noisyMouse = new PVector(width/2, height/2);
  pnoisyMouse = new PVector(width/2, height/2);
  background(127);
  ellipseMode(CENTER);
}

void draw() {
  pnoisyMouse = new PVector(noisyMouse.x, noisyMouse.y);;
  ppos = new PVector(pos.x, pos.y);
    
  if (mousePressed) {
    noisyMouse = new PVector(mouseX, mouseY);
    noisyMouse.x += random(-spread, spread);
    noisyMouse.y += random(-spread, spread);
    
    // a posteriori estimate of x, y
    pos.x = kfx.predict_and_correct(noisyMouse.x);
    pos.y = kfy.predict_and_correct(noisyMouse.y);
    
    stroke(255,0,0);
    strokeWeight(2);
    line(noisyMouse.x, noisyMouse.y, pnoisyMouse.x, pnoisyMouse.y);
    
    //noStroke();
    fill(0,0,255);
    ellipse(pos.x, pos.y, 10, 10);
    stroke(0,0,255);
    strokeWeight(2);
    line(pos.x, pos.y, ppos.x, ppos.y);
  }
}

void keyPressed() {
  background(127);
}