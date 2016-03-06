import peasy.*;

import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;

private ControlP5 cp5;

int def;

ControlFrame cf;

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
  
  cp5 = new ControlP5(this);
  cf = addControlFrame("extra", 200,200);
  
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  
  scene = new Scene(true);
  
  data_handler = new DataHandler("testdata.csv");
    
  data_binding_schema_a = new DataBindingSchema("/home/eamonn/Projects/dcip-oculus/generalviz/data/testA.yaml");
  data_binding_schema_b = new DataBindingSchema("/home/eamonn/Projects/dcip-oculus/generalviz/data/testB.yaml");
      
  data_binding = new DataBinding(data_handler, data_binding_schema_a);
  scene.primitive_groups.add(data_binding.bind());
  
  noStroke();
 
}

void draw() {
    lights();
    background(def);
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

// ControlP5 stuff here

ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(100, 100);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}


// the ControlFrame class extends PApplet, so we 
// are creating a new processing applet inside a
// new frame with a controlP5 object loaded
public class ControlFrame extends PApplet {

  int w, h;

  int abc = 100;
  
  public void setup() {
    size(w, h);
    frameRate(25);
    cp5 = new ControlP5(this);
    cp5.addSlider("abc").setRange(0, 255).setPosition(10,10);
    cp5.addSlider("def").plugTo(parent,"def").setRange(0, 255).setPosition(10,30);
  }

  public void draw() {
      background(abc);
  }
  
  private ControlFrame() {
  }

  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }


  public ControlP5 control() {
    return cp5;
  }
  
  
  ControlP5 cp5;

  Object parent;

}



