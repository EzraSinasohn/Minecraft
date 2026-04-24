PImage grassTop;
public void texturedBox(float size, PImage img) {
  imageMode(CENTER);
  pushMatrix();
  for(int i = 0; i < 4; i++) {
    translate(0, 0, size/2);
    image(img, 0, 0, size, size);
    translate(0, 0, -size/2);
    rotateY(PI/2);
  }
  rotateX(PI/2);
  translate(0, 0, size/2);
  image(img, 0, 0, size, size);
  translate(0, 0, -size/2);
  rotateX(PI);
  translate(0, 0, size/2);
  image(img, 0, 0, size, size);
  popMatrix();
}
