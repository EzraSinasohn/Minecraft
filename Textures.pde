PImage grassTop, grassSide, grassSideOverlay, dirt, bricks, block_of_diamond, stone, obsidian, glass, oak_planks, white_wool;
PImage[] grass = {grassTop, dirt, grassSide};;
public void texturedBox(float size, PImage img) {
  imageMode(CENTER);
  pushMatrix();
  for(int i = 0; i < 4; i++) {
    translate(0, 0, size/2);
    if(img == grassTop) {tint(30, 200, 50);}
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
  noTint();
  popMatrix();
}

public void texturedBox(float size, PImage[] img) {
  imageMode(CENTER);
  pushMatrix();
  for(int i = 0; i < 4; i++) {
    translate(0, 0, size/2);
    image(img[2], 0, 0, size, size);
    if(img == grass) {
      tint(30, 200, 50);
      image(grassSideOverlay, 0, 0, size, size);
      noTint();
    }
    translate(0, 0, -size/2);
    rotateY(PI/2);
  }
  rotateX(PI/2);
  translate(0, 0, size/2);
  if(img == grass) {tint(30, 200, 50);}
  image(img[0], 0, 0, size, size);
  noTint();
  translate(0, 0, -size/2);
  rotateX(PI);
  translate(0, 0, size/2);
  image(img[1], 0, 0, size, size);
  noTint();
  popMatrix();
}

public void texturedBox(float size, PImage[] img, boolean topNB, boolean bottomNB, boolean posXNB, boolean negXNB, boolean posZNB, boolean negZNB) {
  imageMode(CENTER);
  pushMatrix();
  for(int i = 0; i < 4; i++) {
    if((i == 0 && posZNB) || (i == 1 && posXNB) || (i == 2 && negZNB) || (i == 3 && negXNB)) {
      translate(0, 0, size/2);
      image(img[2], 0, 0, size, size);
      if(img == grass) {
        tint(30, 200, 50);
        image(grassSideOverlay, 0, 0, size, size);
        noTint();
      }
      translate(0, 0, -size/2);
    }
    rotateY(PI/2);
  }
  rotateX(PI/2);
  translate(0, 0, size/2);
  if(img == grass) {tint(30, 200, 50);}
  if(topNB) {image(img[0], 0, 0, size, size);}
  noTint();
  translate(0, 0, -size/2);
  rotateX(PI);
  translate(0, 0, size/2);
  if(bottomNB) {image(img[1], 0, 0, size, size);}
  noTint();
  popMatrix();
}
