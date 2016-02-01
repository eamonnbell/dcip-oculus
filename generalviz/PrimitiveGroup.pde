import java.util.*;
import java.text.*;
import java.nio.file.*;

class PrimitiveGroup {

  Primitive[] primitives = new Primitive[30];

  PrimitiveGroup() {
    test_populate();
  }

  void update() {
    // Update every Primitive in the PrimitiveGroup
    for (int i = 0; i < primitives.length; i++) {
      primitives[i].update();
    }
  }

  void display() {
    // Update every Primitive in the PrimitiveGroup
    for (int i = 0; i < primitives.length; i++) {
      primitives[i].display();
    }
  }

//  void populate(ArrayList<primitive> primitives_ext) {
//     
//  }
  void test_populate() {
    // Populate the PrimitiveGroup with junk
    for (int i = 0; i < 30; i++) {
      PVector rand_loc = PVector.random3D();  
      rand_loc.mult(100);

      int rand_size = int(random(10, 45));


      if (i % 2 == 0) {
        primitives[i] = new PrimitiveSphere(rand_loc, rand_size);
      } else {
        primitives[i] = new PrimitiveCube(rand_loc, rand_size);
      }
    }
  }
}

