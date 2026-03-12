//================================
// Search backend (one off object)
//================================

// construtor takes in array list of all flight data
// search method having every field have an empty default value and oly search non default values passed in

class Searcher {
   // ArrayList Declarations
   ArrayList<Flight> SearchedFLights = new ArrayList<>();;
   ArrayList<Flight> tempArray = new ArrayList<>();
   
   // Hashmaps Declarations
   HashMap<String, ArrayList<Flight>> flightOrigins = new HashMap<>();
   HashMap<String, ArrayList<Flight>> flightOriginCityNames = new HashMap<>();
   // the rest of the hashmaps go here...
   
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
     
      for (Flight currentFlight : allFlights) {
      
        // Hashing all origins
        String currentOrigin = currentFlight.origin;
        // For new entries in the dictionary
        if (!flightOrigins.containsKey(currentOrigin)) {
          flightOrigins.put(currentOrigin, new ArrayList<Flight>());
        }
        // Updating the array list in the value of the dictionary
        flightOrigins.get(currentOrigin).add(currentFlight);
      
       
        // Hashing all origin city names
        String curentOriginCityName = currentFlight.originCityName; 
        // For new entries in the dictionary
        if (!flightOriginCityNames.containsKey(curentOriginCityName)) {
          flightOriginCityNames.put(curentOriginCityName, new ArrayList<Flight>());
        }
        // Updating the array list in the value of the dictionary
        flightOriginCityNames.get(curentOriginCityName).add(currentFlight);
       
     }
   }
   
   /*ArrayList<Flight> Search(String flightDate, String mktCarrier, int mktCarrierFlightNum, String origin, String originCityName, String originStateAbbreviation, 
                            int originWac, String destination, String destinationCityName, String destinationStateAbbreviation, int destinationWac, 
                            int crsDepartureTime, int departureTime, int crsArrivalTime, int arrivalTime, float cancelled, float diverted, float distance){
     
   }*/
   
   /*ArrayList<Flight> SearchTest(String originTest){
     for (String currentKey : flightOrigins.keySet()) {
        //key: currentKey, value: flightOrigins.get(currentKey)
        if (currentKey.equals(originTest)){
            System.out.println("key: " + currentKey + " value: " + flightOrigins.get(currentKey));
          
            return flightOrigins.get(currentKey);
        }
     }
     tempArray.clear();
     return tempArray;
   } */
   
}
