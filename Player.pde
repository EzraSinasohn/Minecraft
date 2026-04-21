public boolean[] keys = new boolean[11];
public boolean crouching = true;
public int[] crouchBlock;
public float eyeHeight = 8.1;
class Player {
  int xc, yc, zc;
  float x, y, z, l, w, h, rotation, vx, vy, vz, vxs, vxc, vzs, vzc, sprint, limbR, speed = 0.55, crouchSpeed = 1;
  boolean jump = false, gravity = true, xPosSideCol = false, zPosSideCol = false, xNegSideCol = false, zNegSideCol = false, canDash = false;
  public Player(float xPos, float yPos, float zPos, float myLength, float myHeight, float myWidth) {
    x = xPos;
    y = yPos;
    z = zPos;
    l = myLength;
    w = myWidth;
    h = myHeight;
  }
  
  public void show() {
    translate(x, y-eyeHeight, z);
    rotateY(-camRX);
    rotateZ(camRY);
    translate(10, 4.1, 5);
    rotateX(PI/4);
    rotateZ(PI/5);
    fill(255, 120, 0);
    box(2, 4, 2);
    /*rotateX(-PI/4);
    rotateZ(-PI/5);
    rotateY(-PI/2);
    translate(-30, 0, -30);
    fill(255);
    textSize(10);
    text(me.y, 0, 0);*/
  }
  
  public void move() {
    if(keys[10]) {
      eyeHeight = 5.1;
      //h = 15;
    } else {
      eyeHeight = 8.1;
      //h = 20;
    }
    if(keys[9] && !keys[10]) {sprint = 1.6;} else {sprint = 1;}
    if(keys[10]) {crouchSpeed = 0.347;} else {crouchSpeed = 1;}
    if(keys[8] && jump) {
      jump = false;
      vy = -1.3;
    } if(keys[4]) {  //DOWN
      rotation = camRX+PI;
      vxc = -cos(camRX)*speed*crouchSpeed;
      vzs = -sin(camRX)*speed*crouchSpeed;
    } if(keys[5]) {  //UP
      rotation = camRX;
      vxc = cos(camRX)*speed*sprint*crouchSpeed;
      vzs = sin(camRX)*speed*sprint*crouchSpeed;
    } if(keys[6]) {  //LEFT
      rotation = camRX+PI/2;
      vxs = -sin(camRX)*speed*crouchSpeed;
      vzc = cos(camRX)*speed*crouchSpeed;
    } if(keys[7]) {  //RIGHT
      rotation = camRX-PI/2;
      vxs = sin(camRX)*speed*crouchSpeed;
      vzc = -cos(camRX)*speed*crouchSpeed;
    } if(keys[4] && keys[6]) {rotation = camRX+PI-PI/4;}
    if(keys[4] && keys[7]) {rotation = camRX+PI+PI/4;}
    if(keys[5] && keys[6]) {rotation = camRX+PI+PI/4;}
    if(keys[5] && keys[7]) {rotation = camRX+PI-PI/4;}
    vx = vxs + vxc;
    vz = vzs + vzc;
    if(xPosSideCol && vx > 0 && (Math.abs(vx) > Math.abs(vz) || vx == 0)) {vx = 0;}
    if(xNegSideCol && vx < 0 && (Math.abs(vx) > Math.abs(vz) || vx == 0)) {vx = 0;}
    if(zPosSideCol && vz > 0 && (Math.abs(vz) > Math.abs(vx) || vz == 0)) {vz = 0;}
    if(zNegSideCol && vz < 0 && (Math.abs(vz) > Math.abs(vx) || vz == 0)) {vz = 0;}
    x += vx;
    y += vy;
    z += vz;
    if(jump) {
      if(!(keys[6] || keys[7])) {
        if(xNegSideCol) {vxs = 0;} else {vxs *= 0.85;}
      }
      if(!(keys[4] || keys[5])) {
        if(xPosSideCol) {vxc = 0;} else {vxc *= 0.85;}
      }
      if(!(keys[4] || keys[5])) {
        if(zNegSideCol) {vzs = 0;} else {vzs *= 0.85;}
      }
      if(!(keys[6] || keys[7])) {
        if(zPosSideCol) {vzc = 0;} else {vzc *= 0.85;}
      }
    } else {
      if(!(keys[6] || keys[7])) {
        if(xNegSideCol) {vxs = 0;} else {vxs *= 0.85;}
      }
      if(!(keys[4] || keys[5])) {
        if(xPosSideCol) {vxc = 0;} else {vxc *= 0.85;}
      }
      if(!(keys[4] || keys[5])) {
        if(zNegSideCol) {vzs = 0;} else {vzs *= 0.85;}
      }
      if(!(keys[6] || keys[7])) {
        if(zPosSideCol) {vzc = 0;} else {vzc *= 0.85;}
      }
    }
    //show();
    if(vy < 3 && gravity) {vy += 0.08;}
    gravity = true;
    xPosSideCol = false;
    zPosSideCol = false;
    xNegSideCol = false;
    zNegSideCol = false;
    if(y > 100) {
      x = 0;
      y = -250;
      z = 0;
    }
    xc = (int) ((x-5)/10);
    yc = (int) (-(y+5)/10);
    zc = (int) ((z-5)/10);
  }
  
