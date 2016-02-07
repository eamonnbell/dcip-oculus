class DataBindingSchema {

  HashMap<String, String> schema;

  DataBindingSchema() {
    schema = new HashMap<String, String>();
    schema.put("size", "volume");
  }
  
  String get(String s) {
    return schema.get(s);
  }
}

