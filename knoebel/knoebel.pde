import java.util.Date;

void setup() {
  size(420,700);
  noStroke();
  noLoop();
}

void draw() {
  color bgColour = getRandomColour();
  background(bgColour);
  int rectDepth = 45;
  
  fill(getRectColour(bgColour));
  rect(rectDepth, (height - rectDepth), (width - rectDepth*2), rectDepth);
  
  fill(getRectColour(bgColour));
  rect(0, rectDepth, rectDepth, height - rectDepth);
  
  fill(getRectColour(bgColour));
  rect(width - rectDepth, rectDepth, rectDepth, height - rectDepth);
  
  fill(getRectColour(bgColour));
  rect(0, 0, width, rectDepth);
  
  generateNoise();
  saveImage();
}

color getRectColour(color bgColour) {
  boolean isColourPicked = false;
  color newColour = color(0,0,0);
  
  while (!isColourPicked) {
    newColour = getRandomColour();
    
    if (colourDistance(newColour, bgColour) > 200) {
      isColourPicked = true;
    }
  }
  
  return newColour;
}

float colourDistance(color c1, color c2)
{
  float rmean =(red(c1) + red(c2)) / 2;
  float r = red(c1) - red(c2);
  float g = green(c1) - green(c2);
  float b = blue(c1) - blue(c2);
  return sqrt((int(((512+rmean)*r*r))>>8)+(4*g*g)+(int(((767-rmean)*b*b))>>8));
}

color getRandomColour() {
  color randomColor = color(randomInt(0, 255), randomInt(0, 255), randomInt(0, 255));
  return randomColor;
}

int randomInt(int bottom, int top) {
  return int(random(bottom, top+1));
}

void generateNoise() {
  noStroke();
  
  for (int k=0; k < width; k++) {
    for (int l=0; l < height; l++) {
      fill(randomInt(200,235), randomInt(200,235), randomInt(200,235), randomInt(1,4));
      float noiseWidth = random(0,4);
      float noiseHeight = random(0,4);
      rect(k, l, noiseWidth, noiseHeight);
    }
  }
}

void saveImage() {
  Date d = new Date();
  long current = d.getTime()/1000; 
  save("images/image_" + current + ".png");
}
