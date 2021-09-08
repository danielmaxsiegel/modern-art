import java.util.Date;

int numSquares;

void setup() {
  size(600, 800);
  background(0);
  fill(0);
  noStroke();
  noLoop();
}

void draw() {
  //if (randomInt(0, 1) == 0) {
    oneSquare();
  //} else {
    //fourSquares();
  //}
  
  //generateNoise();
  //saveImage();
}

void oneSquare() {
  int SquareWidth = width;
  int smallestSquareWidth = 20;
  int count = 0;
  
  while (SquareWidth > smallestSquareWidth) {
    if (count > 0) {
      stroke(75);
    }
    
    rect(
      smallestSquareWidth * count,
      smallestSquareWidth * count,
      SquareWidth - (count * smallestSquareWidth),
      SquareWidth - (count * smallestSquareWidth)
    );
    
    SquareWidth -= smallestSquareWidth;
    count += 1;
  }
}

void fourSquares() {
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
      fill(randomInt(200, 235), randomInt(200, 235), randomInt(200, 235), randomInt(1, 4));
      float noiseWidth = random(0, 4);
      float noiseHeight = random(0, 4);
      rect(k, l, noiseWidth, noiseHeight);
    }
  }
}

void saveImage() {
  Date d = new Date();
  long current = d.getTime()/1000; 
  save("images/image_" + current + ".png");
}
