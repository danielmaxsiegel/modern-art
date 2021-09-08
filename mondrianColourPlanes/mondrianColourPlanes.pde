void setup()
{
  size(1000,800);
  background(255);
  
  color pink = color(240,169,180);
  color yellow = color(208,154,39);
  color purple = color(168,172,211);
 
  noStroke();
  
  for(int i=0; i<5; i++) {
    // draw out row
    int rectsPerRow = (int)random(5,7);
    
    int rows = height/4;
    int cols = width/rectsPerRow;
    
    for(int j=0; j < rectsPerRow; j++) {
      int x = 0;
      int y = 0;
      
      int w = 0;
      int h = 0;
      
      x = j * cols;
      y = i * rows;
      
      int maxWidth = cols;
      int minWidth = cols/3;
      int maxHeight = rows;
      int minHeight = rows/3;
      
      w = (int)random(minWidth, maxWidth);
      h = (int)random(minHeight, maxHeight);
      
      float colorChoice = random(0,5);
      
      if (colorChoice < 2) {
       fill(purple);
      } else if(colorChoice < 4) {
       fill(pink);
      } else {
        fill(yellow);
      }
      
      rect(x,y,w,h);
    }
  }
   
  // Create Noise
  for (int k=0; k<width; k++) {
    for (int l=0; l<height; l++) {
      fill(random(200,255), random(200,255), random(200,255), random(10,15)); // gray color noise with 15 value alpha
      float noiseWidth = random(0,4);
      float noiseHeight = random(0,4);
      rect(k, l, noiseWidth, noiseHeight);
    }
  }
  
   save("images/mondrian.png");
}
