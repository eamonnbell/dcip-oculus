import peasy.*;

PeasyCam cam;

PrimitiveGroup primitive_group;
DataHandler data_handler;
DataBinding data_binding;

void setup() {
  size( 640, 640, OPENGL );
  
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  
  primitive_group = new PrimitiveGroup();
  
  data_handler = new DataHandler("data.csv");
  data_binding = new DataBinding(data_handler);
  
  primitive_group.populate(data_binding.bind());
  
  noStroke();
 
}

void draw() {
    lights();
    background(50);
    fill(255);
    primitive_group.update();
    primitive_group.display();
}



