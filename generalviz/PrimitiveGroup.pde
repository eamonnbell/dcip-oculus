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

  void display() {
    // Display every Primitive in the PrimitiveGroup
    for (Primitive p : primitives) {
      p.display();
    }
  }

  void populate(ArrayList<Primitive> primitives_in) {
    for (Primitive p_in : primitives_in) {
      primitives.add(p_in);
    }
  }
  
  void test_populate() {
    // Populate the PrimitiveGroup with junk
    for (int i = 0; i < 30; i++) {
      PVector rand_loc = PVector.random3D();  
      rand_loc.mult(100);

      int rand_size = int(random(10, 45));
      
      if (i % 2 == 0) {
        primitives.add(new PrimitiveSphere(rand_loc, rand_size));
      } else {
        primitives.add(new PrimitiveCube(rand_loc, rand_size));
      }
    }
  }
}

