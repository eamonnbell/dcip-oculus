class DataBinding {
  // A DataBinding takes a DataHandler and a DataBindingSchema
  // and returns an ArrayList of Primitives.
  
  DataHandler data_handler;
  DataBindingSchema data_binding_schema;
  
  DataBinding(DataHandler data_handler_, DataBindingSchema data_binding_schema_) {
    data_handler = data_handler_;
    data_binding_schema = data_binding_schema_;
    this.validate();   
  }

  PrimitiveGroup bind() {

    ArrayList<Primitive> primitives = new ArrayList<Primitive>();
    PrimitiveGroup primitive_group = new PrimitiveGroup();
    
    // Perform an almost trivial data binding.
    // Later this will be implemented using a grammar of some kind.
    for (int i = 0; i < data_handler.table.getRowCount (); i++) {
      TableRow row = data_handler.table.getRow(i);
      
      PVector rand_loc = PVector.random3D();  
      rand_loc.mult(100);
      
      int primitive_size = row.getInt(data_binding_schema.get("size"));
      
      primitives.add(new PrimitiveSpike(rand_loc, primitive_size));
    }
 
    primitive_group.populate(primitives);
    return primitive_group;
  }
  
  void validate() {
    // Validate the applicability of a schema w.r.t. the data from the DataHandler
    // Throws an Exception if it's messed up.
    
//    println(data_handler.table.columnTitles);
  }
}


