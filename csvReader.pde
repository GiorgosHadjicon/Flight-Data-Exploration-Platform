import processing.data.Table;
import processing.data.TableRow;
import java.util.ArrayList;

class FlightDataReader {
  
  // Flight class to store each row's data
  class Flight {
    String date;
    String carrier;
    int flightNum;
    String origin;
    String originCity;
    String originState;
    int originWAC;
    String dest;
    String destCity;
    String destState;
    int destWAC;
    int crsDepTime;
    int depTime;
    int crsArrTime;
    int arrTime;
    float cancelled;
    float diverted;
    float distance;
    
    Flight(TableRow row) {
      date         = row.getString("FL_DATE");
      carrier      = row.getString("MKT_CARRIER");
      flightNum    = row.getInt("MKT_CARRIER_FL_NUM");
      origin       = row.getString("ORIGIN");
      originCity   = row.getString("ORIGIN_CITY_NAME");
      originState  = row.getString("ORIGIN_STATE_ABR");
      originWAC    = row.getInt("ORIGIN_WAC");
      dest         = row.getString("DEST");
      destCity     = row.getString("DEST_CITY_NAME");
      destState    = row.getString("DEST_STATE_ABR");
      destWAC      = row.getInt("DEST_WAC");
      crsDepTime   = row.getInt("CRS_DEP_TIME");
      depTime      = row.getInt("DEP_TIME");
      crsArrTime   = row.getInt("CRS_ARR_TIME");
      arrTime      = row.getInt("ARR_TIME");
      cancelled    = row.getFloat("CANCELLED");
      diverted     = row.getFloat("DIVERTED");
      distance     = row.getFloat("DISTANCE");
    }
  }
  
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
      Flight flight = new Flight(row);
      flights.add(flight);
    }
    
    return flights;
  }
 
}
