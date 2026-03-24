class Ground {
  public float x, y, z, l, w, h;
  public boolean stair;
  public Ground(float xPos, float yPos, float zPos, float myLength, float myHeight, float myWidth, boolean s) {
    x = xPos;
    y = yPos;
    z = zPos;
    l = myLength;
    w = myWidth;
    h = myHeight;
    stair = s;
  }
  
  public void show() {
    fill(0, 100, 100);
    pushMatrix();
    translate(x, y, z);
    box(l, h, w);
    popMatrix();
  }
  
  public float[][][] boundingBox() {
    float[][] u = {{x+l/2, y-h/2, z+w/2}, {x-l/2, y-h/2, z+w/2}, {x+l/2, y-h/2, z-w/2}, {x-l/2, y-h/2, z-w/2}};
    float[][] d = {{x+l/2, y+h/2, z+w/2}, {x-l/2, y+h/2, z+w/2}, {x+l/2, y+h/2, z-w/2}, {x-l/2, y+h/2, z-w/2}};
    float[][] lt = {{x+l/2, y+h/2, z+w/2}, {x-l/2, y+h/2, z+w/2}, {x+l/2, y-h/2, z+w/2}, {x-l/2, y-h/2, z+w/2}};
    float[][] rt = {{x+l/2, y+h/2, z-w/2}, {x-l/2, y+h/2, z-w/2}, {x+l/2, y-h/2, z-w/2}, {x-l/2, y-h/2, z-w/2}};
    float[][] f = {{x+l/2, y+h/2, z+w/2}, {x+l/2, y+h/2, z-w/2}, {x+l/2, y-h/2, z+w/2}, {x+l/2, y-h/2, z-w/2}};
    float[][] b = {{x-l/2, y+h/2, z+w/2}, {x-l/2, y+h/2, z-w/2}, {x-l/2, y-h/2, z+w/2}, {x-l/2, y-h/2, z-w/2}};
    float[][][] box = {u, d, lt, rt, f, b};
    fill(0, 255, 0, 50);
    pushMatrix();
    translate(0, box[0][0][1], 0);
    rotateX(PI/2);
    rect(box[0][0][0], box[0][0][2], box[0][3][0], box[0][3][2]);
    popMatrix();
    pushMatrix();
    translate(0, box[1][0][1], 0);
    rotateX(PI/2);
    rect(box[1][0][0], box[1][0][2], box[1][3][0], box[1][3][2]);
    popMatrix();
    pushMatrix();
    translate(0, 0, box[2][0][2]);
    rect(box[2][0][0], box[2][0][1], box[2][3][0], box[2][3][1]);
    popMatrix();
    pushMatrix();
    translate(0, 0, box[3][0][2]);
    rect(box[3][0][0], box[3][0][1], box[3][3][0], box[3][3][1]);
    popMatrix();
    pushMatrix();
    translate(box[4][0][0], 0, 0);
    rotateZ(PI/2);
    rotateX(PI/2);
    rect(box[5][0][1], box[5][0][2], box[5][3][1], box[5][3][2]);
    popMatrix();
    pushMatrix();
    translate(box[5][0][0], 0, 0);
    rotateZ(PI/2);
    rotateX(PI/2);
    rect(box[5][0][1], box[5][0][2], box[5][3][1], box[5][3][2]);
    popMatrix();
    return box;
  }
  
  public float[] sides() {
    float[] dim = {y-h/2, y+h/2, x-l/2, x+l/2, z-w/2, z+w/2};
    return dim;
  }
  
  public float[][] up() {return boundingBox()[0];}
  public float[][] down() {return boundingBox()[1];}
  public float[][] left() {return boundingBox()[2];}
  public float[][] right() {return boundingBox()[3];}
  public float[][] front() {return boundingBox()[4];}
  public float[][] back() {return boundingBox()[5];}
}

public void stairs(float x, float y, float z, float l, float h, float w, float r) {
  for(float i = 0; i < 10; i++) {
    ground.add(new Ground(x-l+i*l/20, y-h+i*h/10, z, i*l/10, h/10, w, true));
  }
}
