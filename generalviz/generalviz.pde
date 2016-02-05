import peasy.*;

PeasyCam cam;

Axis axis1;
Axis axis2;
Axis axis3;

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
  
  // Add objects to Scene
  
  axis1 = new Axis(new PVector(0,0,0), new PVector(1,0,0), 40, color(255,0,0));
  axis2 = new Axis(new PVector(0,0,0), new PVector(0,1,0), 60, color(0,255,0));
  axis3 = new Axis(new PVector(0,0,0), new PVector(0,0,1), 60, color(0,0,255));
  
  
  scene.axes.add(axis1);
  scene.axes.add(axis2);
  scene.axes.add(axis3);


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



