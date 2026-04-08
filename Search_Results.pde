//===========================
//== Search Results Screen ==
//===========================
// AUTHORSHIP: Giorgos Hadjiconstantis

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
    
    // Create the white screen at the back
    stroke(0);
    strokeWeight(0);
    fill(255);
    rect(332, 145, 834, 463);
    
    textAlign(CENTER, CENTER);
    
    
    // Display all the current widgets of the screen
    widgetList.displayWidgets();
    int yIncrement = 0;
    
    // Creates buttons for choosing date, origin, destination and clear
    if (!searchButtonsCreated) {
      textSize(15);

      widgetList.add( new Button(351, 224, 796, 323, "", color(255), color(120), color(0, 255, 0), EVENT_NONE, false) );
      widgetList.add( new Button(351, 224, 796, 36, "Date                   Origin City                     Airport                         Destination City                    Airport                 Dep.            Arr.", 
      color(210), color(120), color(0, 255, 0), EVENT_NONE, false) );
            
      widgetList.addDrop(new dropDownSearch(352, 170, 70, 40, "DATE", color(250), color(200), date, "date")); 
      widgetList.addDrop(new dropDownSearch(447, 170, 120, 40, "ORIGIN CITY", color(250), color(200), originsCityName, "originsCityName")); 
      widgetList.addDrop(new dropDownSearch(592, 170, 90, 40, "AIRPORT", color(250), color(200), origins, "origins")); 
      widgetList.addDrop(new dropDownSearch(707, 170, 165, 40, "DESTINATION CITY", color(250), color(200), destinationsCityName, "destinationsCityName")); 
      widgetList.addDrop(new dropDownSearch(897, 170, 90, 40, "AIRPORT", color(250), color(200), destinations, "destinations")); 
      
      widgetList.add(new Button(1035, 170, 110, 40, "CLEAR",   color(255), color(255, 235, 235), color(255, 235, 235), EVENT_RESET_DROP_DOWN));

      searchButtonsCreated = true;
    }
     
    // Check if the buttons for the individual flights have been created 
    if (!buttonsCreated) {

     // Limits the number of flights shown in the screen to 11 and counts the number of pages it has
      if (flightsFiltered.size() < 11) {
        iSet = 0;
      }
      else {
        iSet = (pageNum - 1) * 11;
        
        if (flightsFiltered.size()  % 11 == 0) {
          totalCountPages = flightsFiltered.size() / 11;
        }
        else {
          totalCountPages = (int)(flightsFiltered.size() / 11) + 1;
        }
      }
    }
        
    // Check for page change in order to clear the screen and go to the other page
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
    
    // Creates the buttons for the individual flights
    for (int i = iSet; i < flightsFiltered.size(); i++) {
      Flight currentFlight = flightsFiltered.get(i);
      if (yIncrement <= 10) {
        yIncrement++;
        int yPos = 245 + (yIncrement * 26); // Spacing each line 40 pixels apart
        fill(0);
        
        textSize(13);
        if (!buttonsCreated) {
          if (yIncrement % 2 != 0) {
            Button b = new Button(352, yPos - 10, 794, 25, "", color(248, 249, 251), color(235, 242, 250), color(0, 255, 0), EVENT_DISPLAY_SINGLE_FLIGHT);
            b.flightIndex = i;   
            widgetList.add(b);
          }
          else {
            Button b = new Button(352, yPos - 10, 794, 25, "", color(255), color(235, 242, 250), color(0, 255, 0), EVENT_DISPLAY_SINGLE_FLIGHT);
            b.flightIndex = i;   
            widgetList.add(b);
          }
          
          // Create the buttons for the pages
          for (int j = 1; j <= totalCountPages; j++) {
            if (totalCountPages >= 9) {
              if (j <= 8) {
                widgetList.add( new Button(610 + (j * 30), 560, 25, 25, String.valueOf(j), color(245, 247, 250), color(235, 242, 250), color(0, 255, 0) , EVENT_CHANGE_PAGE) );
              }
            }
            else {
              widgetList.add( new Button(610 + (j * 30), 560, 25, 25, String.valueOf(j), color(245, 247, 250), color(235, 242, 250), color(0, 255, 0) , EVENT_CHANGE_PAGE) );
            }
          }    

        }
        
        // Displays the data of the flights
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
