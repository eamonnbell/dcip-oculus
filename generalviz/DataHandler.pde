class DataHandler {
  String filename;
  Table table;
  TableRow header_tr;
  
  ArrayList<String> headings;
  String[] column_titles; 
  
  DataHandler(String filename_) {
    filename = filename_;
    table = loadTable(filename, "header");
    println(Table.class.getDeclaredFields());
//    column_titles = table.columnTitles;
        
  }
}

