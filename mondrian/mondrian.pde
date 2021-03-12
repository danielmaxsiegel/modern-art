import java.awt.Rectangle;
import java.util.Date;

ArrayList<Rectangle> rectangles;
color white, black, red, yellow, blue;
IntList columns, rows;
int strokeWeight;

void setup() {
  size(800,1000);
  background(255);
  
  strokeWeight = 10; 
  
  white = color(250, 250, 250);
  black = color(10, 15, 20);
  red = color(220, 45, 60);
  yellow = color(250, 225, 65);
  blue = color(50, 80, 195);
  
  columns = initializeGroup(randomInt(5,6), width);
  rows = initializeGroup(randomInt(4,5), height);
  
  rectangles = createRectangles();
 
  noLoop();
}

// Create the sizes of the rows & columns
IntList initializeGroup(int groupSize, int measurement) {
  IntList sizes = new IntList();
  int minDeduction, maxDeduction, totalSize, nextElementSize, bigColumnIndex;
  minDeduction = maxDeduction = totalSize = nextElementSize = bigColumnIndex = 0;
  
  // generate length-1 rows/columns, and one big one
  for (int i = 0; i < groupSize - 1; i++) {
    minDeduction = 20; // at least one row/column will have to be big, so this can't be 0
    maxDeduction = 60; // these two numbers might change pending experimentation
    
    nextElementSize = int(
      (measurement/groupSize) - randomInt(minDeduction, maxDeduction)
    );
    sizes.append(nextElementSize);
    totalSize += nextElementSize;
  }
  
  // add the big row/column
  sizes.append(measurement - totalSize + strokeWeight);
    
  sizes.shuffle();
  
  // If this is true, we're working with the columns
  if (measurement == width) {
    for (int i = 0; i < groupSize; i++) {
      if (sizes.get(i) > measurement / groupSize) {
        bigColumnIndex = i;
      }
    }
  }
  
  sizes.set(0, sizes.get(0) - 50);
  sizes.set(groupSize, sizes.get(groupSize - 1) - 50);
  sizes.set(bigColumnIndex, sizes.get(bigColumnIndex) + 100);
  
  return sizes;
}

void draw() {
  drawRectangles();
  generateNoise();
  saveImage();
}

ArrayList<Rectangle> createRectangles() {
  int columnWidth = 0, rowHeight = 0, index = 0;
    
  ArrayList<Rectangle> rectangles = new ArrayList<Rectangle>();
  index = 0;
  
  for (int i = 0; i < columns.size(); i++) {
    columnWidth = columns.get(i);
    
    for (int j = 0; j < rows.size(); j++) {
      rowHeight = rows.get(j);
      
      rectangles.add(
        index,
        new Rectangle(
          listSum(columns, i) - (strokeWeight/2),
          listSum(rows, j) - (strokeWeight/2),
          columnWidth,
          rowHeight)
        );
      index = index+1;
    }
  }
  return rectangles;
}

void drawRectangles() {
  Rectangle currentRect;
  for (int i = 0; i < rectangles.size(); i++) {
    currentRect = rectangles.get(i);
    fill(getRandomColour());
    stroke(0);
    strokeWeight(strokeWeight);
    rect(currentRect.x, currentRect.y, currentRect.width, currentRect.height);

    // randomly subdivide rectangles in the big row
    if (currentRect.height > height / rows.size()) {
      if (currentRect.width > width / columns.size()) {
        rect(
          currentRect.x,
          currentRect.y,
          currentRect.width,
          currentRect.height - randomInt(25, currentRect.height-25)
        );
      } else if(randomInt(0, columns.size()) > 0) {
        //strokeWeight(0);
        noStroke();
        fill(getRandomColour());
        rect(
          currentRect.x + (strokeWeight / 2),
          currentRect.y + randomInt(15, currentRect.height - 25),
          currentRect.width,
          currentRect.height - randomInt(25, currentRect.height-25)
        );
      }
    }
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
    return white;
  }
}

int listSum(IntList arr, int maxIndex) {
  if (maxIndex == 0) {
    return 0;
  }
  
  int sum = 0;
  for (int i=0; i < maxIndex; i++) {
    sum += arr.get(i);
  }
  return sum;
}

double randomSizeDouble() {
  return random(0.0,1.0) * 2 / 3 + 0.1;
}

int randomInt(int bottom, int top) {
  return int(random(bottom, top+1));
}

void saveImage() {
  Date d = new Date();
  long current = d.getTime()/1000; 
  save("images/image_" + current + ".png");
}
