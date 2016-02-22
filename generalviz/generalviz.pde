import peasy.*;

PeasyCam cam;

Axis axis1;
Axis axis2;
Axis axis3;

Scene scene;

DataBindingSchema data_binding_schema_a;
DataBindingSchema data_binding_schema_b;

DataHandler data_handler;
DataBinding data_binding;


void setup() {
  size( 320, 320, OPENGL );
  
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  
  scene = new Scene(true);
  
  
  data_handler = new DataHandler("testdata.csv");
  
  data_binding_schema_a = new DataBindingSchema();
  
  data_binding_schema_a.schema.put("size", "volume");
  data_binding_schema_a.schema.put("primitive_type", "1");
  data_binding_schema_a.schema.put("fill_color", "volume");
  data_binding_schema_a.schema.put("fill_color_type", "quantitative");
  
  data_binding_schema_b = new DataBindingSchema();
  
  data_binding_schema_b.schema.put("size", "volume");
  data_binding_schema_b.schema.put("primitive_type", "0");
  data_binding_schema_b.schema.put("fill_color", "genre");
  data_binding_schema_b.schema.put("fill_color_type", "qualitative");
  
  data_binding = new DataBinding(data_handler, data_binding_schema_b);
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


