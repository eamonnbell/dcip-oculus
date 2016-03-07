import java.io.FileReader;
import com.esotericsoftware.yamlbeans.YamlReader;

class DataBindingSchema {

  HashMap<String, String> schema;

  DataBindingSchema() {
    schema = new HashMap<String, String>();
  }
  
  DataBindingSchema(String filename) {
    try {
    YamlReader reader = new YamlReader(new FileReader(filename));
    Object object = reader.read();
    schema = (HashMap<String, String>) object;
    String name = filename.substring(filename.lastIndexOf('/') + 1);
    schema.put("name", name);
    
  } catch (Exception exc) {
      exc.printStackTrace();
    }
  }
  
  String get(String s) {
    return schema.get(s);
  }
}

