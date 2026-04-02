class Flight {
  Date flightDate;
  String flightDateString;
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
  
  
  // Description: Creates a flight object that has attributes of all the data provided in the csv file
  // Parameters: read from the csv file all data points of the flights
  Flight(String flightDate, String mktCarrier, int mktCarrierFlightNum, String origin, String originCityName, String originStateAbbreviation, 
        int originWac, String destination, String destinationCityName, String destinationStateAbbreviation, int destinationWac, 
        int crsDepartureTime, int departureTime, int crsArrivalTime, int arrivalTime, float cancelled, float diverted, float distance) {
    
        this.flightDate = new Date(flightDate);
        flightDateString = this.flightDate.getDateString();
        this.mktCarrier = mktCarrier; 
        this.mktCarrierFlightNum = mktCarrierFlightNum;
        this.origin = origin; 
        this.originCityName = originCityName;
        this.originStateAbbreviation = originStateAbbreviation;
        this.originWac = originWac;
        this.destination = destination;
        this.destinationCityName = destinationCityName;
        this.destinationStateAbbreviation = destinationStateAbbreviation;
        this.destinationWac = destinationWac;
        this.crsDepartureTime = crsDepartureTime;
        this.departureTime = departureTime;
        this.crsArrivalTime = crsArrivalTime;
        this.arrivalTime = arrivalTime;
        
        // Converts the cancelled and diverted data from floats to boolean
        if (cancelled < 1.0) {
          this.cancelled = false;
        }
        else {
          this.cancelled = true;
        }
        
        if (diverted < 1.0) {
          this.diverted = false;
        }
        else {
          this.diverted = true;
        }
        
        this.distance = distance;
  }
  
  // Returns date as a string
  String getDate() {
    String data = "";
    data += flightDate.day + "/" + flightDate.month + "/" + flightDate.year;
    return data;
  }

// Returns Origin City as a string
// If it is greater than 25 characters truncate it
  String getOriginCityName() {
    String data = "";
    data += originCityName;
    if(data.length() > 25) {
      String [] result = data.split("/");
      for (int i = 1; i < result.length; i++ ){
        if (i != 1) {
          data += "/" + result[i];
        }
        else {
          data = result[i];
        }
      }
    }
    return data;
  }
  
  // Returns origin airport as a string
  String getOriginAirport() {
    String data = "";
    data += origin;
    return data;
  }
  
  // Returns destination airport as a string
  String getDestinationAirport() {
    String data = "";
    data += destination;
    return data;
  }
  
  // Returns destination city as a string
  String getDestinationCityName() {
    String data = "";
    data += destinationCityName;
    return data;
  }
  
  // Returns time as a string
  // converts the time from the csv file to the format of '0000'
  String getDepartureTime() {
    String data = "";
    if (this.departureTime >= 1000) {
      data += departureTime;
    }
    
    else  if (this.departureTime >= 100){
      data += "0" + departureTime;
    }
    
    else  if (this.departureTime >= 10){
      data += "00" + departureTime;
    }
    
    else  if (this.departureTime >= 1){
      data += "000" + departureTime;
    }
    
    else {
      data = "0000";
    }
    
    return data;
  }
  
    String getArrivalTime() {
    String data = "";
    if (this.arrivalTime >= 1000) {
      data += arrivalTime;
    }
    
    else  if (this.arrivalTime >= 100){
      data += "0" + arrivalTime;
    }
    
    else  if (this.arrivalTime >= 10){
      data += "00" + arrivalTime;
    }
    
    else  if (this.arrivalTime >= 1){
      data += "000" + arrivalTime;
    }
    
    else {
      data = "0000";
    }
    return data;
  }
  
}
