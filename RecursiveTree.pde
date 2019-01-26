/*
@AUTHOR Chell Li
@DATE 2018.01.15

Recursive Tree
http://www.sfu.ca/~shaw/iat265/Spring19/assignment1.html

1. Requirements:
Your DrawMyTree() method should have at least the following paramaters:
X,Y -- the X and Y coordinates of the base of the trunk/branch
angle -- the angle to draw the trunk/branch
step -- the number of recursive calls that have happened so far
X, Y, and angle need to be floats. step should probably be an int, but you can use this parameter to count up, to count down, to represent branch length, to represent branch width, whatever you think is best.

2. Requirements: Pick two!
Your tree has visual trunk, branches, leaves, flowers.
Your tree has a branching factor more than 2. Perhaps even variable branching factors at each level.
^^ A simple recursive tree usually shortens the stem length by some fixed ratio. Create a tree that controls child branch sizes by some other method. Pass this info as parameter(s).

In this part, you will refine the DrawMyTree() method you developed so that does not grow into obstacles. You can add any parameters that you need to your new DrawMyTree() method.

You might need to use PVectors for this, because PVector allows you to do things like 
PVector v1 = new PVector( 10.0, 5.0 ); 
v1.rotate( HALF_PI ); 
Which is to say that you might need to apply translations and rotations to a PVector so that you know where in the global coordinate system your branches are. 
Tip: make sure to create a new copy of a PVector if you're going to pass it into a recursive call.

Requirements:
Create a tree that avoids fixed obstacles. Real trees in the city get trimmed around power lines. Cut off branches that get too close to obstacles that you have placed.
You do not need to place obstacles interactively!
Do NOT represent your obstacle(s) as hard-coded constants in your code. Create a little class that represents an obstacle.
Obstacles may be circles or rectangles.
*/
Obstacles obs;

void setup(){
	size(500, 500);
	background(15);
  // obs = new Obstacles(random(0, width/2), random(0, height/2));
  obs = new Obstacles(100, 100);
}

void draw() {
  obs.draw();
}

/*
@param angle -- the angle to draw the trunk/branch
@param step -- the number of recursive calls that have happened so far, count up
*/
void mousePressed() {
	background(15);
  stroke(255);
  translate(mouseX,mouseY);  // move origin
  
  //Rotations occur in the clockwise direction around the origin.
  rotate(radians(0));         // rotate (degrees) set to upward.

  float len = 100; //length of the trunk
	int angle = 30;
	int step = 10;
  float branchShortenCoefficient = 0.8;
  int branchNum = 7;

  PVector tracker = new PVector(0,0); 
  tracker.rotate( HALF_PI ); 

	DrawMyTree(0, 0, len, angle, step, branchShortenCoefficient, branchNum, tracker);
}

//end = root or the most outside branch
void DrawOneBranch(float len){
  line(0,0,0,-len);
}

/*
This function recursively calls itself to draw a stick-figure tree.
@param X,Y -- the X and Y coordinates of the base of the trunk/branch
*/
void DrawMyTree(float x, float y, float len, int angle, int step, float branchShortenCoefficient, int branchNum, PVector tracker) {
  len *= branchShortenCoefficient;
  if(step <= 0){
    return;
  }else if(step == 1) {
    DrawOneBranch(len); //draw the last step of branch
  }else {
    DrawOneBranch(len); //draw the trunk
    translate(0, -len); // move origin to top of trunk
    tracker.add(0, -len);

    rotate(radians(angle)); //rotate slightly to right
    // draw right branch
    DrawMyTree(x, y, len, angle, step - 1, branchShortenCoefficient, branchNum, tracker);

    // rotate back to the left (twice as much as before)
    rotate(radians(-2 * angle));

    // draw left branch
    DrawMyTree(x, y, len, angle, step -1, branchShortenCoefficient, branchNum, tracker);
    rotate(radians(angle));// rotate back to "normal"

    // DrawOneStep(len, branchNum, angle);

    translate(0, len);// move origin back to bottom of trunk
    tracker.add(0, len);
  }  
}

//if the angle is for angle bewtween 2 branches.
void DrawOneStep(float len, int branchNum, int angle) {

  float fullRarianOfOneStep;
  float fullRadianOfOneStep = angle * (branchNum / 2 - 0.5);

  // if(branchNum % 2 == 0) {
  //   //if 8 branches, rotate(3.5) 8 / 2 - 0.5 angle
  //   fullRadianOfOneStep = angle * (branchNum / 2 - 0.5);
  // } else {
  //   //if 7 branches, rotate(3) 7 / 2 - 0.5 angle
  //   fullRadianOfOneStep = angle * (branchNum / 2 - 0.5)
  // }

  rotate(radians(fullRadianOfOneStep)); //rotate to right
  DrawOneBranch(len); //the very end right branch

  int i = 0;
  while (i < branchNum){
    rotate(radians( -angle));
    DrawOneBranch(len);
    i++;
  }
  rotate(radians(fullRadianOfOneStep / 2)); //rotate back to "normal"
}