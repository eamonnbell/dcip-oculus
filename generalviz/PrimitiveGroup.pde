import java.util.*;
import java.text.*;
import java.nio.file.*;

class PrimitiveGroup {

  ArrayList<Primitive> primitives = new ArrayList<Primitive>();

  PrimitiveGroup() {
  }

  void update() {
    // Update every Primitive in the PrimitiveGroup
    for (Primitive p : primitives) {
      p.update();
    }
  }

  void play() {
    for (Primitive p : primitives) {
      p.play();
    }
  }

  void display() {
    // Display every Primitive in the PrimitiveGroup
    for (Primitive p : primitives) {
      pushMatrix();
      p.display();
      popMatrix();
    }
  }

  void populate(ArrayList<Primitive> primitives_in) {
    for (Primitive p_in : primitives_in) {
      primitives.add(p_in);
    }
  }
  
  void depopulate() {
    this.primitives.clear();
  }
}

