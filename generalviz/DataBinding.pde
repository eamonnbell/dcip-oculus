import java.util.*;


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

    HashMap color_map = colorify();    
    
    for (int i = 0; i < data_handler.table.getRowCount(); i++) {
      TableRow row = data_handler.table.getRow(i);
      
      PVector rand_loc = PVector.random3D();  
      rand_loc.mult(100);
      
      color rand_color = color(random(255), random(255), random(255));
      
      int primitive_size = row.getInt(data_binding_schema.get("size"));
      
      int primitive_type = int(data_binding_schema.get("primitive_type"));
      
      PrimitiveFactory pf = new PrimitiveFactory(primitive_type);
      Primitive p = pf.get();
      
      p.setSize(primitive_size);
      p.setLocation(rand_loc);
      
      color[] pal = {#ffff00, #ff0000, #33ff00};
      
    
//      p.setColor(pal[color_map.get(row.getString(data_binding_schema.get("fill_color")))]);
      p.setColor(pal[0]);           
      primitives.add(p);
    }
 
    primitive_group.populate(primitives);
    return primitive_group;
  }
  
  HashMap colorify() {
    HashMap<String, Integer> color_map = new HashMap<String, Integer>();
    
    int track = 0;

    for (int i = 0; i < data_handler.table.getRowCount(); i++) {
      TableRow row = data_handler.table.getRow(i);
      
      String obs = row.getString(data_binding_schema.get("fill_color"));
      
      if (color_map.containsKey(obs)) {
        // don't do anything
      }
      else {
        color_map.put(obs, track);
        track += 1;
      }
      
      println(color_map);
      
    }
       
    return color_map;
  }
  
  void validate() {
    // Validate the applicability of a schema w.r.t. the data from the DataHandler
    // Throws an Exception if it's messed up.
    
//    println(data_handler.table.columnTitles);
  }
}


