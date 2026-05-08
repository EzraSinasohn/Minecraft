class Ground {
  public int xc, yc, zc;
  public float x, y, z, l, w, h, r, g, b;
  public boolean stair, highlighted, nearby, placer, textured, commonSides;
  private boolean xNB, nxNB, yNB, nyNB, zNB, nzNB;
  public PImage texture;
  public PImage[] blockMap;
  public Ground(float xPos, float yPos, float zPos, float myLength, float myHeight, float myWidth, boolean s, float red, float green, float blue) {
    x = xPos*10;
    y = -yPos*10;
    z = zPos*10;
    l = myLength;
    w = myWidth;
    h = myHeight;
    stair = s;
    r = red;
    g = green;
    b = blue;
    xc = (int) (x/10);
    yc = (int) (-y/10);
    zc = (int) (z/10);
    textured = false;
  }
  
  public Ground(float xPos, float yPos, float zPos, float myLength, float myHeight, float myWidth, boolean s, PImage img) {
    x = xPos*10;
    y = -yPos*10;
    z = zPos*10;
    l = myLength;
    w = myWidth;
    h = myHeight;
    stair = s;
    texture = img;
    xc = (int) (x/10);
    yc = (int) (-y/10);
    zc = (int) (z/10);
    textured = true;
    commonSides = true;
  }
  
  public Ground(float xPos, float yPos, float zPos, float myLength, float myHeight, float myWidth, boolean s, PImage[] imgs) {
    x = xPos*10;
    y = -yPos*10;
    z = zPos*10;
    l = myLength;
    w = myWidth;
    h = myHeight;
    stair = s;
    blockMap = imgs;
    xc = (int) (x/10);
    yc = (int) (-y/10);
    zc = (int) (z/10);
    textured = true;
    commonSides = false;
  }
  
  public void show() {
    if(textured) {
      if(Math.sqrt((me.x-x)*(me.x-x) + (me.z-z)*(me.z-z)) < 300) {
        pushMatrix();
        translate(x, y, z);
        if(commonSides) {texturedBox(10, texture, (!yNB && checkPlayer()[3]), (!nyNB && checkPlayer()[2]), (!xNB && checkPlayer()[0]), (!nxNB && checkPlayer()[1]), (!zNB && checkPlayer()[4]), (!nzNB && checkPlayer()[5]));}
        else {texturedBox(10, blockMap, (!yNB && checkPlayer()[3]), (!nyNB && checkPlayer()[2]), (!xNB && checkPlayer()[0]), (!nxNB && checkPlayer()[1]), (!zNB && checkPlayer()[4]), (!nzNB && checkPlayer()[5]));}
        if(highlighted) {
          stroke(1);
          fill(0, 0);
          box(l, w, h);
        }
        popMatrix();
      }
    } else {
      noStroke();
      if(Math.sqrt((me.x-x)*(me.x-x) + (me.z-z)*(me.z-z)) < 300 /*&& screenY(x, y, z) <= height+300*/) {
        fill(r, g, b);
        //if(nearby) {fill(0, 255, 255);}
        if(highlighted) {
          stroke(1);
          //fill(0, 0, 255);
        }
        pushMatrix();
        translate(x, y, z);
        box(l, h, w);
        popMatrix();
      }
    }
  }
  
  /*public boolean[] neighbors() {
    boolean[] neighborCheck = {false, false, false, false, false, false};
    for(int i = 0; i < nearbyGround.size(); i++) {
      if(nearbyGround.get(i).xc == xc-1 && nearbyGround.get(i).yc == yc && nearbyGround.get(i).zc == zc) { //negX
        neighborCheck[0] = true;
      } if(nearbyGround.get(i).xc == xc+1 && nearbyGround.get(i).yc == yc && nearbyGround.get(i).zc == zc) { //posX
        neighborCheck[1] = true;
      } if(nearbyGround.get(i).xc == xc && nearbyGround.get(i).yc == yc-1 && nearbyGround.get(i).zc == zc) { //negY
        neighborCheck[2] = true;
      } if(nearbyGround.get(i).xc == xc && nearbyGround.get(i).yc == yc+1 && nearbyGround.get(i).zc == zc) { //posY
        neighborCheck[3] = true;
      } if(nearbyGround.get(i).xc == xc && nearbyGround.get(i).yc == yc && nearbyGround.get(i).zc == zc-1) { //negZ
        neighborCheck[4] = true;
      } if(nearbyGround.get(i).xc == xc && nearbyGround.get(i).yc == yc && nearbyGround.get(i).zc == zc+1) { //posZ
        neighborCheck[5] = true;
      }
    }
    return neighborCheck;
  }*/
  

  
  /*public boolean[] neighbors() {
    boolean[] neighborCheck = {false, false, false, false, false, false};
    xNB = false;
    nxNB = false;
    yNB = false;
    nyNB = false;
    zNB = false;
    nzNB = false;
    for(int i = 0; i < ground.size(); i++) {
      if(Math.sqrt((me.x-ground.get(i).x)*(me.x-ground.get(i).x)+(me.y-ground.get(i).y)*(me.y-ground.get(i).y)+(me.z-ground.get(i).z)*(me.z-ground.get(i).z)) < 80) {
        if(ground.get(i).xc == xc-1 && ground.get(i).yc == yc && ground.get(i).zc == zc) { //negX
          neighborCheck[0] = true;
          nxNB = true;
        } if(ground.get(i).xc == xc+1 && ground.get(i).yc == yc && ground.get(i).zc == zc) { //posX
          neighborCheck[1] = true;
          xNB = true;
        } if(ground.get(i).xc == xc && ground.get(i).yc == yc-1 && ground.get(i).zc == zc) { //negY
          neighborCheck[2] = true;
          nyNB = true;
        } if(ground.get(i).xc == xc && ground.get(i).yc == yc+1 && ground.get(i).zc == zc) { //posY
          neighborCheck[3] = true;
          yNB = true;
        } if(ground.get(i).xc == xc && ground.get(i).yc == yc && ground.get(i).zc == zc-1) { //negZ
          neighborCheck[4] = true;
          nzNB = true;
        } if(ground.get(i).xc == xc && ground.get(i).yc == yc && ground.get(i).zc == zc+1) { //posZ
          neighborCheck[5] = true;
          zNB = true;
        }
      }
    }
    return neighborCheck;
  }*/
    
    
  public boolean[] initialNeighbors() {
    boolean[] neighborCheck = {false, false, false, false, false, false};
    xNB = false;
    nxNB = false;
    yNB = false;
    nyNB = false;
    zNB = false;
    nzNB = false;
    for(int i = 0; i < ground.size(); i++) {
        if(ground.get(i).xc == xc-1 && ground.get(i).yc == yc && ground.get(i).zc == zc) { //negX
          neighborCheck[0] = true;
          nxNB = true;
        } if(ground.get(i).xc == xc+1 && ground.get(i).yc == yc && ground.get(i).zc == zc) { //posX
          neighborCheck[1] = true;
          xNB = true;
        } if(ground.get(i).xc == xc && ground.get(i).yc == yc-1 && ground.get(i).zc == zc) { //negY
          neighborCheck[2] = true;
          nyNB = true;
        } if(ground.get(i).xc == xc && ground.get(i).yc == yc+1 && ground.get(i).zc == zc) { //posY
          neighborCheck[3] = true;
          yNB = true;
        } if(ground.get(i).xc == xc && ground.get(i).yc == yc && ground.get(i).zc == zc-1) { //negZ
          neighborCheck[4] = true;
          nzNB = true;
        } if(ground.get(i).xc == xc && ground.get(i).yc == yc && ground.get(i).zc == zc+1) { //posZ
          neighborCheck[5] = true;
          zNB = true;
        }
      }
    return neighborCheck;
  }
  
  public boolean[] checkPlayer() {
    boolean[] playerCheck = {false, false, false, false, false, false};
    if(me.x > x+l-me.l) {playerCheck[0] = true;}
    if(me.x < x-l+me.l) {playerCheck[1] = true;}
    if(me.y-eyeHeight > y+h-me.h) {playerCheck[2] = true;}
    if(me.y-eyeHeight < y-h+me.h) {playerCheck[3] = true;}
    if(me.z > z+w-me.w) {playerCheck[4] = true;}
    if(me.z < z-w+me.w) {playerCheck[5] = true;}
    return playerCheck;
  }
  
  
  public float[] sides() {
    float[] dim = {y-h/2, y+h/2, x-l/2, x+l/2, z-w/2, z+w/2};
    return dim;
  }
  
  
  public float top = y-h/2;
  public float bottom = y+h/2;
  public float front = x+l/2;
  public float back = x-l/2;
  public float left = x-w/2;
  public float right = z-w/2;
}
