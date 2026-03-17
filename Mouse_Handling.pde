//======================
//==== Mouse Press =====
//======================

final int EVENT_NONE = 0;
final int EVENT_PRINT_SCREEN  = 1;
final int EVENT_DISPLAY_SINGLE_FLIGHT = 2;
final int EVENT_BTN1 = 3;
final int EVENT_BTN2 = 4;

void mousePressed() {
  Button clicked = widgetList.getEvent(mouseX, mouseY);


  // If a widget was clicked, print
  if (clicked != null) {

    int event = clicked.getEvent();
  
    if (event == 0) {
      
    }
    else if (event == 1) {
      showFlights = true;
      clicked.pressed = true;
    }
    else if (event == 2) {
      
    }
    else if (event == 3) {
      
    }
  }
}
void mouseReleased() {
  widgetList.releaseAll();  // <-- THIS WAS MISSING - resets pressed state
}
// mouse hover ect...
