import peasy.*;

PeasyCam cam;

Axis axis1;
Axis axis2;
Axis axis3;

Scene scene;

DataBindingSchema data_binding_schema;
DataHandler data_handler;
DataBinding data_binding;


void setup() {
  size( 320, 320, OPENGL );
  
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  
  scene = new Scene(true);
  
  
  data_handler = new DataHandler("testdata.csv");
  
  
  data_binding_schema = new DataBindingSchema();
  
  data_binding = new DataBinding(data_handler, data_binding_schema);
  
  scene.primitive_groups.add(data_binding.bind());
  
  

  // Add axes to Scene

  
  noStroke();
 
}

void draw() {
    lights();
    background(50);
    fill(255);
    
    scene.update();
    scene.display();
}



