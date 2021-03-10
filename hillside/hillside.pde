import java.util.Date;

int numberOfElements;
color backgroundColour;
color[] colours;

void setup() {  
  size(435, 700);
  numberOfElements = randomInt(3, 5);
  //color[] colours = new color[numberOfElements + 1];
  colours = generateColours();
  background(backgroundColour);
  noStroke();
  noLoop();
}

void draw() {
  for (int placement = 0; placement < numberOfElements; placement++) {
    drawElement(placement, numberOfElements);
  }
  
  Date d = new Date();
  long current = d.getTime()/1000; 
  save("images/image_" + current + ".png");
}

// generate one color per element, plus one for the background
color[] generateColours() {
  colours = new color[numberOfElements];
  backgroundColour = randomColour();
  
  color newColour, previousColour;
  boolean isColourPicked;
  
  for (int i=0; i < numberOfElements; i++) {
    isColourPicked = false;
    while (!isColourPicked) {
      newColour = randomColour();
      // compare the first element colour against the background
      if (i==0) {
        previousColour = backgroundColour;
      } else {
        previousColour = colours[i-1];
      }
      
      if (isNewColourAcceptable(i, newColour, previousColour)) {
        colours[i] = newColour;
        isColourPicked = true;
      }
    }
  }
  
  return colours;
}

boolean isNewColourAcceptable(int position, color newColour, color previousColour) {
  if (colourDistance(newColour, previousColour) < 200) {
    return false;
  }
  
  // Don't let first hill clash with background colour
  if (position == 2 && colourDistance(newColour, colours[0]) < 200) {
    return false;
  }
  
  return true;
}

void drawElement(int placement, int numberOfElements) {
  int drawHeight = 266 + int(random(-10,10)) + (placement * 75);
  fill(colours[placement]);
  
  if (placement == 0) {
    int sunX = int(random(width/2 - 100, width/2 + int(random(95, 105))));
    int sunsize = int(random(55, 150));
    circle(sunX, drawHeight, sunsize); 
  } else {
    int rotationRadians = int(random(-20,20));
    int rectHeight;
    
    if (placement == numberOfElements - 1) {
      rectHeight = height + int(random(95, 105));
    } else {
      rectHeight = height;
    }

    rotate(radians(rotationRadians));
    rect(-300, drawHeight, width * 20, rectHeight);
    rotate(radians(rotationRadians) * -1);
  }
}

/**
* Determines contrast/distance between 2 colours.
* Citation: https://stackoverflow.com/a/5069048
*/
float colourDistance(color c1, color c2)
{
  float rmean =(red(c1) + red(c2)) / 2;
  float r = red(c1) - red(c2);
  float g = green(c1) - green(c2);
  float b = blue(c1) - blue(c2);
  return sqrt((int(((512+rmean)*r*r))>>8)+(4*g*g)+(int(((767-rmean)*b*b))>>8));
}

color randomColour() {
  color c = color(randomInt(0,254), randomInt(0,254), randomInt(0,254));
  return c;
}

int randomInt(int lowerBound, int upperBound) {
  return int(random(lowerBound, upperBound + 1));
}
