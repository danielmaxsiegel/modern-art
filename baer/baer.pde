import java.util.Date;

void setup() {
  size(800,800);
  noStroke();
  noLoop();
}

void draw() {
  int borderWidth = 12;
  int colourWidth = borderWidth + 4;
  
  background(0);
  
  fill(getRandomColour());
  rect(borderWidth, borderWidth, width - (borderWidth * 2), height - (borderWidth * 2));
  
  fill(255, 255, 255);
  rect(
    colourWidth,
    colourWidth,
    width - (colourWidth * 2),
    height - (colourWidth * 2)
  );
  
  generateNoise();
  saveImage();
}

color getRandomColour() {
  color randomColor = color(randomInt(30, 235), randomInt(30, 235), randomInt(30, 235));
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
