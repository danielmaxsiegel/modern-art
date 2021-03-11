import java.awt.Rectangle;
import java.util.Date;

ArrayList<Rectangle> rectangles;
color white, black, red, yellow, blue;
int[] columns, rows;

void setup() {
  size(1000,800);
  background(255);
  
  white = color(250, 250, 250);
  black = color(10, 15, 20);
  red = color(220, 45, 60);
  yellow = color(250, 225, 65);
  blue = color(50, 80, 195);
  
  columns = initializeGroup(randomInt(5,6), width);
  rows = initializeGroup(columns.length - 1, height);
  
  rectangles = createRectangles();
 
  noLoop();
}

int[] initializeGroup(int length, int measurement) {
  int[] group = new int[length];
  int totalSize = 0, currentSize = 0;
  
  for (int i=0; i < length; i++) {
    if (i == length - 1) {
      currentSize = measurement - totalSize;
    } else {
      currentSize = measurement/length + randomInt(-20,20);
    }
    
    group[i] = currentSize;
    totalSize += currentSize;
  }
  
  return group;
}

void draw() {
  drawRectangles();
  //generateNoise();
  //saveImage();
}

ArrayList<Rectangle> createRectangles() {
  int columnWidth = 0, rowHeight = 0, index = 0, totalWidth = 0, totalHeight = 0;
    
  ArrayList<Rectangle> rectangles = new ArrayList<Rectangle>();
  index = 0;
  
  for (int i = 0; i < columns.length; i++) {
    columnWidth = columns[i];
    
    for (int j = 0; j < rows.length; j++) {
      rowHeight = rows[j];
      
      rectangles.add(
        index,
        new Rectangle(
          totalWidth,
          totalHeight,
          columnWidth,
          rowHeight)
        );
      index = index+1;
    }
    
    totalWidth += columns[i];
  }
  
  //rectangles.add(0, new Rectangle(-50, -50, width+100, height+100));
  //double size;
  //size = randomSizeDouble();
  //splitRectangleHor(rectangles, 0, size);
  //size = randomSizeDouble();
  //splitRectangleVer(rectangles, 0, size);
  //splitRectangleVer(rectangles, 3, size);
  
  // split random rectangles into two
  //for (int j = 1; j < rectangles.size(); j++) {
  //  size = randomSizeDouble();
  //  // 1/3 chance of splitting any given rectangle
  //  if ((int) (Math.random() * 3 + 1) == 3) {
  //    // 1/2 chance of splitting horizontally or vertically
  //    if ((int) (Math.random() * 2 + 1) == 1) {
  //      splitRectangleHor(rectangles, j, size);
  //    } else {
  //      splitRectangleVer(rectangles, j, size);
  //    }
  //  }
  //}
    
  return rectangles;
}

Rectangle splitHorBottom(Rectangle r, double size) {
  // Splits a rectangle horizontally, returns bottom part
  Rectangle r2 = new Rectangle(r.x, r.y, r.width, r.height);
  r2.y = (int) Math.round(r2.y + (r2.height * (1 - size)));
  r2.height = (int) Math.round(r2.height * size);
  return r2;
}

Rectangle splitHorTop(Rectangle r, double size) {
  // Splits a rectangle horizontally, returns top part
  r.height = (int) Math.round(r.height * (1 - size));
  return r;
}

Rectangle splitVerRight(Rectangle r, double size) {
  Rectangle r2 = new Rectangle(r.x, r.y, r.width, r.height);
  r2.x = (int) Math.round(r2.x + (r2.width * (1 - size)));
  r2.width = (int) Math.round(r2.width * size);
  return r2;
}

// Same as above except vertically
Rectangle splitVerLeft(Rectangle r, double size) {
  r.width = (int) Math.round(r.width * (1 - size));
  return r;
}

void splitRectangleHor(ArrayList<Rectangle> rectangles, int index, double size) {
  rectangles.add(splitHorBottom(rectangles.get(index), size));
  rectangles.add(index, splitHorTop(rectangles.get(index), size));
}

void splitRectangleVer(ArrayList<Rectangle> rectangles, int index, double size) {
  rectangles.add(splitVerRight(rectangles.get(index), size));
  rectangles.add(index, splitVerLeft(rectangles.get(index), size));
}

void drawRectangles() {
  Rectangle currentRect;
  for (int i = 0; i < rectangles.size(); i++) {
    currentRect = rectangles.get(i);
    fill(getRandomColour());
    strokeWeight(10);
    
    rect(currentRect.x, currentRect.y, currentRect.width, currentRect.height);
  }
}

void generateNoise() {
  noStroke();
  
  for (int k=0; k < width; k++) {
    for (int l=0; l < height; l++) {
      fill(randomInt(200,255), randomInt(200,255), randomInt(200,255), randomInt(3,7));
      float noiseWidth = random(0,4);
      float noiseHeight = random(0,4);
      rect(k, l, noiseWidth, noiseHeight);
    }
  }
}

color getRandomColour() {
  int rand = (int) (Math.random() * 10 + 1);
  if (rand == 1) {
    return black;
  } else if (rand == 2) {
    return red;
  } else if (rand == 3) {
    return yellow;
  } else if (rand == 4) {
    return blue;
  } else {
    return color(random(0,255), random(0,255), random(0,255));
    //return white;
  }
}

double randomSizeDouble() {
  return random(0.0,1.0) * 2 / 3 + 0.1;
}

int randomInt(int bottom, int top) {
  return int(random(bottom, top));
}

void saveImage() {
  Date d = new Date();
  long current = d.getTime()/1000; 
  save("images/image_" + current + ".png");
}
