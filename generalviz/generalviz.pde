import peasy.*;

import java.awt.Frame;
import java.awt.BorderLayout;
import java.io.File;

import controlP5.*;

private ControlP5 cp5;

ControlFrame cf;
DropdownList ddl;

PeasyCam cam;

Axis axis1;
Axis axis2;
Axis axis3;

Scene scene;

ArrayList<DataBindingSchema> schemas;

DataHandler data_handler;
DataBinding data_binding;

void setup() {
  size( 320, 320, OPENGL );

  data_handler = new DataHandler("testdata.csv");
 
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

  cp5 = new ControlP5(this);
  cf = addControlFrame("extra", 200, 200, schemas);

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

// ControlP5 stuff here

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
    ddl = cp5.addDropdownList("activeDataBinding").setPosition(10, 10);
    for (int i = 0; i < schemas.size (); i++) {
      ddl.addItem(schemas.get(i).get("name"), i);
    }
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

  void controlEvent(ControlEvent theEvent) {

    if (theEvent.isGroup()) {
    } 
    else if (theEvent.isController()) {
      int v = (int) theEvent.getController().getValue();

      if (v < schemas.size()) {
        switchDataBindingSchema(schemas.get(v));
      }
    }
  }


  public ControlP5 control() {
    return cp5;
  }

  ControlP5 cp5;

  Object parent;
}

