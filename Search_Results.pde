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
  
  
  void drawDeparture(int pageNum) {
    
    stroke(0);
    strokeWeight(0);
    fill(255);
    rect(332, 145, 834, 462);
    
    flightWidgetList.displayWidgets();
    int yIncrement = 0;
    
    // Creates buttons for choosing date, origin, destination, departure time, and arrival time
    if (!buttonsCreated) {
      textSize(13);
      flightWidgetList.add( new Button(352, 250, 70, 40, "Date", color(180), color(120), color(0, 255, 0) , 2) );
      flightWidgetList.add( new Button(442, 250, 80, 40, "Origin", color(180), color(120), color(0, 255, 0) , 2) );
      flightWidgetList.add( new Button(542, 250, 120, 40, "Origin City", color(180), color(120), color(0, 255, 0), 2) );
      flightWidgetList.add( new Button(682, 250, 125, 40, "Destination", color(180), color(120), color(0, 255, 0), 2) );
      flightWidgetList.add( new Button(827, 250, 165, 40, "Destination City", color(180), color(120), color(0, 255, 0), 2) );
      flightWidgetList.add( new Button(1012, 250, 50, 40, "Dep.", color(180), color(120), color(0, 255, 0), 2) );
      flightWidgetList.add( new Button(1082, 250, 50, 40, "Arr.", color(180), color(120), color(0, 255, 0), 2) );
    }
    
    for (int i = (pageNum - 1) * 10; i < flightsFiltered.size(); i++) {
      Flight currentFlight = flightsFiltered.get(i);
      if (yIncrement <= 9) {
        yIncrement++;
        int yPos = 300 + (yIncrement * 25); // Spacing each line 40 pixels apart
        fill(0);
        textSize(13);
        if (!buttonsCreated) {
          flightWidgetList.add( new Button(352, yPos - 10, 780, 20, "", color(180), color(200), color(0, 255, 0), 3) );
        }
        text(currentFlight.getDate(), 390, yPos);
        text(currentFlight.getOriginAirport(), 480, yPos);
        text(currentFlight.getOriginCityName(), 605, yPos);
        text(currentFlight.getDestinationAirport(), 740, yPos);
        text(currentFlight.getDestinationCityName(), 910, yPos);
        text(currentFlight.getDepartureTime(), 1038, yPos);
        text(currentFlight.getArrivalTime(), 1108, yPos);
      }        
    }
    buttonsCreated = true;
    
  }
 
}
