public boolean snapMouse = true;
public float logMouseX, logMouseY, hlX, hlY, hlZ;
public float punchTimer = 0;
public int indexOfBlock = 0;
public Ground placeBlock;
public ArrayList <float[]> highlightedBlocks = new ArrayList<float[]>();
public ArrayList <Ground> highlightCandidates = new ArrayList<Ground>();
public void mouseMoved() {
  if(mouseY > height/2 && camRY < 1.5) {
    logMouseY = mouseY;
    camRY += (logMouseY-height/2)/400;
    //camRY += 0.03;
  } if(mouseY < height/2 && camRY > -1.5) {
    logMouseY = mouseY;
    camRY += (logMouseY-height/2)/400;
    //camRY -= 0.03;
  } if(mouseX > width/2) {
    logMouseX = mouseX;
    camRX += (logMouseX-width/2)/400;
  } if(mouseX < width/2) {
    logMouseX = mouseX;
    camRX += (logMouseX-width/2)/400;
    //camRX -= 0.03;
  }
  if(camRY > 1.5) {camRY = 1.5;}
  if(camRY < -1.5) {camRY = -1.5;}
  if(camRX > TWO_PI) {camRX = 0;}
  if(camRX < 0) {camRX = TWO_PI;}
  if(snapMouse) {robot.mouseMove(width/2, height/2);}
}

public void mouseDragged() {
  if(mouseY > height/2 && camRY < 1.5) {
    logMouseY = mouseY;
    camRY += (logMouseY-height/2)/400;
    //camRY += 0.03;
  } if(mouseY < height/2 && camRY > -1.5) {
    logMouseY = mouseY;
    camRY += (logMouseY-height/2)/400;
    //camRY -= 0.03;
  } if(mouseX > width/2) {
    logMouseX = mouseX;
    camRX += (logMouseX-width/2)/400;
  } if(mouseX < width/2) {
    logMouseX = mouseX;
    camRX += (logMouseX-width/2)/400;
    //camRX -= 0.03;
  }
  if(camRY > 1.5) {camRY = 1.5;}
  if(camRY < -1.5) {camRY = -1.5;}
  if(camRX > TWO_PI) {camRX = 0;}
  if(camRX < 0) {camRX = TWO_PI;}
  if(snapMouse) {robot.mouseMove(width/2, height/2);}
}

/*public void interactLine() {
  fill(255, 90);
  for(float i = 0; i < 50; i++) {
    float[] blockHighlighted = {Math.round(((me.x/10+i*cos(camRX)*cos(camRY)))), Math.round(-(me.y-eyeHeight)/10-i*sin(camRY)), Math.round(((me.z/10+i*sin(camRX)*cos(camRY))))};
    pushMatrix();
    translate(Math.round(((me.x/10+i*cos(camRX)*cos(camRY)))), Math.round(-(me.y-eyeHeight)/10-i*sin(camRY)), Math.round(((me.z/10+i*sin(camRX)*cos(camRY)))));
    translate(me.x+blockHighlighted[0], me.y-eyeHeight-blockHighlighted[1], me.z+blockHighlighted[2]);
    fill(i, 0, 0);
    box(1);
    popMatrix();
    System.out.println(blockHighlighted[0]+", "+blockHighlighted[1]+", "+blockHighlighted[2]);
    highlightedBlocks.add(blockHighlighted);
  }
  for(int i = 0; i < ground.size(); i++) {
    if(!highlightedBlocks.contains(ground.get(i))) {ground.get(i).highlighted = false;}
  }
  for(int i = 0; i < nearbyGround.size(); i++) {
    nearbyGround.get(i).nearby = true;
    int[] highlightCheck = {nearbyGround.get(i).xc, nearbyGround.get(i).yc, nearbyGround.get(i).zc};
    for(int n = 0; n < highlightedBlocks.size(); n++) {
      if(highlightedBlocks.get(n)[0] == highlightCheck[0] && highlightedBlocks.get(n)[1] == highlightCheck[1] && highlightedBlocks.get(n)[2] == highlightCheck[2]) {
        nearbyGround.get(i).highlighted = true;
        highlightedBlocks.clear();
        break;
      }
    }
  }
  //System.out.println(ground.size()+", "+nearbyGround.size());
  highlightedBlocks.clear();
  nearbyGround.clear();
}*/

