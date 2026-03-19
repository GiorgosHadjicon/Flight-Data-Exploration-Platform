//======================
//==== Mouse Press =====
//======================

final int EVENT_NONE = 0;
final int EVENT_PRINT_SCREEN  = 1;
final int EVENT_DISPLAY_SINGLE_FLIGHT = 2;
final int SHOW_MAP = 3;
final int EVENT_BTN2 = 4;

void mousePressed() {
  showWelcome = false; // boolean to change welcome screen 

  widgetList.handleSearchEvents();  
  Button clicked = widgetList.getEvent(mouseX, mouseY);
  
  // If a widget was clicked, print
  if (clicked != null && widgetList.isActive && !isDropDownSearchExpanded) {

    int event = clicked.getEvent();
  
    if (event == 0) {
      
    }
    else if (event == 1) {
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
    else if (event == 2) {
      
    }
    else if (event == 3) {
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
  }
}
void mouseReleased() {
  widgetList.releaseAll();  
}
// mouse hover ect...
