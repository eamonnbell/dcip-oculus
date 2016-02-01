class DataHandler {
  String filename;
  Table table;

  DataHandler(String filename_) {
    filename = filename_;
    table = loadTable(filename, "header");
  }
}

