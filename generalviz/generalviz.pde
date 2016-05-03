import java.io.File;

OculusRift oculus;
PVector position;

Scene scene;

ArrayList<DataBindingSchema> schemas;

DataHandler data_handler;
DataBinding data_binding;

boolean isFullScreen = false;

boolean sketchFullScreen() {
  return isFullScreen;
}

void setup() {
  size( 1920, 1080, OPENGL );

  oculus = new OculusRift(this);
  oculus.enableHeadTracking();

  position = new PVector( 0, 0, 0); 

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

  translate( position.x, position.y, position.z  );

  // stereoscopy happens here
  if (eye == 1) {
    translate( 10, 0, 0);
  }

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

void mouseDragged() {
  float x_scaled = map(mouseX, 0, height, -1, 1);
  float y_scaled = map(mouseY, 0, width, -1, 1);

  scene.vr_listener.direction.x = x_scaled;
  scene.vr_listener.direction.y = y_scaled;
}

void keyPressed() {
  if (key == '[') {
    switchDataBindingSchema(schemas.get(0));
  }

  if (key == ']') {
    switchDataBindingSchema(schemas.get(1));
  } 

  if (key == 'r') {
    randomPositions();
  } 
  if (key == 'x') {
    switchAxes();
  } 

  if (key=='p') {
    scene.play();
  }

  if (key=='q') {
    print_debug_info();
  }

  if (key==' ') {
    if (oculus.isUsingHeadTracking) {
      oculus.resetHeadState();
    } else {
      println("HMD is not using head tracking; resetting head state makes no sense.");
    }
  }

  if (key=='a') {
    scene.vr_listener.location.x += 20;
  }

  if (key=='d') {
    scene.vr_listener.location.x -= 20;
  }

  if (key=='w') {
    scene.vr_listener.location.z += 20;
  }

  if (key=='s') {
    scene.vr_listener.location.z -= 20;
  }

  if (key=='q') {
    scene.vr_listener.location.y -= 20;
  }

  if (key=='e') {
    scene.vr_listener.location.y += 20;
  }

  if (Character.isDigit(key)) {
    for (PrimitiveGroup p_g : scene.primitive_groups) {
      Primitive p = p_g.primitives.get(int(key) - 49);
      p.toggle();
    }
  }


  if (keyCode==LEFT) {
    position.x += 20;
  }

  if (keyCode==RIGHT) {
    position.x -= 20;
  }

  if (keyCode==UP) {
    position.z += 20;
  }

  if (keyCode==DOWN) {
    position.z -= 20;
  }
}

void print_debug_info() {
  println("VR listener");
  println("location field");
  println(scene.vr_listener.location);
  println("direction field");
  println(scene.vr_listener.direction);
  println("Listener position");
  println(Listener.getPosition());
  println("Listener direction");
  println(Listener.getDirection());

  println("Primitives");

  for (PrimitiveGroup p_g : scene.primitive_groups) {
    for (Primitive p : p_g.primitives) {
      println("location field");
      println(p.location);
      println("SoundSource position");
      println(p.sound.getPosition());
    }
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

