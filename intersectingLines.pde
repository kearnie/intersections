void setup() {
  size(720,480);
}

boolean doesIntersect(int[] line1, int[] line2) {
  int ax1 = line1[0];
  int ay1 = line1[1];
  int ax2 = line1[2];
  int ay2 = line1[3];
  int bx1 = line2[0];
  int by1 = line2[1];
  int bx2 = line2[2];
  int by2 = line2[3];
  double den = (by2-by1)*(ax2-ax1)-(bx2-bx1)*(ay2-ay1);
  if (den != 0) { //ensure lines are not parallel (cannot divide by 0)
    int[] intPoint = findIntPoint(line1, line2);
    int intx = intPoint[0];
    int inty = intPoint[1];
    boolean withinBounds = (intx >= min(ax1,ax2) && intx >= min(bx1,bx2) && intx <= max(ax1,ax2) && 
                        intx <= max(bx1,bx2) && inty >= min(ay1,ay2) && inty >= min(by1,by2) && 
                        inty <= max(ay1,ay2) && inty <= max(by1,by2));
    return withinBounds;  
  } else {
      return false;
  }
}
  
int[] findIntPoint(int[] line1, int[] line2) {
  int ax1 = line1[0];
  int ay1 = line1[1];
  int ax2 = line1[2];
  int ay2 = line1[3];
  int bx1 = line2[0];
  int by1 = line2[1];
  int bx2 = line2[2];
  int by2 = line2[3];
  double num1 = (bx2-bx1)*(ay1-by1)-(by2-by1)*(ax1-bx1);
  double den = (by2-by1)*(ax2-ax1)-(bx2-bx1)*(ay2-ay1);
  double slope = (double)num1/den; //double division for fractions
  int intx = (int)(ax1 + slope*(ax2-ax1)); //int division to revert to int
  int inty = (int)(ay1 + slope*(ay2-ay1));
  return new int[]{intx,inty};
}

int numLines = 12; //12 lines generated
void draw() {
  clear(); //clear canvas with each redraw (initiated by mouseclick)
  background(255,255,255);
  int[][] lines = new int[numLines][]; //2D list of all lines on canvas
  stroke(180);
  strokeWeight(2);
  for (int x = 0; x < numLines; x = x+1) {
    int x1 = (int)random(0,360); //lines drawn at random but customized numbers to retain "nonmessy" spawns
    int y1 = (int)random(0,480); //lines will generally appear stretching from one end to another (more balanced)
    int x2 = (int)random(360,720);
    int y2 = (int)random(0,480);
    int[] lineData = {x1,y1,x2,y2}; //coordinates of current, single line
    line(x1,y1,x2,y2);
    lines[x] = lineData;
  }
  for (int i = 0; i < lines.length; i = i+1) {
    int[] currLine = lines[i];
    for (int j = 0; j < lines.length; j = j+1) {
      int[] otherLine = lines[j];
      if (j != i) {
        if (doesIntersect(currLine,otherLine)) {
          fill(202,214,235,80);
          stroke(169,186,214,180);
          strokeWeight(1);
          int[] intPoint = findIntPoint(currLine,otherLine);
          int intx = intPoint[0];
          int inty = intPoint[1];
          ellipse(intx,inty,10,10);
        }
      }
    }
  }
  noLoop();
}

void keyPressed() {
  if (keyCode == UP) {
    numLines = numLines + 10; //increase number of lines with up key
  } else if (keyCode == DOWN) {
    numLines = numLines - 10; //decrease number of lines with down key
  }
}

void mousePressed() { //draw new lines when user clicks
  redraw();
}