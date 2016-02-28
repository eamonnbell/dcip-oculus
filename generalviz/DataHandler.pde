class DataHandler {
  String filename;
  Table table;
  String[] column_titles = {}; 

  DataHandler(String filename_) {
    filename = filename_;
    table = loadTable(filename, "header");    

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

