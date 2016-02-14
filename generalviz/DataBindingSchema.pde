class DataBindingSchema {

  HashMap<String, String> schema;

  DataBindingSchema() {
    schema = new HashMap<String, String>();
    schema.put("size", "volume");
    schema.put("primitive_type", "0");
  }
  
  String get(String s) {
    return schema.get(s);
  }
}

