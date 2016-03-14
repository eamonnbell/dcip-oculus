import peasy.*;

import java.awt.Frame;
import java.awt.BorderLayout;
import java.io.File;

import controlP5.*;

private ControlP5 cp5;

ControlFrame cf;

PeasyCam cam;

Scene scene;

ArrayList<DataBindingSchema> schemas;

DataHandler data_handler;
DataBinding data_binding;

void setup() {
  size( 640, 640, OPENGL );

  data_handler = new DataHandler("testdata.csv");
 
  File dir = new File(dataPath(""));
  File[] files = dir.listFiles();
  
  schemas = new ArrayList<DataBindingSchema>();

  for(int i = 0; i < files.length; i++) {
    String path = files[i].getAbsolutePath();
    
    if (path.toLowerCase().endsWith(".yaml")) {
      DataBindingSchema dbs = new DataBindingSchema(path);
      schemas.add(dbs);
    }
   }

  cp5 = new ControlP5(this);
  cf = addControlFrame("Scene Control", 120, 150, schemas);

  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);

  scene = new Scene(true);


  data_binding = new DataBinding(data_handler, schemas.get(0));
  scene.primitive_groups.add(data_binding.bind());

  noStroke();
}

void draw() {
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

  for(int i = 0; i < files.length; i++) {
    String path = files[i].getAbsolutePath();
    
    if (path.toLowerCase().endsWith(".yaml")) {
      DataBindingSchema dbs = new DataBindingSchema(path);
      println(path);
      schemas.add(dbs);
    }
   }
}

void switchDataBindingSchema(DataBindingSchema s) {
  scene.clear_scene();
  data_binding = new DataBinding(data_handler, s);
  scene.primitive_groups.add(data_binding.bind());
}

void switchAxes() {
  if (scene.axes.size() > 0) {
    scene.remove_axes();
  }
  else {
    scene.add_axes();
  }
}

void randomPositions() {
  for (PrimitiveGroup p_g : scene.primitive_groups) {
      for (Primitive p: p_g.primitives ) {
        p.randomLocation();
      };
    }
}


////////////////////////
// ControlP5 stuff here
//


ControlFrame addControlFrame(String theName, int theWidth, int theHeight, ArrayList<DataBindingSchema> theSchemas) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight, theSchemas);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(100, 100);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}

public class ControlFrame extends PApplet {

  int w, h;
  ArrayList<DataBindingSchema> schemas;


  int abc = 100;

  public void setup() {
    size(w, h);
    frameRate(25);
    cp5 = new ControlP5(this);
    
    DropdownList ddl = cp5.addDropdownList("activeDataBinding").setPosition(10, 40);
    
    for (int i = 0; i < schemas.size (); i++) {
      ddl.addItem(schemas.get(i).get("name"), i);
    }
    
    cp5.addButton("doSwitchAxes").setPosition(10, 10).setSize(100, 13);
    cp5.addButton("doRandomPositions").setPosition(10, 25).setSize(100, 13);
  }

  public void draw() {
    background(abc);
  }

  private ControlFrame() {
  }

  public ControlFrame(Object theParent, int theWidth, int theHeight, ArrayList<DataBindingSchema> theSchemas) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
    schemas = theSchemas;
  }
  
  public void activeDataBinding(int theValue) {
    
    if (theValue < schemas.size()) {
        switchDataBindingSchema(schemas.get(theValue));
      };
  }
  
  public void doSwitchAxes(int theValue) {
    switchAxes();
  }
  
  public void doRandomPositions(int theValue) {
    randomPositions();
  }

  public ControlP5 control() {
    return cp5;
  }

  ControlP5 cp5;

  Object parent;
}

