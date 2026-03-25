
import java.util.ArrayList;

class csvReader {
  
  
  // Method to read CSV and return ArrayList of Flight objects
  ArrayList<Flight> readCSV(String filename) {
    
    ArrayList<Flight> flights = new ArrayList<Flight>();
    
    Table table = loadTable(filename, "header");
    
    if (table == null) 
    {
      return flights; // return empty list if file not found
    }
    
    for (TableRow row : table.rows()) 
    {
      Flight flight = new Flight(
      row.getString("FL_DATE"),
      row.getString("MKT_CARRIER"),
      row.getInt("MKT_CARRIER_FL_NUM"),
      row.getString("ORIGIN"),
      row.getString("ORIGIN_CITY_NAME"),
      row.getString("ORIGIN_STATE_ABR"),
      row.getInt("ORIGIN_WAC"),
      row.getString("DEST"),
      row.getString("DEST_CITY_NAME"),
      row.getString("DEST_STATE_ABR"),
      row.getInt("DEST_WAC"),
      row.getInt("CRS_DEP_TIME"),
      row.getInt("DEP_TIME"),
      row.getInt("CRS_ARR_TIME"),
      row.getInt("ARR_TIME"),
      row.getFloat("CANCELLED"),
      row.getFloat("DIVERTED"),
      row.getFloat("DISTANCE")
      );
      flights.add(flight);
    }
    
    return flights;
  }
 
}
