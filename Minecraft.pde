import peasy.*;
import java.awt.Robot;
import java.util.Arrays;
Robot robot;
PeasyCam cam;
ArrayList<Ground> ground = new ArrayList<Ground>();
ArrayList<Ground> nearbyGround = new ArrayList<Ground>();
ArrayList<float[]> blockCoords = new ArrayList<float[]>();
float camX = 0, camY = 0, camZ = 100, camRX = 0, camRY = 0, camVY = 0, handAngle = 0;
int hotbarSlot;
int[] blockRed = new int[9];
int[] blockGreen = new int[9];
int[] blockBlue = new int[9];
boolean punching = false;
Player me = new Player(0, -25, 0, 6, 20, 6);
void setup() {
  fullScreen(P3D);
  //size(1000, 800, P3D);
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
  
  blockRed[0] = 150;
  blockRed[1] = 0;
  blockRed[2] = 255;
  blockRed[3] = 0;
  blockRed[4] = 100;
  blockRed[5] = 150;
  blockRed[6] = 0;
  blockRed[7] = 250;
  blockRed[8] = 255;
  
  blockGreen[0] = 100;
  blockGreen[1] = 150;
  blockGreen[2] = 0;
  blockGreen[3] = 150;
  blockGreen[4] = 100;
  blockGreen[5] = 0;
  blockGreen[6] = 0;
  blockGreen[7] = 100;
  blockGreen[8] = 255;
  
  blockBlue[0] = 60;
  blockBlue[1] = 0;
  blockBlue[2] = 0;
  blockBlue[3] = 150;
  blockBlue[4] = 100;
  blockBlue[5] = 150;
  blockBlue[6] = 255;
  blockBlue[7] = 0;
  blockBlue[8] = 255;
  
  //ground.add(new Ground(0, 0, 0, 1000, 10, 1000, false, 0, 150, 0));
  rectMode(CORNERS);
  lights();
  noCursor();
  clip(0, 0, width, height);
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
  pointLight(me.x, me.y, me.z, 0, 0, 0);
  //noLights();
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
  blockCoords.clear();
  for(int i = 0; i < nearbyGround.size(); i++) {
    float[] tempCoords = {nearbyGround.get(i).x, nearbyGround.get(i).y, nearbyGround.get(i).z};
    blockCoords.add(tempCoords);
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
  //playerHand();
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
  hotbar();
  pushMatrix();
  //rotateY(-camRX);
  //rotateZ(camRY);
  //rotateY(PI);
  translate(width-100, height-60, 0);
  rotateX(PI/8);
  rotateY(PI+PI/8);
  rotateZ(PI/4);
  translate(2, 2, -2);
  //rotateX(handAngle);
  rotateY(handAngle/4);
  rotateZ(handAngle);
  //translate(-20, -20, 20);
  noStroke();
  fill(255, 120, 0);
  //fill(blockRed[hotbarSlot], blockGreen[hotbarSlot], blockBlue[hotbarSlot]);
  box(200, 800, 200);
  translate(0, -400, 0);
  fill(blockRed[hotbarSlot], blockGreen[hotbarSlot], blockBlue[hotbarSlot]);
  box(250);
  popMatrix();
  cam.endHUD();
  findLookAt();
  if(canPlace && mousePressed && mouseButton == RIGHT && millis()-placeCooldownStart > 200) {
    placeCooldownStart = millis();
    use();
  }
  if(!mousePressed) {
    placeCooldownStart = 0;
  }
}

public void playerHand() {
  pushMatrix();
  translate(me.x, me.y-eyeHeight, me.z);
  rotateY(-camRX);
  rotateZ(camRY);
  translate(10, 6.1, 6);
  rotateX(PI/8);
  rotateY(PI/8);
  rotateZ(PI/5);
  translate(2, 2, -2);
  //rotateX(handAngle);
  rotateY(handAngle/4);
  rotateZ(handAngle);
  translate(-2, -2, 2);
  noStroke();
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

public void use() {
  punchTimer = millis();
  punching = true;
  handAngle = -PI/8;
  int red = 0, green = 0, blue = 0;
  if(hotbarSlot == 0) {
    red = 150;
    green = 100;
    blue = 60;
  } else if(hotbarSlot == 1) {
    red = 0;
    green = 150;
    blue = 0;
  } else if(hotbarSlot == 2) {
    red = 255;
    green = 0;
    blue = 0;
  } else if(hotbarSlot == 3) {
    red = 0;
    green = 150;
    blue = 150;
  } else if(hotbarSlot == 4) {
    red = 100;
    green = 100;
    blue = 100;
  } else if(hotbarSlot == 5) {
    red = 150;
    green = 0;
    blue = 150;
  } else if(hotbarSlot == 6) {
    red = 0;
    green = 0;
    blue = 255;
  } else if(hotbarSlot == 7) {
    red = 250;
    green = 100;
    blue = 0;
  } else if(hotbarSlot == 8) {
    red = 255;
    green = 255;
    blue = 255;
  }
  boolean occupiedBlock = false;
  for(int i = 0; i < nearbyGround.size(); i++) {
    if(nearbyGround.get(i).xc == placerCandidates.get(0)[0] && nearbyGround.get(i).yc == placerCandidates.get(0)[1] && nearbyGround.get(i).zc == placerCandidates.get(i)[2]) {
      occupiedBlock = true;
      break;
    }
  }
  if(placerCandidates.size() > 0 && !occupiedBlock) {
    ground.add(new Ground(Math.round(placerCandidates.get(0)[0]/10), Math.round(-placerCandidates.get(0)[1]/10), Math.round(placerCandidates.get(0)[2]/10), 10, 10, 10, false, red, green, blue));
  }
}

public int[] turnCoords(float x, float y, float z) {
  int[] newCoords = {(int) ((x-5)/10), (int) (-(y+5)/10), (int) ((z-5)/10)};
  return newCoords;
}

public int[] turnCoords(float[] coordsList) {
  int[] newCoords = {(int) ((coordsList[0]-5)/10), (int) (-(coordsList[1]+5)/10), (int) ((coordsList[2]-5)/10)};
  return newCoords;
}

public int turnY(float y) {
  return (int) (-y/10);
}

public void mouseClicked() {
  if(mouseButton == LEFT) {
    punch();
    punching = true;
  }
  if(mouseButton == RIGHT) {
    placeCooldownStart = millis();
    //use();
  }
}

public void mouseReleased() {
  if(mouseButton == LEFT) {
    punching = false;
  }
  if(mouseButton == RIGHT) {
    punching = false;
  }
}

public void mouseWheel(MouseEvent event) {
  if(event.getCount() < 0) {
    if(hotbarSlot > 0) {
      hotbarSlot--;
    } else {
      hotbarSlot = 8;
    }
  } else {
    if(hotbarSlot < 8) {
      hotbarSlot++;
    } else {
      hotbarSlot = 0;
    }
  }
}

public void makeSlot(int numSlot) {
  fill(100, 50);
  if(numSlot == hotbarSlot) {
    stroke(220);
    strokeWeight(6);
  } else {
    stroke(150);
    strokeWeight(4);
  }
  rect(width/2-238.5+numSlot*53, height-10, width/2-188.5+numSlot*53, height-60);
  stroke(0);
  strokeWeight(1);
  rect(width/2-235.5+numSlot*53, height-13, width/2-191.5+numSlot*53, height-57);
  fill(blockRed[numSlot], blockGreen[numSlot], blockBlue[numSlot]);
  rect(width/2-235.5+numSlot*53, height-13, width/2-191.5+numSlot*53, height-57);
}

public void hotbar() {
  for(int i = 0; i < 9; i++) {
    makeSlot(i);
    stroke(0);
    strokeWeight(1);
    //rect(width/2-240.5+i*53, height-7, width/2-186.5+i*53, height-63);
  }
  noFill();
  stroke(220);
  strokeWeight(6);
  rect(width/2-238.5+hotbarSlot*53, height-10, width/2-188.5+hotbarSlot*53, height-60);
  stroke(0);
  strokeWeight(2);
  rect(width/2-241.5+hotbarSlot*53, height-7, width/2-185.5+hotbarSlot*53, height-63);
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
