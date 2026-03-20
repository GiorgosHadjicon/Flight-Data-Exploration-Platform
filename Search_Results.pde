//====================
// Search Results Screen (one off object)
//====================

// draw things when this screen is selected
// airport like bar with results and ability to select specific flight ( maybe show details button here)

class Search_Results {

  ArrayList<Flight> flightsFiltered;
  PFont textDisplay;
  boolean buttonsCreated = false;
  int totalCountPages = 0;
  int iSet;
  
  // Constructor takes in array of flights that has been already filtered and stores them
  Search_Results(ArrayList<Flight> flightsFiltered) {
  
    textDisplay = loadFont("AlTarikh-48.vlw");
    this.flightsFiltered = flightsFiltered;
    
  }
  
  
  void drawDeparture(int pageNum) {
    
    stroke(0);
    strokeWeight(0);
    fill(255);
    rect(332, 145, 834, 463);
    
    widgetList.displayWidgets();
    int yIncrement = 0;
    
    // Creates buttons for choosing date, origin, destination, departure time, and arrival time
    if (!buttonsCreated) {
      textSize(13);
      widgetList.add( new Button(352, 170, 70, 40, "Date", color(180), color(120), color(0, 255, 0) , EVENT_NONE) );
      widgetList.add( new Button(442, 170, 80, 40, "Origin", color(180), color(120), color(0, 255, 0) , EVENT_NONE) );
      widgetList.add( new Button(542, 170, 120, 40, "Origin City", color(180), color(120), color(0, 255, 0), EVENT_NONE) );
      widgetList.add( new Button(682, 170, 125, 40, "Destination", color(180), color(120), color(0, 255, 0), EVENT_NONE) );
      widgetList.add( new Button(827, 170, 165, 40, "Destination City", color(180), color(120), color(0, 255, 0),EVENT_NONE) );
      widgetList.add( new Button(1012, 170, 50, 40, "Dep.", color(180), color(120), color(0, 255, 0), EVENT_NONE) );
      widgetList.add( new Button(1082, 170, 50, 40, "Arr.", color(180), color(120), color(0, 255, 0), EVENT_NONE) );
      
      if (flightsFiltered.size() < 12) {
        iSet = 0;
      }
      else {
        iSet = (pageNum - 1) * 12;
        
        if (flightsFiltered.size()  % 12 == 0) {
          totalCountPages = flightsFiltered.size() / 12;
        }
        else {
          totalCountPages = (int)(flightsFiltered.size() / 12) + 1;
        }
      }
    }
        
      for (int i = 1; i <= totalCountPages; i++) {
        if (totalCountPages >= 9) {
          if (i <= 8) {
            widgetList.add( new Button(630 + (i * 25), 550, 20, 20, String.valueOf(i), color(180), color(120), color(0, 255, 0) , EVENT_CHANGE_PAGE) );
          }
        }
        else {
          widgetList.add( new Button(670 + (i * 25), 550, 20, 20, String.valueOf(i), color(180), color(120), color(0, 255, 0) , EVENT_CHANGE_PAGE) );
        }
      }    

    if (pageChange) {
      widgetList.clearFlights();
      pageChange = false;
    }
    for (int i = iSet; i < flightsFiltered.size(); i++) {
      Flight currentFlight = flightsFiltered.get(i);
      if (yIncrement <= 11) {
        yIncrement++;
        int yPos = 220 + (yIncrement * 25); // Spacing each line 40 pixels apart
        fill(0);
        
        textSize(13);
        if (!buttonsCreated) {
          widgetList.add( new Button(352, yPos - 10, 780, 20, "", color(180), color(200), color(0, 255, 0), EVENT_DISPLAY_SINGLE_FLIGHT) );
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
