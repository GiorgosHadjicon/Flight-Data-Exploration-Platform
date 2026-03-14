//======================
//==== Mouse Press =====
//======================

void mousePressed() {
  Widget clicked = widgetList.getEvent(mouseX, mouseY);

  // If a widget was clicked, print
  if (clicked != null) {
    showFlights = true;
    clicked.pressed = true;
    
    // This sends the text to the Terminal
    if (!printedOnce) {
      for (int i = 0; i < 5 && i < flights.size(); i++) {
        System.out.println(flights.get(i).getData());
      }
      printedOnce = true;
    }
  }
}
void mouseReleased() {
  widgetList.releaseAll();  // <-- THIS WAS MISSING - resets pressed state
}
// mouse hover ect...
