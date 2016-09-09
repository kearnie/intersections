function setup() {
  createCanvas(720,480)
}

function doesIntersect(line1, line2) {
  var ax1 = line1[0];
  var ay1 = line1[1];
  var ax2 = line1[2];
  var ay2 = line1[3];
  var bx1 = line2[0];
  var by1 = line2[1];
  var bx2 = line2[2];
  var by2 = line2[3];
  var den = (by2-by1)*(ax2-ax1)-(bx2-bx1)*(ay2-ay1);
  if (den !== 0) { //ensure lines are not parallel (cannot divide by 0)
    var intPoint = findIntPoint(line1, line2);
    var intx = intPoint[0];
    var inty = intPoint[1];
    var withinBounds = (intx >= Math.min(ax1,ax2) && intx >= Math.min(bx1,bx2) && intx <= Math.max(ax1,ax2) && 
                        intx <= Math.max(bx1,bx2) && inty >= Math.min(ay1,ay2) && inty >= Math.min(by1,by2) && 
                        inty <= Math.max(ay1,ay2) && inty <= Math.max(by1,by2));
    return withinBounds;  
  } else {
      return false;
  }
}
  
function findIntPoint(line1, line2) {
  var ax1 = line1[0];
  var ay1 = line1[1];
  var ax2 = line1[2];
  var ay2 = line1[3];
  var bx1 = line2[0];
  var by1 = line2[1];
  var bx2 = line2[2];
  var by2 = line2[3];
  var num1 = (bx2-bx1)*(ay1-by1)-(by2-by1)*(ax1-bx1);
  var den = (by2-by1)*(ax2-ax1)-(bx2-bx1)*(ay2-ay1);
  var slope = num1/den;
  var intx = ax1 + slope*(ax2-ax1);
  var inty = ay1 + slope*(ay2-ay1);
  return [intx,inty];
}

var numLines = 12; //12 lines generated
function draw() {
  var lines = []; //2D list of all lines on canvas
  stroke(180);
  strokeWeight(2);
  for (var x = 0; x < numLines; x = x+1) {
    var x1 = random(0,360); //lines drawn at random but customized numbers to retain "nonmessy" spawns
    var y1 = random(0,480); //lines will generally appear stretching from one end to another (more balanced)
    var x2 = random(360,720);
    var y2 = random(0,480);
    var lineData = [x1,y1,x2,y2]; //coordinates of current, single line
    line(x1,y1,x2,y2);
    append(lines,lineData);
  }
  for (var i = 0; i < lines.length; i = i+1) {
    var currLine = lines[i];
    for (var j = 0; j < lines.length; j = j+1) {
      var otherLine = lines[j];
      if (j != i) {
        if (doesIntersect(currLine,otherLine)) {
          fill(202,214,235,80);
          stroke(169,186,214,180);
          strokeWeight(1);
          var intPoint = findIntPoint(currLine,otherLine);
          var intx = intPoint[0];
          var inty = intPoint[1];
          ellipse(intx,inty,10,10);
        }
      }
    }
  }
  noLoop();
}

function keyPressed() {
  if (keyCode === UP_ARROW) {
    numLines = numLines + 10; //increase number of lines with up key
  } else if (keyCode === DOWN_ARROW) {
    numLines = numLines - 10; //decrease number of lines with down key
  }
}

function mousePressed() { //draw new lines when user clicks
  clear();
  redraw();
}