class DataBindingSchema {

  HashMap<String, String> schema;

  DataBindingSchema() {
    schema = new HashMap<String, String>();
    schema.put("size", "volume");
    schema.put("primitive_type", "1");
    schema.put("fill_color", "volume");
    schema.put("fill_color_type", "quantitative");
    
  }
  
  String get(String s) {
    return schema.get(s);
  }
}

