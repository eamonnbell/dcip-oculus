class DataBinding {
  // A DataBinding takes a DataHandler and a DataBindingSchema
  // and returns an ArrayList of Primitives.
  
  DataHandler data_handler;
  HashMap<String, String> bind_schema;
  
  DataBinding(DataHandler data_handler_) {
    data_handler = data_handler_;
    bind_schema = new HashMap<String, String>();

    // BindSchema will be a mapping from data columns to Primitive properties
    // It'll actually have to be Primitive-aware, somehow
    // Will also have functionality for simple preprocessing
    // 1. scaling
    // 2. "factoring" e.g. mapping colors to categorical variables in the data     
    bind_schema.put("size", "volume");
  }

  ArrayList bind() {

    ArrayList<Primitive> primitives = new ArrayList<Primitive>();

    // Perform an almost trivial data binding.
    // Later this will be implemented using a grammar of some kind.
    for (int i = 0; i < data_handler.table.getRowCount (); i++) {
      TableRow row = data_handler.table.getRow(i);
      PVector rand_loc = PVector.random3D();  
      rand_loc.mult(100);
      
      int primitive_size = row.getInt(bind_schema.get("size"));
      
      primitives.add(new PrimitiveSpike(rand_loc, primitive_size));
    }
    
    return primitives;
  }
}

