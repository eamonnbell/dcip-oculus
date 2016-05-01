class DataHandler {
  String filename;
  Table table;
  String[] column_titles = {}; 

  DataHandler(String filename_) {
    filename = filename_;
    table = loadTable(filename, "header");    

    // Uses reflection to make the private columnTitles field readable
    // for use in a DataBindingSchema validator later on
    try {
      java.lang.reflect.Field f = table.getClass().getDeclaredField("columnTitles");
      f.setAccessible(true);
      column_titles = (String[]) f.get(table);
    } 
    catch (Exception exc) {
      exc.printStackTrace();
    }
  }
  
  String[] get_column_titles() {
    return this.column_titles;
  }
}

