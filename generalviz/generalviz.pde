import peasy.*;

PeasyCam cam;

Scene scene;
PrimitiveGroup primitive_group;
DataHandler data_handler;
DataBinding data_binding;


void setup() {
  size( 640, 640, OPENGL );
  
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  
  scene = new Scene();
  primitive_group = new PrimitiveGroup();
    
  // Do binding
  
  data_handler = new DataHandler("testdata.csv");
  data_binding = new DataBinding(data_handler);
  
  primitive_group.populate(data_binding.bind());
  scene.primitive_groups.add(primitive_group);
  
  noStroke();
 
}

void draw() {
    lights();
    background(50);
    fill(255);
    
    scene.update();
    scene.display();
}



