class DataBinding {
  // A DataBinding takes a DataHandler and returns an ArrayList of Primitives
  
  DataHandler data_handler;
  
  DataBinding(DataHandler data_handler_) {
    data_handler = data_handler_;
  }

  ArrayList bind() {

    ArrayList<Primitive> primitives = new ArrayList<Primitive>();

    // Perform a trivial data binding. For every row in the table, make a random cube
    // Later this will be implemented using a grammar of some kind.
    for (int i = 0; i < data_handler.table.getRowCount (); i++) {
      PVector rand_loc = PVector.random3D();  
      rand_loc.mult(100);
      primitives.add(new PrimitiveCube(rand_loc, 10));
    }
    
    return primitives;
  }
}

