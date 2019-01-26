class Obstacles {
	int size = 50;
	float xPos;
	float yPos;
	Obstacles(float x, float y){
		xPos = x;
		yPos = y;
	} 

	void draw(){
		ellipse(xPos, yPos, size, size);
	}
}