public void moveCam() {
  camX = me.x+cos(camRX)*cos(camRY);
  camY = me.y-eyeHeight+sin(camRY);
  camZ = me.z+sin(camRX)*cos(camRY);
  perspective(PI/3.0, float(width)/float(height), ((height/2.0) / tan(PI*60.0/360.0))/2000, ((height/2.0) / tan(PI*60.0/360.0))*10);
  camera(me.x, me.y-eyeHeight, me.z, camX, camY, camZ, 0, 1, 0);
}

public void findLookAt() {
  for(int i = 0; i < 50; i++) {
    fill(5*i, 0, 0);
    noStroke();
    pushMatrix();
    translate(me.x, me.y-eyeHeight, me.z);
    rotateY(-camRX);
    rotateZ(camRY);
    translate(i, 0, 0);
    //box(0.5);
    hlX = modelX(0, 0, 0);
    hlY = modelY(0, 0, 0);
    hlZ = modelZ(0, 0, 0);
    popMatrix();
    float[] blockHighlighted = {hlX, hlY, hlZ};
    pushMatrix();
    translate(hlX, hlY, hlZ);
    //box(1);
    popMatrix();
    highlightedBlocks.add(blockHighlighted);
  }
  for(int i = 0; i < ground.size(); i++) {
    if(!highlightedBlocks.contains(ground.get(i))) {ground.get(i).highlighted = false;}
  }
  for(int i = 0; i < nearbyGround.size(); i++) {
    nearbyGround.get(i).nearby = true;
    float[] highlightCheck = {nearbyGround.get(i).x, nearbyGround.get(i).y, nearbyGround.get(i).z};
    for(int n = 0; n < highlightedBlocks.size(); n++) {
      if(Math.abs(highlightCheck[0]-highlightedBlocks.get(n)[0]) <= 5 && Math.abs(highlightCheck[1]-highlightedBlocks.get(n)[1]) <= 5 && Math.abs(highlightCheck[2]-highlightedBlocks.get(n)[2]) <= 5) {
        highlightCandidates.add(nearbyGround.get(i));
      }
    }
  }
  indexOfBlock = 0;
  float hdX = 5, hdY = 5, hdZ = 5;
  for(int i = 0; i < highlightCandidates.size(); i++) {
    if(Math.sqrt((highlightCandidates.get(i).x-me.x)*(highlightCandidates.get(i).x-me.x) + (highlightCandidates.get(i).y-me.y)*(highlightCandidates.get(i).y-me.y) + (highlightCandidates.get(i).z-me.z)*(highlightCandidates.get(i).z-me.z)) < Math.sqrt((hdX-me.x)*(hdX-me.x) + (hdY-me.y)*(hdY-me.y) + (hdZ-me.z)*(hdZ-me.z))) {
      hdX = highlightCandidates.get(i).x;
      hdY = highlightCandidates.get(i).y;
      hdZ = highlightCandidates.get(i).z;
      indexOfBlock = i;
    }
  }
  if(highlightCandidates.size() > 0) {
    highlightCandidates.get(indexOfBlock).highlighted = true;
  }
  highlightCandidates.clear();     
  highlightedBlocks.clear();
  nearbyGround.clear();
}

/*public void moveCam() {
  if(keys[0] && camRY < 1.5) {
    camRY += 0.07;
  } if(keys[1] && camRY > -1.5) {
    camRY -= 0.07;
  } if(keys[2]) {
    camRX += 0.07;
  } if(keys[3]) {
    camRX -= 0.07;
  }
  camX = me.x+cos(camRX)*cos(camRY);
  camY = me.y-eyeHeight+sin(camRY);
  camZ = me.z+sin(camRX)*cos(camRY);
  perspective(PI/3.0, float(width)/float(height), ((height/2.0) / tan(PI*60.0/360.0))/2000, ((height/2.0) / tan(PI*60.0/360.0))*10);
  camera(me.x, me.y-eyeHeight, me.z, camX, camY, camZ, 0, 1, 0);
}*/
