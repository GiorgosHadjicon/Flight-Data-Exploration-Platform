//======================
//==== Mouse Press =====
//======================

final int EVENT_NONE = 0;
final int EVENT_PRINT_SCREEN  = 1;
final int EVENT_DISPLAY_SINGLE_FLIGHT = 2;
final int SHOW_MAP = 3;
final int EVENT_CHANGE_PAGE = 4;
final int EVENT_FREQUENCY_GRAPH = 5;
final int EVENT_RESET_DROP_DOWN = 6;

void mousePressed() {
  showWelcome = false; // boolean to change welcome screen 
  boolean dropdownUsedClick = widgetList.handleSearchEvents();
  if (dropdownUsedClick) return;
  Button clicked = widgetList.getEvent(mouseX, mouseY);
  
  // If a widget was clicked, print
  if (clicked != null && !widgetList.isExpanded()) {

    int event = clicked.getEvent();    
 
    if (event == EVENT_NONE) {
      
    }
    else if (event == EVENT_PRINT_SCREEN) {
      if (!showFlights) {
        showFlights = true;
        clicked.pressed = true;
        if (walkers.get(0).state != 3) {
          walkers.get(0).handleClick();

        }
      }
      else {
      showFlights = false;
      widgetList.clearFlightsScreen();
      clicked.pressed = false;
      if (walkers.get(0).state == 2) {
          walkers.get(0).handleClick();

        }
      }
    }
    else if (event == EVENT_DISPLAY_SINGLE_FLIGHT) {

    if (clicked.flightIndex >= 0 && clicked.flightIndex < testFlights.size()) {
  
      selectedFlight = testFlights.get(clicked.flightIndex);
  
      // SEND TO MAP
      mapScreen.setFlight(selectedFlight);
      showMap = true;
    }
  }
    else if (event == SHOW_MAP) {
      if (!showMap) {
        showMap = true;
        if (walkers.get(1).state != 3) {

          walkers.get(1).handleClick();
        }
      }
      else {
        showMap = false;
        if (walkers.get(1).state == 2) {
          walkers.get(1).handleClick();

        }
      }
    }
    else if (event == EVENT_CHANGE_PAGE) {
      pageNum = Integer.parseInt(clicked.label);
      pageChange = true;
    }
    
    else if (event == EVENT_FREQUENCY_GRAPH) {
      if (!showFrequencyGraph) {
        showFrequencyGraph = true;
        if (walkers.get(1).state != 3) {

          walkers.get(1).handleClick();
        }
      }
      else {
        showFrequencyGraph = false;
        if (walkers.get(1).state == 2) {
          walkers.get(1).handleClick();

        }
      }
    }
    else if (event == EVENT_RESET_DROP_DOWN)
    {
      // Reset all dropdowns visually
      for (dropDownSearch s: widgetsSearch) 
      {
        s.reset();
      }
      
      // Also reset the data blocks driving the search
      dateDataBlock = "1/1/2022";   // or "" if you want truly no filter
      originDataBlock = "";
      originCityName = "";
      destination = "";
      destinationCityName = "";
      
      // Re-run the search with cleared values so results update immediately
      testFlights = search.Search(dateDataBlock, "", -1, originDataBlock, originCityName, "", -1, destination, destinationCityName, "", -1, -1, -1, -1, -1, false, false, -1);
      result = new Search_Results(testFlights);
    }
  }
}
void mouseReleased() {
  widgetList.releaseAll();  
}
// mouse hover ect...
