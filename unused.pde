// unused

//other references
void tree1(float len) {
  line(0,0,0,-len);       // draw trunk
}

void tree2(float len) {
  // tree1(len);
  translate(0,-len);      // move origin to top of trunk

  rotate(radians(15));    // rotate slightly to right
  tree1(len*0.75);  // draw right branch
  
  rotate(radians(-30));   // rotate back to the left (twice as much as before)

  tree1(len*0.75); // draw left branch
  rotate(radians(15));    // rotate back to "normal"

  translate(0,len);       // move origin back to bottom of trunk
}

void tree3(float len) {
  // tree2(len);
  translate(0, -len);

  rotate(radians(15));
  tree2(len * 0.75);

  rotate(radians(-30));

  tree2(len * 0.75);
  rotate(radians(15));

  translate(0, len);
}

void tree2x(float len) {
  line(0,0,0,-len);       // draw trunk
  translate(0,-len);      // move origin to top of trunk
  rotate(radians(15));    // rotate slightly to right
  line(0,0,0,-len*0.75);  // draw right branch
  rotate(radians(-30));   // rotate back to the left (twice as much as before)
  line(0,0,0,-len*0.75);  // draw left branch
  rotate(radians(15));    // rotate back to "normal"
  translate(0,len);       // move origin back to bottom of trunk
}

float theta;

void draw2() {
  background(0);
  frameRate(30);
  stroke(255);
  // Let's pick an angle 0 to 90 degrees based on the mouse position
  float a = (mouseX / (float) width) * 90f;
  // Convert it to radians
  theta = radians(a);
  // Start the tree from the bottom of the screen
  translate(width/2,height);
  // Draw a line 120 pixels
  line(0,0,0,-120);
  // Move to the end of that line
  translate(0,-120);
  // Start the recursive branching!
  branch(120);

}

void branch(float h) {
  // Each branch will be 2/3rds the size of the previous one
  h *= 0.66;
  
  // All recursive functions must have an exit condition!!!!
  // Here, ours is when the length of the branch is 2 pixels or less
  if (h > 2) {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(theta);   // Rotate by theta
    line(0, 0, 0, -h);  // Draw the branch
    translate(0, -h); // Move to the end of the branch
    branch(h);       // Ok, now call myself to draw two new branches!!
    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
    
    // Repeat the same thing, only branch off to the "left" this time!
    pushMatrix();
    rotate(-theta);
    line(0, 0, 0, -h);
    translate(0, -h);
    branch(h);
    popMatrix();
  }
}
