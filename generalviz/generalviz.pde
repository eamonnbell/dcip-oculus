import peasy.*;

PeasyCam cam;

PrimitiveGroup primitive_group;

void setup() {
  size( 640, 640, OPENGL );
  
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  
  primitive_group = new PrimitiveGroup();
  noStroke();
 
}

void draw() {
    lights();
    background(50);
    fill(255);
    primitive_group.update();
    primitive_group.display();
}



