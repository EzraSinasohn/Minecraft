public boolean[] keys = new boolean[10];
class Player {
  float x, y, z, l, w, h, rotation, vx, vy, vz, vxs, vxc, vzs, vzc, sprint, limbR;
  boolean jump = false, gravity = true, sideCol = false, canDash = false;
  public Player(float xPos, float yPos, float zPos, float myLength, float myWidth, float myHeight) {
    x = xPos;
    y = yPos;
    z = zPos;
    l = myLength;
    w = myWidth;
    h = myHeight;
  }
  
  public void show() {
    pushMatrix();
    fill(255, 0, 0);
    translate(x, y, z);
    rotateY(-rotation);
    playerModel(l, h, w, cos(limbR));
    popMatrix();
  }
  
  public void playerModel(float len, float hei, float wid, float limb) {
    pushMatrix();
    fill(255, 0, 0);
    box(len/2, hei/2, wid/2);
    fill(255, 120, 0);
    translate(0, -3*hei/8, 0);
    noStroke();
    sphere(len/4);
    translate(0, hei/8, 3*wid/8);
    rotateZ(limb);
    translate(0, hei/4, 0);
    box(len/4, hei/2, wid/4);
    translate(0, -hei/4, 0);
    rotateZ(-limb);
    translate(0, 0, -3*wid/4);
    rotateZ(-limb);
    translate(0, hei/4, 0);
    box(len/4, hei/2, wid/4);
    translate(0, -hei/4, 0);
    rotateZ(limb);
    translate(0, 3*hei/8, wid/2);
    rotateZ(limb);
    translate(0, hei/4, 0);
    fill(0, 0, 120);
    box(len/4, hei/4, wid/4);
    translate(0, -hei/4, 0);
    rotateZ(-2*limb);
    translate(0, hei/4, -wid/4);
    box(len/4, hei/4, wid/4);
    popMatrix();
  }
  
