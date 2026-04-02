//================================
// Search backend (one off object)
//================================

// construtor takes in array list of all flight data
// search method having every field have an empty default value and oly search non default values passed in

class Searcher {
   // ArrayList Declarations
   ArrayList<Flight> SearchedFLights = new ArrayList<>();
   ArrayList<Flight> tempArray = new ArrayList<>();
   
   // Hashmaps Declarations
   HashMap<String, ArrayList<Flight>> flightDateStrings = new HashMap<>();
   HashMap<String, ArrayList<Flight>> flightOrigins = new HashMap<>();
   HashMap<String, ArrayList<Flight>> flightOriginCityNames = new HashMap<>();
   HashMap<String, ArrayList<Flight>> flightDestination = new HashMap<>();
   HashMap<String, ArrayList<Flight>> flightDestinationCityName = new HashMap<>();
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
        
        // Hashing all destinations
        String curentDestination = currentFlight.destination; 
        // For new entries in the dictionary
        if (!flightDestination.containsKey(curentDestination)) {
          flightDestination.put(curentDestination, new ArrayList<Flight>());
        }
        // Updating the array list in the value of the dictionary
        flightDestination.get(curentDestination).add(currentFlight);
        
        // Hashing all destination city names
        String curentDestinationCityName = currentFlight.destinationCityName; 
        // For new entries in the dictionary
        if (!flightDestinationCityName.containsKey(curentDestinationCityName)) {
          flightDestinationCityName.put(curentDestinationCityName, new ArrayList<Flight>());
        }
        // Updating the array list in the value of the dictionary
        flightDestinationCityName.get(curentDestinationCityName).add(currentFlight);
        
        // Hashing all flight dates
        String curentFlightDate = currentFlight.flightDateString; 
        // For new entries in the dictionary
        if (!flightDateStrings.containsKey(curentFlightDate)) {
          flightDateStrings.put(curentFlightDate, new ArrayList<Flight>());
        }
        // Updating the array list in the value of the dictionary
        flightDateStrings.get(curentFlightDate).add(currentFlight);
       
     }
   }
   
   ArrayList<Flight> Search(String flightDateString, String mktCarrier, int mktCarrierFlightNum, String origin, String originCityName, String originStateAbbreviation, 
                            int originWac, String destination, String destinationCityName, String destinationStateAbbreviation, int destinationWac, 
                            int crsDepartureTime, int departureTime, int crsArrivalTime, int arrivalTime, boolean cancelled, boolean diverted, float distance){
     // Default parameters for strings is "", for int/float is -1 and for booleans is false
     // The Search function accepts any flight atribute as a search parameter and only filters using any paramterer passed that is not the default parameter
     // Returns ArrayList<Flight>
     // Will return a list of all the flight objects resulting from the search
          
     // List of all the resulting ArrayLists from eatch search parameter
     ArrayList<ArrayList<Flight>> allLists = new ArrayList<ArrayList<Flight>>();
     // Will use a hash set to combine lists instantly
     HashSet<Flight> result;
     
     // If search parameter includes origin we assign originList the cirrect Array List for the hashmap
     if (!origin.equals("")){
       for (String currentKey : flightOrigins.keySet()) {
         //key: currentKey, value: flightOrigins.get(currentKey)
         if (currentKey.equals(origin)){
           allLists.add(flightOrigins.get(currentKey));
           break;
         }
       }
     }
     // Same search for originCityName 
     if (!originCityName.equals("")){
       for (String currentKey : flightOriginCityNames.keySet()) {
         //key: currentKey, value: "correctHashmap".get(currentKey)
         if (currentKey.equals(originCityName)){
           allLists.add(flightOriginCityNames.get(currentKey));
           break;
         }
       }
     }
     // Same search for date 
     if (!flightDateString.equals("")){
       for (String currentKey : flightDateStrings.keySet()) {
         if (currentKey.equals(flightDateString)){
           allLists.add(flightDateStrings.get(currentKey));
           break;
         }
       }
     }
     // Same search for destination 
     if (!destination.equals("")){
       for (String currentKey : flightDestination.keySet()) {
         if (currentKey.equals(destination)){
           allLists.add(flightDestination.get(currentKey));
           break;
         }
       }
     }
     // Same search for destination city names
     if (!destinationCityName.equals("")){
       for (String currentKey : flightDestinationCityName.keySet()) {
         if (currentKey.equals(destinationCityName)){
           allLists.add(flightDestinationCityName.get(currentKey));
           break;
         }
       }
     }
     
     // Combine all resulting ArrayLists into the final filtering with all used parameters
     // Starting with the first list
     result = new HashSet<Flight>(allLists.get(0));
     
     // intersect with the rest
     for (int i = 1; i < allLists.size(); i++) result.retainAll(allLists.get(i));
     
     // Coverting the hash set into a list of flights to resturn
     ArrayList<Flight> commonFlights = new ArrayList<Flight>(result);
     return commonFlights;   
   }
   
   // Return unique string lists (to be used in drop down search)
   ArrayList<String> GetDates(){
     return new ArrayList<String>(flightDateStrings.keySet());
   }
   
   ArrayList<String> GetOrigins(){
     return new ArrayList<String>(flightOrigins.keySet());
   }
   
   ArrayList<String> GetOriginCityNames(){
     return new ArrayList<String>(flightOriginCityNames.keySet());
   }
   
   ArrayList<String> GetDestinations(){
     return new ArrayList<String>(flightDestination.keySet());
   }
   
   ArrayList<String> GetDestinationCityNames(){
     return new ArrayList<String>(flightDestinationCityName.keySet());
   }
   
}
