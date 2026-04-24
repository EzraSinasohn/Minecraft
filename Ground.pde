class Ground {
  public int xc, yc, zc;
  public float x, y, z, l, w, h, r, g, b;
  public boolean stair, highlighted, nearby, placer;
  public PImage texture;
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
  }
  
  public void show() {
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
  
  public boolean[] neighbors() {
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
