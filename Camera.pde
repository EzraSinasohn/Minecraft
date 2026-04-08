public boolean snapMouse = true;
public float logMouseX, logMouseY, hlX, hlY, hlZ, plX, plY, plZ;
public float punchTimer = 0;
public int indexOfBlock = 0;
public float[] placeBlock;
public ArrayList <float[]> highlightedBlocks = new ArrayList<float[]>();
public ArrayList <float[]> placerBlocks = new ArrayList<float[]>();
public ArrayList <float[]> placerCandidates = new ArrayList<float[]>();
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

public void moveCam() {
  camX = me.x+cos(camRX)*cos(camRY);
  camY = me.y-eyeHeight+sin(camRY);
  camZ = me.z+sin(camRX)*cos(camRY);
  perspective(PI/3.0, float(width)/float(height), ((height/2.0) / tan(PI*60.0/360.0))/2000, ((height/2.0) / tan(PI*60.0/360.0))*10);
  camera(me.x, me.y-eyeHeight, me.z, camX, camY, camZ, 0, 1, 0);
}

public void findPlacerCandidates() {
  placerCandidates.clear();   
  placerBlocks.clear();
  for(int i = 0; i < 50; i++) {
    fill(5*i, 0, 0);
    noStroke();
    pushMatrix();
    translate(me.x, me.y-eyeHeight, me.z);
    rotateY(-camRX);
    rotateZ(camRY);
    translate(i, 0, 0);
    //box(0.5);
    plX = modelX(0, 0, 0);
    plY = modelY(0, 0, 0);
    plZ = modelZ(0, 0, 0);
    popMatrix();
    float[] blockHighlighted = {plX, plY, plZ};
    pushMatrix();
    translate(plX, plY, plZ);
    //box(1);
    popMatrix();
    placerBlocks.add(i, blockHighlighted);
  }
  for(int i = 0; i < nearbyGround.size(); i++) {
    nearbyGround.get(i).nearby = true;
    float[] placerCheck = {nearbyGround.get(i).x, nearbyGround.get(i).y, nearbyGround.get(i).z};
    for(int n = placerBlocks.size()-1; n >= 0; n--) {
      if(Math.abs(placerCheck[0]-placerBlocks.get(n)[0]) > 5 || Math.abs(placerCheck[1]-placerBlocks.get(n)[1]) > 5 || Math.abs(placerCheck[2]-placerBlocks.get(n)[2]) > 5) {
        placerCandidates.add(placerBlocks.get(n));
      }
    }
  }
  for(int n = 0; n < placerCandidates.size(); n++) {
    for(int i = 0; i < placerCandidates.size()-1; i++) {
      if(Math.sqrt((placerCandidates.get(i)[0]-me.x)*(placerCandidates.get(i)[0]-me.x)+(placerCandidates.get(i)[1]-me.y)*(placerCandidates.get(i)[1]-me.y)+(placerCandidates.get(i)[2]-me.z)*(placerCandidates.get(i)[2]-me.z)) < Math.sqrt((placerCandidates.get(i+1)[0]-me.x)*(placerCandidates.get(i+1)[0]-me.x)+(placerCandidates.get(i+1)[1]-me.y)*(placerCandidates.get(i+1)[1]-me.y)+(placerCandidates.get(i+1)[2]-me.z)*(placerCandidates.get(i+1)[2]-me.z))) {
        placerCandidates.remove(i);
      }
    }
  }
  if(highlightCandidates.size() == 0) {
    placerCandidates.clear();
  }
  nearbyGround.clear();
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
  for(int n = 0; n < highlightCandidates.size(); n++) {
    for(int i = 0; i < highlightCandidates.size()-1; i++) {
      if(Math.sqrt((highlightCandidates.get(i).x-me.x)*(highlightCandidates.get(i).x-me.x)+(highlightCandidates.get(i).y-me.y)*(highlightCandidates.get(i).y-me.y)+(highlightCandidates.get(i).z-me.z)*(highlightCandidates.get(i).z-me.z)) > Math.sqrt((highlightCandidates.get(i+1).x-me.x)*(highlightCandidates.get(i+1).x-me.x)+(highlightCandidates.get(i+1).y-me.y)*(highlightCandidates.get(i+1).y-me.y)+(highlightCandidates.get(i+1).z-me.z)*(highlightCandidates.get(i+1).z-me.z))) {
        Ground temp = highlightCandidates.get(i);
        highlightCandidates.set(i, highlightCandidates.get(i+1));
        highlightCandidates.set(i+1, temp);
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
    highlightCandidates.get(0).highlighted = true;
  }
  findPlacerCandidates();
  highlightCandidates.clear();     
  highlightedBlocks.clear();
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
