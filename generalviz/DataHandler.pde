class DataHandler {
  DataHandler(String filename_) {
    
    Table table = loadTable(filename_, "header");
    
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
    }
  }
}
