//======================
//==== Mouse Press =====
//======================

final int EVENT_NONE = 0;
final int EVENT_PRINT_SCREEN  = 1;
final int EVENT_DISPLAY_SINGLE_FLIGHT = 2;
final int SHOW_MAP = 3;
final int EVENT_CHANGE_PAGE = 4;
final int EVENT_RESET_DROP_DOWN = 5;
final int EVENT_DEST_PIE    = 6;
final int EVENT_DEST_BUBBLE = 7;
final int EVENT_GO_HOME_SCREEN = 8;

void mousePressed() { 
  if (tutorialActive && tutorialStep == 1) {
    // If user clicks near search bar while in tutorial
    if (mouseY >= 150 && mouseY <= 230) {
        tutorialStep = 2;
        tutorialActive = false; // tutorial finished
      }
  }
  boolean dropdownUsedClick = widgetList.handleSearchEvents();
  if (dropdownUsedClick) return;
  Button clicked = widgetList.getEvent(mouseX, mouseY);
  
  // If a widget was clicked, print
  if (clicked != null && !widgetList.isExpanded()) {

    int event = clicked.getEvent();    
 
    if (event == EVENT_NONE) {
      
    }
    
    //HOMESCREEN BUTTON
    else if (event == EVENT_GO_HOME_SCREEN) { 
      widgetList.clearFlightsScreen();
      if (walkers.get(0).state == 2) {
          walkers.get(0).handleClick();
      }
      if (walkers.get(1).state == 2) {
          walkers.get(1).handleClick();
      }
      showWelcome = true; // boolean to change welcome screen
      showFlights = false; // boolean to change flight screen
      chartPage = 0;  // reset charts
      pieChart.reset();
      bubbleChart.reset();
      showMap = false; // boolean to change map screen
    }

    //FLIGHTS BUTTON
    else if (event == EVENT_PRINT_SCREEN) {
      if (tutorialActive && tutorialStep == 0) {
        tutorialStep = 1; // move to next step in tutorial
      }
      if (!showFlights) {
        if (walkers.get(0).state == 2) {
            walkers.get(0).handleClick();
        }
        if (walkers.get(1).state == 2) {
            walkers.get(1).handleClick();
        }
        
        showWelcome = false; // boolean to change welcome screen
        showFlights = true; // boolean to change flight screen
        chartPage = 0;  // reset charts
        pieChart.reset();
        bubbleChart.reset();
        showMap = false; // boolean to change map screen
        
        if (walkers.get(0).state != 3) {
          walkers.get(0).handleClick();
        }
        else if (walkers.get(1).state != 3) {
          walkers.get(1).handleClick();
        }
      }
    }
      
  
        
    //MAP BUTTON
    else if (event == EVENT_DISPLAY_SINGLE_FLIGHT) {
     if (!showMap) {
      widgetList.clearFlightsScreen();
      if (walkers.get(0).state == 2) {
            walkers.get(0).handleClick();
        }
      if (walkers.get(1).state == 2) {
          walkers.get(1).handleClick();
      }
      if (clicked.flightIndex >= 0 && clicked.flightIndex < testFlights.size()) {
    
        selectedFlight = testFlights.get(clicked.flightIndex);
    
        // SEND TO MAP
        mapScreen.setFlight(selectedFlight);
        showWelcome = false; // boolean to change welcome screen
        showFlights = false; // boolean to change flight screen
        chartPage = 0;  // reset charts
        pieChart.reset();
        bubbleChart.reset();
        showMap = true; // boolean to change map screen
          if (walkers.get(0).state != 3) {
            walkers.get(0).handleClick();
          }
          else if (walkers.get(1).state != 3) {
            walkers.get(1).handleClick();
          }
        }
     }
    }
    
    //CHANGE PAGE BUTTON
    else if (event == EVENT_CHANGE_PAGE) {
      pageNum = Integer.parseInt(clicked.label);
      pageChange = true;
    }
    
    //GRAPHS BUTTON
    else if (event == EVENT_DEST_PIE) {
      if (chartPage != 1) {
        widgetList.clearFlightsScreen();
        if (walkers.get(0).state == 2) {
            walkers.get(0).handleClick();
        }
        if (walkers.get(1).state == 2) {
            walkers.get(1).handleClick();
        }
        showWelcome = false; // boolean to change welcome screen
        showFlights = false; // boolean to change flight screen
        chartPage = 1;  // reset charts
        bubbleChart.reset();
        showMap = false; // boolean to change map screen
        pieChart.start(); // kick off sweep animation
        if (walkers.get(0).state != 3) {
          walkers.get(0).handleClick();
        }
        else if (walkers.get(1).state != 3) {
          walkers.get(1).handleClick();
        }
      } 
    }


    else if (event == EVENT_DEST_BUBBLE) {
      if (chartPage != 2) {
        widgetList.clearFlightsScreen();
        if (walkers.get(0).state == 2) {
            walkers.get(0).handleClick();
        }
        if (walkers.get(1).state == 2) {
            walkers.get(1).handleClick();
        }
        showWelcome = false; // boolean to change welcome screen
        showFlights = false; // boolean to change flight screen
        chartPage = 2;  // reset charts
        pieChart.reset();
        showMap = false; // boolean to change map screen
        bubbleChart.start(); // kick off sweep animation
        if (walkers.get(0).state != 3) {
          walkers.get(0).handleClick();
        }
        else if (walkers.get(1).state != 3) {
          walkers.get(1).handleClick();
        }
      }
    }
    
    
    //RESET SEARCH BUTTON
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