  public void collision(Ground obj) {
    if(yc == obj.yc || yc+1 == obj.yc) {
      if(Math.abs(x-obj.x-obj.l/2) < l/2 && Math.abs(z-obj.z) < w/2+obj.w/2) {xPosSideCol = true;}
      if(Math.abs(x-obj.x+obj.l/2) < l/2 && Math.abs(z-obj.z) < w/2+obj.w/2) {xNegSideCol = true;}
      if(Math.abs(z-obj.z-obj.w/2) < w/2 && Math.abs(x-obj.x) < l/2+obj.l/2) {zPosSideCol = true;}
      if(Math.abs(z-obj.z+obj.w/2) < w/2 && Math.abs(x-obj.x) < l/2+obj.l/2) {zNegSideCol = true;}
    } 
    if(((sides(obj)[0] < 0 && sides(obj)[1] < h) || (sides(obj)[0] < 0 && sides(obj)[1] < 0)) && ((sides(obj)[2] < 0 && sides(obj)[3] < l) || (sides(obj)[2] < 0 && sides(obj)[3] < 0)) && ((sides(obj)[4] < 0 && sides(obj)[5] < w) || (sides(obj)[4] < 0 && sides(obj)[5] < 0))) {
      if(((y+vy < obj.y+obj.h/2+h/2) && (y+vy > obj.y+3*obj.h/8+3*h/8) && vy < 0 && !obj.neighbors()[2])/* || (sides(obj)[0] > sides(obj)[1] && sides(obj)[0] > sides(obj)[2] && sides(obj)[0] > sides(obj)[3] && sides(obj)[0] > sides(obj)[4] && sides(obj)[0] > sides(obj)[5])*/) { 
        vy = 0;
        y = obj.y+obj.h/2+h/2-2*vy;
      } else if(((y+vy > obj.y-obj.h/2-h/2) && (y+vy < obj.y-3*obj.h/8-3*h/8) && vy > 0) && !obj.neighbors()[3]) {//sides(obj)[1] > sides(obj)[0] && sides(obj)[1] > sides(obj)[2] && sides(obj)[1] > sides(obj)[3] && sides(obj)[1] > sides(obj)[4] && sides(obj)[1] > sides(obj)[5]) { 
        jump = true;
        gravity = false;
        canDash = true;
        vy = 0;
        y = obj.y-obj.h/2-h/2-2*vy;
      } if(((yc == obj.yc || yc+1 == obj.yc) && (x+vx < obj.x+obj.l/2+l/2) && (x+vx > obj.x+3*obj.l/8+3*l/8) && vx < 0 && !obj.neighbors()[1]) /*sides(obj)[2] > sides(obj)[0] && sides(obj)[2] > sides(obj)[1] && sides(obj)[2] > sides(obj)[3] && sides(obj)[2] > sides(obj)[4] && sides(obj)[2] > sides(obj)[5]*/) { 
        //xNegSideCol = true;
        x = obj.x+obj.l/2+l/2-vx;
      } if(((yc == obj.yc || yc+1 == obj.yc) && (x+vx > obj.x-obj.l/2-l/2) && (x+vx < obj.x-3*obj.l/8-3*l/8) && vx > 0) && !obj.neighbors()[0]) {//sides(obj)[3] > sides(obj)[0] && sides(obj)[3] > sides(obj)[1] && sides(obj)[3] > sides(obj)[2] && sides(obj)[3] > sides(obj)[4] && sides(obj)[3] > sides(obj)[5]) { 
        //xPosSideCol = true;
        x = obj.x-obj.l/2-l/2-vx;
      } if(((yc == obj.yc || yc+1 == obj.yc) && (z+vz < obj.z+obj.w/2+w/2) && (z+vz > obj.z+3*obj.w/8+3*w/8) && vz < 0) && !obj.neighbors()[5]) {//sides(obj)[4] > sides(obj)[0] && sides(obj)[4] > sides(obj)[1] && sides(obj)[4] > sides(obj)[2] && sides(obj)[4] > sides(obj)[3] && sides(obj)[4] > sides(obj)[5]) { 
        //zNegSideCol = true;
        z = obj.z+obj.w/2+w/2-vz;
      } if(((yc == obj.yc || yc+1 == obj.yc) && (z+vz > obj.z-obj.w/2-w/2) && (z+vz < obj.z-3*obj.w/8-3*w/8) && vz > 0) && !obj.neighbors()[4]) {//sides(obj)[5] > sides(obj)[0] && sides(obj)[5] > sides(obj)[1] && sides(obj)[5] > sides(obj)[2] && sides(obj)[5] > sides(obj)[3] && sides(obj)[5] > sides(obj)[4]) { 
        //zPosSideCol = true;
        z = obj.z-obj.w/2-w/2-vz;
      }
    }
  }
  
  
  public float[] sides(Ground obj) {
    float[] dim = {y+vy-h/2-(obj.y+obj.h/2), -y-vy+h/2+(obj.y-obj.h/2), x+vx-l/2-(obj.x+obj.l/2), -x-vx+l/2+(obj.x-obj.l/2), z+vz-w/2-(obj.z+obj.w/2), -z-vz+w/2+(obj.z-obj.w/2)};
    return dim;
  }
  
