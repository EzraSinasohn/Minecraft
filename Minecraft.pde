import peasy.*;
import java.awt.Robot;
import java.util.Arrays;
Robot robot;
PeasyCam cam;
ArrayList<Ground> ground = new ArrayList<Ground>();
ArrayList<Ground> nearbyGround = new ArrayList<Ground>();
float camX = 0, camY = 0, camZ = 100, camRX = 0, camRY = 0, camVY = 0, handAngle = 0;
boolean punching = false;
Player me = new Player(0, -25, 0, 6, 20, 6);
void setup() {
  //fullScreen(P3D);
  size(1000, 800, P3D);
  //ground.add(new Ground(0, -75, 0, 25, 25, 25, false));
  ground.add(new Ground(0, 1, 0, 10, 10, 10, false, 100, 100, 100));
  ground.add(new Ground(0, 1, -1, 10, 10, 10, false, 100, 100, 100));
  ground.add(new Ground(0, 1, 1, 10, 10, 10, false, 100, 100, 100));
  ground.add(new Ground(-1, 1, 0, 10, 10, 10, false, 100, 100, 100));
  ground.add(new Ground(-1, 1, 1, 10, 10, 10, false, 100, 100, 100));
  ground.add(new Ground(-1, 1, -1, 10, 10, 10, false, 100, 100, 100));
  ground.add(new Ground(1, 1, 0, 10, 10, 10, false, 100, 100, 100));
  ground.add(new Ground(1, 1, -1, 10, 10, 10, false, 100, 100, 100));
  ground.add(new Ground(1, 1, 1, 10, 10, 10, false, 100, 100, 100));
  ground.add(new Ground(4, 1, 0, 10, 10, 10, false, 255, 0, 0));
  for(int i = -50; i < 50; i++) {
    for(int n = -50; n < 50; n++) {
      ground.add(new Ground(i, 0, n, 10, 10, 10, false, 0, 150, 0));
    }
  }
  for(int i = -5; i < 5; i++) {
    ground.add(new Ground(i, 1, 5, 10, 10, 10, false, 0, 150, 150));
    ground.add(new Ground(i, 2, 5, 10, 10, 10, false, 0, 150, 150));
    ground.add(new Ground(i, 3, 5, 10, 10, 10, false, 0, 150, 150));
  }
  for(int i = -5; i < 5; i++) {
    ground.add(new Ground(i, 1, 6, 10, 10, 10, false, 0, 150, 150));
    ground.add(new Ground(i, 2, 6, 10, 10, 10, false, 0, 150, 150));
    ground.add(new Ground(i, 3, 6, 10, 10, 10, false, 0, 150, 150));
  }
  //ground.add(new Ground(0, 0, 0, 1000, 10, 1000, false, 0, 150, 0));
  rectMode(CORNERS);
  lights();
  noCursor();
  try {
    robot = new Robot();
  } 
  catch (Throwable e) {
  }
  cam = new PeasyCam(this, 100);
  cam.setActive(false);
  //cam.setWheelHandler(null);
}

void draw() {
  background(100, 200, 250);
  //lights();
  lightFalloff(1.0, 0.0, 0.0);
  ambientLight(120, 120, 120);
  pointLight(200, 200, 200, 140, -160, 144);
  //noLights();
  pushMatrix();
  shininess(255);
  emissive(20);
  fill(250, 250, 100);
  translate(140, -160, 144);
  ellipse(0, 0, 10, 10);
  popMatrix();
  for(int i = 0; i < ground.size(); i++) {
    if(Math.sqrt((ground.get(i).x-me.x)*(ground.get(i).x-me.x) + (ground.get(i).y-me.y)*(ground.get(i).y-me.y) + (ground.get(i).z-me.z)*(ground.get(i).z-me.z)) < 50 && !nearbyGround.contains(ground.get(i))) {nearbyGround.add(ground.get(i));}
  }
  for(int i = 0; i < ground.size(); i++) {
    if(screenZ(ground.get(i).x, ground.get(i).y, ground.get(i).z) > 0) {
      ground.get(i).show();
    }
  }
  moveCam();
  me.jump = false;
  for(int i = 0; i < nearbyGround.size(); i++) {
    me.collision(nearbyGround.get(i));
  }
  me.move();
  fill(0);
  if(millis()-punchTimer > 200) {punching = false;}
  if(punching) {
    if(handAngle > PI) {handAngle = -PI/2;}
    if(millis()%7 > 0) {handAngle += PI/8;}
  }
  else {handAngle = 0;}
  playerHand();
  /*text(camRY, 0, -80);
  text(me.sides(ground.get(0))[0], -100, 0, -20);
  text(me.sides(ground.get(0))[1], -20, 0, -20);
  text(me.sides(ground.get(0))[2], 60, 0, -20);
  text(me.sides(ground.get(0))[3], 140, 0, -20);
  text(me.sides(ground.get(0))[4], 220, 0, -20);
  text(me.sides(ground.get(0))[5], 300, 0, -20);*/
  cam.beginHUD(); // start drawing relative to the camera view
  fill(255);
  rect(20, 10, 300, 40);
  fill(0);
  text(str(me.xc), 30, 30);
  text(str(me.yc), 130, 30);
  text(str(me.zc), 230, 30);
  noStroke();
  fill(255, 90);
  rect(width/2-2, height/2-2, width/2+2, height/2+2);
  rect(width/2-2, height/2-2, width/2+2, height/2-15);
  rect(width/2-2, height/2+15, width/2+2, height/2+2);
  rect(width/2-2, height/2-2, width/2-15, height/2+2);
  rect(width/2+15, height/2-2, width/2+2, height/2+2);
  stroke(1);
  fill(0);
  text(nearbyGround.size(), 30, 60);
  text(camRX, 30, 90);
  text(camRY, 90, 90);
  text(sin(camRY), 150, 90);
  cam.endHUD();
  //interactLine();
  findLookAt();
}

public void playerHand() {
  pushMatrix();
  translate(me.x, me.y-eyeHeight, me.z);
  rotateY(-camRX);
  rotateZ(camRY);
  translate(12, 6.1, 6);
  rotateX(PI/8);
  rotateY(PI/8);
  rotateZ(PI/5);
  translate(2, 2, -2);
  //rotateX(handAngle);
  rotateY(handAngle/4);
  rotateZ(handAngle);
  translate(-2, -2, 2);
  fill(255, 120, 0);
  box(3, 10, 3);
  popMatrix();
}

public void punch() {
  punchTimer = millis();
  punching = true;
  handAngle = -PI/8;
  for(int i = 0; i < ground.size(); i++) {
    if(ground.get(i).highlighted) {
      ground.remove(i);
      break;
    }
  }
}

public void mouseClicked() {
  if(mouseButton == LEFT) {
    punch();
    punching = true;
  }
}

public void mouseReleased() {
  if(mouseButton == LEFT) {
    punching = false;
  }
}

public void crosshair() {
  /*translate(me.x, me.y-eyeHeight, me.z);
  rotateY(-camRX);
  rotateZ(camRY);
  translate(me.l/2-1, 0);
  rotateY(PI/2);
  fill(255);
  emissive(255);*/
  translate(0, 0, -10);
  rect(width/2, height/2, 10, 10);
}
