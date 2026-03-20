//======================
//==== Mouse Press =====
//======================

final int EVENT_NONE = 0;
final int EVENT_PRINT_SCREEN  = 1;
final int EVENT_DISPLAY_SINGLE_FLIGHT = 2;
final int SHOW_MAP = 3;
final int CHANGE_PAGE = 4;

void mousePressed() {
  showWelcome = false; // boolean to change welcome screen 

  widgetList.handleSearchEvents();  
  Button clicked = widgetList.getEvent(mouseX, mouseY);
  
  // If a widget was clicked, print
  if (clicked != null) {

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
      clicked.pressed = false;
      if (walkers.get(0).state == 2) {
          walkers.get(0).handleClick();

        }
      }
    }
    else if (event == EVENT_DISPLAY_SINGLE_FLIGHT) {
 
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
    else if (event == CHANGE_PAGE) {
      pageNum = Integer.parseInt(clicked.label);
      pageChange = true;
    }
  }
}
void mouseReleased() {
  widgetList.releaseAll();  
}
// mouse hover ect...
