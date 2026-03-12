//====================
// Search Results Screen (one off object)
//====================

// draw things when this screen is selected
// airport like bar with results and ability to select specific flight ( maybe show details button here)

class Search_Results {

  ArrayList<Flight> flightsFiltered;
  PFont textDisplay;
  WidgetList flightWidgetList;
  boolean buttonsCreated = false;
  
  // Constructor takes in array of flights that has been already filtered and stores them
  Search_Results(ArrayList<Flight> flightsFiltered) {
  
    textDisplay = loadFont("AlTarikh-48.vlw");
    this.flightsFiltered = flightsFiltered;
    flightWidgetList = new WidgetList();
    
  }
  
  
  void drawDepartureFromDate(int userDateDeparture) {
     
    stroke(0);
    strokeWeight(5);
    fill(180);
    rect(500, 200, 500, 400, 5);
    
    stroke(0);
    strokeWeight(5);
    fill(0, 100, 255);
    rect(525, 225, 450, 350, 5);
    flightWidgetList.display();
    int yIncrement = 0;
    
    //TODO: Add title and make them into buttons
    
    for (int i = 0; i < flightsFiltered.size(); i++) {
      Flight currentFlight = flights.get(i);
      if (currentFlight.flightDate.day == userDateDeparture && yIncrement <= 9) {
        yIncrement++;
        int yPos = 300 + (yIncrement * 25); // Spacing each line 40 pixels apart
        fill(0);
        textSize(13);
        if (!buttonsCreated) {
          flightWidgetList.add( new Button(530, yPos - 10, 440, 20, "", color(180), color(200), color(0, 255, 0)) );
        }
        text(currentFlight.getDate(), 565, yPos);
        text(currentFlight.getOriginCityName(), 665, yPos);
        text(currentFlight.getDestinationCityName(), 805, yPos);
        text(currentFlight.getDepartureTime(), 895, yPos);
        text(currentFlight.getArrivalTime(), 945, yPos);
      }        
    }
    buttonsCreated = true;
  }
 
}
