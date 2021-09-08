import java.util.Date;

color bgColour;

void setup() {
  size(600, 800, P3D);
  bgColour = color(randomInt(1,2), randomInt(29,35), randomInt(125,151));
  background(bgColour);
  
  noStroke();
  noLoop();
}


void draw() {
  gradientRectHoriz(
    width - 200,
    0,
    200,
    height,
    bgColour,
    color(red(bgColour) - 1, green(bgColour) - 5, blue(bgColour) - 10)
  );
  
  gradientRectHoriz(
    0,
    0,
    200,
    height,
    color(red(bgColour) - 1, green(bgColour) - 5, blue(bgColour) - 10),
    bgColour
  );
  
  gradientRectVert(
    0,
    height - 300,
    width,
    300,
    bgColour,
    color(red(bgColour) - 1, green(bgColour) - 5, blue(bgColour) - 30)
  );
  //saveImage();
}

void gradientRectHoriz(int x, int y, int w, int h, color c1, color c2) {
  beginShape();
  fill(c1);
  vertex(x,y);
  vertex(x,y+h);
  fill(c2);
  vertex(x+w,y+h);
  vertex(x+w,y);
  endShape();
}

void gradientRectVert(int x, int y, int w, int h, color c1, color c2) {
  beginShape();
  fill(c1);
  vertex(x,y);
  vertex(x+w,y);
  fill(c2);
  vertex(x+w,y+h);
  vertex(x,y+h);
  endShape();
}


int randomInt(int bottom, int top) {
  return int(random(bottom, top+1));
}

void saveImage() {
  Date d = new Date();
  long current = d.getTime()/1000; 
  save("images/image_" + current + ".png");
}
