
// 2. Create the ArrayList to store all records
ArrayList<Flight> records = new ArrayList<Flight>();

void setup() {
  size(400, 200); // just to have a window
  
  String filename = "flights_full (1).csv";
  int maxRows = 100; // change or remove this line if you want all rows
  
  try {
    // Load the file.
    Table table = loadTable(filename, "header");
    
    if (table == null) {
      println("Error: Could not find the file. Make sure it's in the data folder.");
      return;
    }
    
    int count = 0;
    for (TableRow row : table.rows()) {
      if (maxRows > 0 && count >= maxRows) break;
      
      // Create a new FlightRecord and add it to the list
      Flight rec = new Flight(row);
      records.add(rec);
      count++;
    }
    
    println("Loaded " + records.size() + " records.");
    

    for (int i = 0; i < records.size(); i++) {
      records.get(i).display();
    }
    
  } catch (Exception e) {
    println("Something went wrong: " + e.getMessage());
  }
}

void draw() {
  // nothing here
}
