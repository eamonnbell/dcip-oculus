import java.util.*;
import java.text.*;
import java.nio.file.*;


class BlobComplex {
  Table table = loadTable("data.csv", "header");
  int blobcount = table.getRowCount();


  Blob[] blobs = new Blob[blobcount];

  BlobComplex() {
    Table table = loadTable("data.csv", "header");


    for (int i = 0; i < table.getRowCount (); i++) {
      TableRow row = table.getRow(i);

      PVector rand_loc = PVector.random3D();  
      rand_loc.mult(100);      

      Date blobDate = null;
      SimpleDateFormat isoSDF = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");

      try {
        blobDate = isoSDF.parse(row.getString("time"));
      } 
      catch (Exception e) {
        println("Unable to parse date stamp.");
      }

      blobs[i] = new Blob(rand_loc, row.getInt("size"), blobDate, row.getString("filename"));
    }
  }

  void update() {
    // Update every Blob in the BlobComplex
    for (int i = 0; i < blobs.length; i++) {
      blobs[i].update();
    }
  }

  void display() {
    // Update every Blob in the BlobComplex
    for (int i = 0; i < blobs.length; i++) {
      blobs[i].display();
    }
  }
}
