class DataBindingSchema {

  HashMap<String, String> schema;

  DataBindingSchema() {
    schema = new HashMap<String, String>();
  }
  
  String get(String s) {
    return schema.get(s);
  }
}

