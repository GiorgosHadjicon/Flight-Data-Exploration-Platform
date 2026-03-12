//================================
// Search backend (one off object)
//================================

// construtor takes in array list of all flight data
// search method having every field have an empty default value and oly search non default values passed in

class Searcher {
   ArrayList<Flight> SearchedFLights;
   ArrayList<Flight> tempArray;
   
   // Search parameters
   Date flightDate;
   String mktCarrier;
   int mktCarrierFlightNum;
   String origin;
   String originCityName;
   String originStateAbbreviation;
   int originWac;
   String destination;
   String destinationCityName;
   String destinationStateAbbreviation;
   int destinationWac;
   int crsDepartureTime;
   int departureTime;
   int crsArrivalTime;
   int arrivalTime;
   boolean cancelled;
   boolean diverted;
   float distance;
   
   Searcher(ArrayList<Flight> allFlights){
     // Constructor Parameteres:
     // ArrayList<Flight> AllFlights - The array list of all flights loaded into the program.
     // Description: Every field will be hashed using hashmaps for instant access.
     
     HashMap<String, ArrayList<Flight>> flightOrigins = new HashMap<>();
     HashMap<String, ArrayList<Flight>> flightOriginCityNames = new HashMap<>();
     // the rest of the hashmaps go here...
     
     for (int i = 0; i < allFlights.size(); i++){
       Flight currentFlight = allFlights.get(i);
       
       // Hashing all origins
       String origin = currentFlight.origin;
       if (flightOrigins.containsKey(origin)){
         tempArray = flightOrigins.get(origin);
         tempArray.add(currentFlight);
         flightOrigins.put(origin, tempArray);
       } else {
         tempArray.clear();
         tempArray.add(currentFlight);
         flightOrigins.put(origin, tempArray);
       }
       
       // Hashing all origin city names
       String originCityNames = currentFlight.originCityName;
       if (flightOriginCityNames.containsKey(originCityNames)){
         tempArray = flightOriginCityNames.get(originCityNames);
         tempArray.add(currentFlight);
         flightOriginCityNames.put(originCityNames, tempArray);
       } else {
         tempArray.clear();
         tempArray.add(currentFlight);
         flightOriginCityNames.put(originCityNames, tempArray);
       }
     }
   }
   
   ArrayList<Flight> Search(String flightDate, String mktCarrier, int mktCarrierFlightNum, String origin, String originCityName, String originStateAbbreviation, 
                            int originWac, String destination, String destinationCityName, String destinationStateAbbreviation, int destinationWac, 
                            int crsDepartureTime, int departureTime, int crsArrivalTime, int arrivalTime, float cancelled, float diverted, float distance){
     
   }
}
