class Flight {

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
  
  Flight(String flightDate, String mktCarrier, int mktCarrierFlightNum, String origin, String originCityName, String originStateAbbreviation, 
        int originWac, String destination, String destinationCityName, String destinationStateAbbreviation, int destinationWac, 
        int crsDepartureTime, int departureTime, int crsArrivalTime, int arrivalTime, float cancelled, float diverted, float distance) {
    
        this.flightDate = new Date(flightDate);
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
  
  String getData() {
    String data = "";
    data += flightDate + ", " + origin + ", " + destination + ", " + arrivalTime;
    return data;
  }
  
}
