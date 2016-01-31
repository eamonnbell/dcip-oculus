import java.util.*;
import java.text.*;
import java.nio.file.*;


class PrimitiveGroup {
  Table table = loadTable("data.csv", "header");
  int primitivecount = table.getRowCount();


  Primitive[] primitives = new Primitive[primitivecount];

  PrimitiveGroup() {
    Table table = loadTable("data.csv", "header");


    for (int i = 0; i < table.getRowCount (); i++) {
      TableRow row = table.getRow(i);

      PVector rand_loc = PVector.random3D();  
      rand_loc.mult(100);      

      Date primitiveDate = null;
      SimpleDateFormat isoSDF = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");

      try {
        primitiveDate = isoSDF.parse(row.getString("time"));
      } 
      catch (Exception e) {
        println("Unable to parse date stamp.");
      }

      primitives[i] = new PrimitiveSphere(rand_loc, row.getInt("size"), primitiveDate, row.getString("filename"));
      println(primitives[i].location);
    }
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
}
