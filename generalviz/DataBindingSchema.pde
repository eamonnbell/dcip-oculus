class DataBindingSchema {

  HashMap<String, String> schema;

  DataBindingSchema() {
    schema = new HashMap<String, String>();
    schema.put("size", "volume");
    schema.put("primitive_type", "1");
    schema.put("fill_color", "genre");
    schema.put("fill_color_type", "qualitative");
    
  }
  
  String get(String s) {
    return schema.get(s);
  }
}