  public float[][] cornerCheck() {
    float[] tempCorner1 = {me.x+3, me.z+3};
    float[] tempCorner2 = {me.x+3, me.z-3};
    float[] tempCorner3 = {me.x-3, me.z+3};
    float[] tempCorner4 = {me.x-3, me.z-3};
    float[][] tempCorners = {tempCorner1, tempCorner2, tempCorner3, tempCorner4};
    return tempCorners;
  }
}


public void keyPressed() {
  if(key == 'm') {
    snapMouse = !snapMouse;
  } if(keyCode == SHIFT) {
    keys[10] = true;
    if(!crouching) {
      int[] tempCrouchBlock = {me.xc, me.zc};
      crouchBlock = tempCrouchBlock;
    }
    crouching = true;
  } if(key == 'r' || keyCode == CONTROL) {
    keys[9] = true;
  } if(key == ' ') {
    keys[8] = true;
  } if(key == 'a' || key == 'A') {
    keys[7] = true;
  } if(key == 'd' || key == 'D') {
    keys[6] = true;
  } if(key == 'w' || key == 'W') {
    keys[5] = true;
  } if(key == 's' || key == 'S') {
    keys[4] = true;
  } if(keyCode == LEFT) {
    keys[7] = true;
  } if(keyCode == RIGHT) {
    keys[6] = true;
  } if(keyCode == UP) {
    keys[5] = true;
  } if(keyCode == DOWN) {
    keys[4] = true;
  } if(key == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == '6' || key == '7' || key == '8' || key == '9') {
    hotbarSlot = Character.getNumericValue(key)-1;
  }
}

public void keyReleased() {
  if(keyCode == SHIFT) {
    keys[10] = false;
    crouching = false;
  } if(key == 'r' || keyCode == CONTROL) {
    keys[9] = false;
  } if(key == ' ') {
    keys[8] = false;
  } if(key == 'a' || key == 'A') {
    keys[7] = false;
  } if(key == 'd' || key == 'D') {
    keys[6] = false;
  } if(key == 'w' || key == 'W') {
    keys[5] = false;
  } if(key == 's' || key == 'S') {
    keys[4] = false;
  } if(keyCode == LEFT) {
    keys[7] = false;
  } if(keyCode == RIGHT) {
    keys[6] = false;
  } if(keyCode == UP) {
    keys[5] = false;
  } if(keyCode == DOWN) {
    keys[4] = false;
  }
}

public boolean moveKeys() {return keys[4] || keys[5] || keys[6] || keys[7];}
