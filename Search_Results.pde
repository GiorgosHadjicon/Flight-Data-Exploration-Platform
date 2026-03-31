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
  // Parameters: Take in an arraylist of the flights that have been filtered through the searching algorithm
  // Description: Creates another pointer to the global arraylist 'testFlights' to use in the class
  Search_Results(ArrayList<Flight> flightsFiltered) {
    pageChange = true;
    textDisplay = loadFont("AlTarikh-48.vlw");
    this.flightsFiltered = flightsFiltered;
    
  }
  
  
  // Parameter: takes in the page number as an int
  // Description: draws a display screen of the global arraylist called 'testFlights' and any changes that are made on it actively 
  void drawDeparture(int pageNum) {
    
    stroke(0);
    strokeWeight(0);
    fill(255);
    rect(332, 145, 834, 463);
    
    textAlign(CENTER, CENTER);
    
    widgetList.displayWidgets();
    int yIncrement = 0;
    
    // Creates buttons for choosing date, origin, destination, departure time, and arrival time
    if (!searchButtonsCreated) {
      textSize(15);

      widgetList.add( new Button(1012, 170, 50, 40, "Dep.", color(250), color(120), color(0, 255, 0), EVENT_NONE, false) );
      widgetList.add( new Button(1082, 170, 50, 40, "Arr.", color(250), color(120), color(0, 255, 0), EVENT_NONE, false) );
      widgetList.addDrop(new dropDownSearch(352, 170, 70, 40, "DATE", color(250), color(200), date, "date")); 
      widgetList.addDrop(new dropDownSearch(447, 170, 120, 40, "ORIGIN CITY", color(250), color(200), originsCityName, "originsCityName")); 
      widgetList.addDrop(new dropDownSearch(592, 170, 90, 40, "AIRPORT", color(250), color(200), origins, "origins")); 
      widgetList.addDrop(new dropDownSearch(707, 170, 165, 40, "DESTINATION CITY", color(250), color(200), destinationsCityName, "destinationsCityName")); 
      widgetList.addDrop(new dropDownSearch(897, 170, 90, 40, "AIRPORT", color(250), color(200), destinations, "destinations")); 

      widgetList.add(new Button(360, 555, 90, 30, "CLEAR",   color(255), color(255, 235, 235), color(255, 235, 235), EVENT_RESET_DROP_DOWN));
      searchButtonsCreated = true;
    }
      
    if (!buttonsCreated) {

     // Limits the number of flights shown in the screen and counts the number of pages it has
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
        

    if (pageChange) {
      widgetList.clearFlights();
      pageChange = false;
    }
    
    if (flightsFiltered.size() == 0) {
      pushStyle();
      fill(0);
      textAlign(CENTER, CENTER);
      textSize(25);
      text("NO FLIGHTS FOUND", 749, 376);
      popStyle();
    }
    
    for (int i = iSet; i < flightsFiltered.size(); i++) {
      Flight currentFlight = flightsFiltered.get(i);
      if (yIncrement <= 11) {
        yIncrement++;
        int yPos = 220 + (yIncrement * 25); // Spacing each line 40 pixels apart
        fill(0);
        
        textSize(13);
        if (!buttonsCreated) {
          if (i % 2 == 0) {
            Button b = new Button(332, yPos - 10, 834, 25, "", color(210), color(180), color(0, 255, 0), EVENT_DISPLAY_SINGLE_FLIGHT);
            b.flightIndex = i;   
            widgetList.add(b);
          }
          else {
            Button b = new Button(332, yPos - 10, 834, 25, "", color(255), color(170), color(0, 255, 0), EVENT_DISPLAY_SINGLE_FLIGHT);
            b.flightIndex = i;   
            widgetList.add(b);
          }
          
          for (int j = 1; j <= totalCountPages; j++) {
            if (totalCountPages >= 9) {
              if (j <= 8) {
                widgetList.add( new Button(610 + (j * 30), 550, 25, 25, String.valueOf(j), color(245, 247, 250), color(120), color(0, 255, 0) , EVENT_CHANGE_PAGE) );
              }
            }
            else {
              widgetList.add( new Button(610 + (j * 30), 550, 25, 25, String.valueOf(j), color(245, 247, 250), color(120), color(0, 255, 0) , EVENT_CHANGE_PAGE) );
            }
          }    

        }
        text(currentFlight.getDate(), 390, yPos);      
        
        text(currentFlight.getOriginCityName(), 510, yPos);
        text(currentFlight.getOriginAirport(), 635, yPos);
        text(currentFlight.getDestinationCityName(), 800, yPos);
        text(currentFlight.getDestinationAirport(), 940, yPos);
        
        text(currentFlight.getDepartureTime(), 1038, yPos);
        text(currentFlight.getArrivalTime(), 1108, yPos);
      }        
    }
    for (dropDownSearch s: widgetsSearch) {
      s.display();
    }
    buttonsCreated = true;
    
  }
 
}
