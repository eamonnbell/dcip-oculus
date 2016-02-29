import peasy.*;

PeasyCam cam;

Axis axis1;
Axis axis2;
Axis axis3;

Scene scene;

DataBindingSchema data_binding_schema_a;
DataBindingSchema data_binding_schema_b;

DataBindingSchema dbc;


DataHandler data_handler;
DataBinding data_binding;


void setup() {
  size( 320, 320, OPENGL );
  
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  
  scene = new Scene(true);
  
  data_handler = new DataHandler("testdata.csv");
    
  data_binding_schema_a = new DataBindingSchema("/home/eamonn/Projects/dcip-oculus/generalviz/data/testA.yaml");
  data_binding_schema_b = new DataBindingSchema("/home/eamonn/Projects/dcip-oculus/generalviz/data/testB.yaml");
  
  println(data_binding_schema_a.schema);
    
  data_binding = new DataBinding(data_handler, data_binding_schema_a);
  
  
  scene.primitive_groups.add(data_binding.bind());
  
  noStroke();
 
}

void draw() {
    lights();
    background(50);
    fill(255);

    scene.update();
    scene.display();
}

void keyPressed() {
  
  scene.clear_scene();
  
  if (key == 'a' || key == 'A') {
    data_binding = new DataBinding(data_handler, data_binding_schema_a);
    scene.primitive_groups.add(data_binding.bind());
  } else if (key == 'b' || key == 'B') {
    data_binding = new DataBinding(data_handler, data_binding_schema_b);
    scene.primitive_groups.add(data_binding.bind());
  }
  
}


