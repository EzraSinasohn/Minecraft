ArrayList<Entity> entities = new ArrayList<Entity>();
class Entity {
  int xc, yc, zc, hitTime = 0;
  float x, y, z, l, w, h, rotation, vx, vy, vz, vxs, vxc, vzs, vzc, sprint, limbR, speed = 0.55, crouchSpeed = 1, health = 10;
  boolean jump = false, gravity = true, xPosSideCol = false, zPosSideCol = false, xNegSideCol = false, zNegSideCol = false, canDash = false, highlighted = false;
  public Entity(float xPos, float yPos, float zPos, float myLength, float myHeight, float myWidth) {
    x = xPos;
    y = yPos;
    z = zPos;
    l = myLength;
    w = myWidth;
    h = myHeight;
  }
  
  public void show() {
    stroke(1);
    fill(150);
    if(millis()-hitTime < 100) {fill(255, 0, 0);}
    pushMatrix();
    translate(x, y, z);
    box(l, h, w);
    popMatrix();
  }
  
  public void move() {
    //vx = vxs + vxc;
    //vz = vzs + vzc;
    if(millis()%3 == 0 && Math.random() < 0.05) {
      if(Math.random() < 0.5) {
        vx = (float) (Math.random()-0.5);
        vz = (float) (Math.random()-0.5);
      } else {
        vx = 0;
        vz = 0;
      } 
    }
    /*if(xPosSideCol && vx > 0 && (Math.abs(vx) > Math.abs(vz) || vx == 0)) {vx = 0;}
    if(xNegSideCol && vx < 0 && (Math.abs(vx) > Math.abs(vz) || vx == 0)) {vx = 0;}
    if(zPosSideCol && vz > 0 && (Math.abs(vz) > Math.abs(vx) || vz == 0)) {vz = 0;}
    if(zNegSideCol && vz < 0 && (Math.abs(vz) > Math.abs(vx) || vz == 0)) {vz = 0;}*/
    x += vx;
    y += vy;
    z += vz;
    /*if(jump) {
      vxs *= 0.85;
      vxc *= 0.85;
      vzs *= 0.85;
      vzc *= 0.85;
    }*/
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
        if(jump) {
          vy = -1;
          //jump = false;
        }
      } if(((yc == obj.yc || yc+1 == obj.yc) && (x+vx > obj.x-obj.l/2-l/2) && (x+vx < obj.x-3*obj.l/8-3*l/8) && vx > 0) && !obj.neighbors()[0]) {//sides(obj)[3] > sides(obj)[0] && sides(obj)[3] > sides(obj)[1] && sides(obj)[3] > sides(obj)[2] && sides(obj)[3] > sides(obj)[4] && sides(obj)[3] > sides(obj)[5]) { 
        //xPosSideCol = true;
        x = obj.x-obj.l/2-l/2-vx;
        if(jump) {
          vy = -1;
          //jump = false;
        }
      } if(((yc == obj.yc || yc+1 == obj.yc) && (z+vz < obj.z+obj.w/2+w/2) && (z+vz > obj.z+3*obj.w/8+3*w/8) && vz < 0) && !obj.neighbors()[5]) {//sides(obj)[4] > sides(obj)[0] && sides(obj)[4] > sides(obj)[1] && sides(obj)[4] > sides(obj)[2] && sides(obj)[4] > sides(obj)[3] && sides(obj)[4] > sides(obj)[5]) { 
        //zNegSideCol = true;
        z = obj.z+obj.w/2+w/2-vz;
        if(jump) {
          vy = -1;
          //jump = false;
        }
      } if(((yc == obj.yc || yc+1 == obj.yc) && (z+vz > obj.z-obj.w/2-w/2) && (z+vz < obj.z-3*obj.w/8-3*w/8) && vz > 0) && !obj.neighbors()[4]) {//sides(obj)[5] > sides(obj)[0] && sides(obj)[5] > sides(obj)[1] && sides(obj)[5] > sides(obj)[2] && sides(obj)[5] > sides(obj)[3] && sides(obj)[5] > sides(obj)[4]) { 
        //zPosSideCol = true;
        z = obj.z-obj.w/2-w/2-vz;
        if(jump) {
          vy = -1;
          //jump = false;
        }
      }
    }
  }
  
  public void punched() {
    if(millis()-hitTime > 500) {
      hitTime = millis();
      health--;
      /*float tempVX = vx;
      float tempVY = vy;
      float tempVZ = vz;*/
      vx += cos(camRX);
      vy -= 1;
      vz += sin(camRX);
      if(millis()-hitTime > 500) {
        /*vx = tempVX;
        vy = tempVY;
        vz = tempVZ;*/
        vx = (float) (Math.random()-0.5);
        vz = (float) (Math.random()-0.5);
      }
    }
  }
  
  public float[] sides(Ground obj) {
    float[] dim = {y+vy-h/2-(obj.y+obj.h/2), -y-vy+h/2+(obj.y-obj.h/2), x+vx-l/2-(obj.x+obj.l/2), -x-vx+l/2+(obj.x-obj.l/2), z+vz-w/2-(obj.z+obj.w/2), -z-vz+w/2+(obj.z-obj.w/2)};
    return dim;
  }
}
