class DataHandler {
  String filename;
  Table table;
  Table table_two;
  
  ArrayList<String> headings;
  String[] column_titles; 
  
  DataHandler(String filename_) {
    filename = filename_;
    table = loadTable(filename, "header");
    table_two = loadTable(filename);
//    println(Table.class.getDeclaredFields());
//    column_titles = table.columnTitles;
        
  }
}