  public void move() {
    if(keys[9]) {sprint = 2;} else {sprint = 1;}
    if(keys[8] && jump) {
      jump = false;
      vy = -5;
    } if(keys[4]) {
      rotation = camRX+PI;
      vxc = cos(camRX)*sprint;
      vzs = sin(camRX)*sprint;
    } if(keys[5]) {
      rotation = camRX;
      vxc = -cos(camRX)*sprint;
      vzs = -sin(camRX)*sprint;
    } if(keys[6]) {
      rotation = camRX+PI/2;
      vxs = sin(camRX)*sprint;
      vzc = -cos(camRX)*sprint;
    } if(keys[7]) {
      rotation = camRX-PI/2;
      vxs = -sin(camRX)*sprint;
      vzc = cos(camRX)*sprint;
    } if(keys[4] && keys[6]) {rotation = PI-PI/4;}
    if(keys[4] && keys[7]) {rotation = PI+PI/4;}
    if(keys[5] && keys[6]) {rotation = PI+PI/4;}
    if(keys[5] && keys[7]) {rotation = PI-PI/4;}
    vx = vxs + vxc;
    vz = vzs + vzc;
    x += vx;
    y += vy;
    z += vz;
    if(!(keys[6] || keys[7])) {
      if(sideCol) {vxs = 0;} else {vxs *= 0.9;}
    }
    if(!(keys[4] || keys[5])) {
      if(sideCol) {vxc = 0;} else {vxc *= 0.9;}
    }
    if(!(keys[4] || keys[5])) {
      if(sideCol) {vzs = 0;} else {vzs *= 0.9;}
    }
    if(!(keys[6] || keys[7])) {
      if(sideCol) {vzc = 0;} else {vzc *= 0.9;}
    }
    if(keys[4] || keys[5] || keys[6] || keys[7]) {
      limbR += sqrt(vx*vx+vz*vz)*PI/24;
    } else {
      limbR = PI/2;
    }
    if(limbR > TWO_PI) {limbR -= TWO_PI;}
    show();
    if(vy < 4 && gravity) {vy += 0.3;}
    gravity = true;
    sideCol = false;
    if(y > 100) {
      x = 0;
      y = -25;
      z = 0;
    }
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
  
  public void collision(Ground obj) {
    if(((sides(obj)[0] < 0 && sides(obj)[1] < h) || (sides(obj)[0] < 0 && sides(obj)[1] < 0)) && ((sides(obj)[2] < 0 && sides(obj)[3] < l) || (sides(obj)[2] < 0 && sides(obj)[3] < 0)) && ((sides(obj)[4] < 0 && sides(obj)[5] < w) || (sides(obj)[4] < 0 && sides(obj)[5] < 0))) {
      if(((y < obj.y+obj.h/2+h/2) && (y > obj.y+3*obj.h/8+3*h/8) && vy < 0)/* || (sides(obj)[0] > sides(obj)[1] && sides(obj)[0] > sides(obj)[2] && sides(obj)[0] > sides(obj)[3] && sides(obj)[0] > sides(obj)[4] && sides(obj)[0] > sides(obj)[5])*/) { 
        vy = 0;
        y = obj.y+obj.h/2+h/2;
      } else if(sides(obj)[1] > sides(obj)[0] && sides(obj)[1] > sides(obj)[2] && sides(obj)[1] > sides(obj)[3] && sides(obj)[1] > sides(obj)[4] && sides(obj)[1] > sides(obj)[5]) { 
        jump = true;
        gravity = false;
        canDash = true;
        vy = 0;
        y = obj.y-obj.h/2-h/2;
      } else if(((x < obj.x+obj.l/2+l/2) && (x > obj.x+3*obj.l/8+3*l/8) && vx < 0) /*sides(obj)[2] > sides(obj)[0] && sides(obj)[2] > sides(obj)[1] && sides(obj)[2] > sides(obj)[3] && sides(obj)[2] > sides(obj)[4] && sides(obj)[2] > sides(obj)[5]*/) { 
        sideCol = true;
        x = obj.x+obj.l/2+l/2;
      } else if(sides(obj)[3] > sides(obj)[0] && sides(obj)[3] > sides(obj)[1] && sides(obj)[3] > sides(obj)[2] && sides(obj)[3] > sides(obj)[4] && sides(obj)[3] > sides(obj)[5]) { 
        sideCol = true;
        x = obj.x-obj.l/2-l/2;
      } else if(sides(obj)[4] > sides(obj)[0] && sides(obj)[4] > sides(obj)[1] && sides(obj)[4] > sides(obj)[2] && sides(obj)[4] > sides(obj)[3] && sides(obj)[4] > sides(obj)[5]) { 
        sideCol = true;
        z = obj.z+obj.w/2+w/2;
      } else if(sides(obj)[5] > sides(obj)[0] && sides(obj)[5] > sides(obj)[1] && sides(obj)[5] > sides(obj)[2] && sides(obj)[5] > sides(obj)[3] && sides(obj)[5] > sides(obj)[4]) { 
        sideCol = true;
        z = obj.z-obj.w/2-w/2;
      }
    }
  }
  
  /*public void footCollision(Ground obj) {
    boolean corner = false;
    if(((down()[0][0] < obj.up()[0][0] && down()[3][0] < obj.up()[3][0]+l/2 && down()[0][2] < obj.up()[0][2] && down()[3][2] < obj.up()[3][2]+w/2))) {
      
    }
  }*/
  
  public float[] sides(Ground obj) {
    float[] dim = {y+vy-h/2-(obj.y+obj.h/2), -y-vy+h/2+(obj.y-obj.h/2), x+vx-l/2-(obj.x+obj.l/2), -x-vx+l/2+(obj.x-obj.l/2), z+vz-w/2-(obj.z+obj.w/2), -z-vz+w/2+(obj.z-obj.w/2)};
    return dim;
  }
  
  public float[][] up() {return boundingBox()[0];}
  public float[][] down() {return boundingBox()[1];}
  public float[][] left() {return boundingBox()[2];}
  public float[][] right() {return boundingBox()[3];}
  public float[][] front() {return boundingBox()[4];}
  public float[][] back() {return boundingBox()[5];}
}

public void moveCam() {
  if(keys[0] && camRY < 1.5) {
    camRY += 0.05;
  } if(keys[1] && camRY > -1.5) {
    camRY -= 0.05;
  } if(keys[2]) {
    camRX += 0.05;
  } if(keys[3]) {
    camRX -= 0.05;
  }
  camX = cos(camRX)*cos(camRY)*100;
  camY = sin(camRY)*100;
  camZ = sin(camRX)*cos(camRY)*100;
  camVY += (me.y+camY-camVY)/30;
  camera(me.x+camX, me.y+camY, me.z+camZ, me.x, me.y, me.z, 0, 1, 0);
}

public void keyPressed() {
  if(key == 'r') {
    keys[9] = true;
  } if(key == ' ') {
    keys[8] = true;
  } if(key == 'a') {
    keys[7] = true;
  } if(key == 'd') {
    keys[6] = true;
  } if(key == 'w') {
    keys[5] = true;
  } if(key == 's') {
    keys[4] = true;
  } if(keyCode == LEFT) {
    keys[3] = true;
  } if(keyCode == RIGHT) {
    keys[2] = true;
  } if(keyCode == UP) {
    keys[1] = true;
  } if(keyCode == DOWN) {
    keys[0] = true;
  }
}

public void keyReleased() {
  if(key == 'r') {
    keys[9] = false;
  } if(key == ' ') {
    keys[8] = false;
  } if(key == 'a') {
    keys[7] = false;
  } if(key == 'd') {
    keys[6] = false;
  } if(key == 'w') {
    keys[5] = false;
  } if(key == 's') {
    keys[4] = false;
  } if(keyCode == LEFT) {
    keys[3] = false;
  } if(keyCode == RIGHT) {
    keys[2] = false;
  } if(keyCode == UP) {
    keys[1] = false;
  } if(keyCode == DOWN) {
    keys[0] = false;
  }
}

public boolean moveKeys() {return keys[4] || keys[5] || keys[6] || keys[7];}
