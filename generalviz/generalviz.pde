import java.io.File;

OculusRift oculus;

Scene scene;

ArrayList<DataBindingSchema> schemas;

DataHandler data_handler;
DataBinding data_binding;

boolean isFullScreen = false;

boolean sketchFullScreen() {
  return isFullScreen;
}

void setup() {
  size( 1920, 1080, P3D );
  
  oculus = new OculusRift(this);

  data_handler = new DataHandler("testdata.csv");

  File dir = new File(dataPath(""));
  File[] files = dir.listFiles();

  schemas = new ArrayList<DataBindingSchema>();

  for (int i = 0; i < files.length; i++) {
    String path = files[i].getAbsolutePath();

    if (path.toLowerCase().endsWith(".yaml")) {
      DataBindingSchema dbs = new DataBindingSchema(path);
      schemas.add(dbs);
    }
  }

  scene = new Scene(true);

  data_binding = new DataBinding(data_handler, schemas.get(1));
  scene.primitive_groups.add(data_binding.bind());

  noStroke();
}

void draw() {
  oculus.draw();
}

void onDrawScene(int eye) {
  lights();
  background(10);
  fill(255);

  scene.update();
  scene.display();
}

void addDataBindingSchemas() {
  File dir = new File(dataPath(""));
  File[] files = dir.listFiles();

  schemas = new ArrayList<DataBindingSchema>();

  for (int i = 0; i < files.length; i++) {
    String path = files[i].getAbsolutePath();

    if (path.toLowerCase().endsWith(".yaml")) {
      DataBindingSchema dbs = new DataBindingSchema(path);
      schemas.add(dbs);
    }
  }
}

void switchDataBindingSchema(DataBindingSchema s) {
  scene.clear_scene();
  data_binding = new DataBinding(data_handler, s);
  scene.primitive_groups.add(data_binding.bind());
}

void keyPressed() {
  if (key == '0') {
    switchDataBindingSchema(schemas.get(0));
  } else if (key == '1') {
    switchDataBindingSchema(schemas.get(1));
  } else if (key == 'r') {
    randomPositions();
  } else if (key == 'a') {
    switchAxes();
  }
}


void switchAxes() {
  if (scene.axes.size() > 0) {
    scene.remove_axes();
  } else {
    scene.add_axes();
  }
}

void randomPositions() {
  for (PrimitiveGroup p_g : scene.primitive_groups) {
    for (Primitive p : p_g.primitives ) {
      p.randomLocation();
    };
  }
}


