////=====================
////==== Main Screen ====
////=====================

////(keep variable declarations in setting up)

//// draw guy walking and looking at secondary screen


////Table table;

//void setup() {
//  size(1500, 800);
//  text = loadFont("AlTarikh-24.vlw");
//  myFont = createFont("Arial Bold", 20);
//  textFont(myFont);
//  widgetList = new WidgetList();
//  widgetList.add(new Button(250, 150, 120, 45, "PRINT",   color(255, 0, 0), color(0, 150, 0), color(150, 0, 0)), new dropDownSearch(100, 50, 60, 30, "SEARCH", color(255, 0, 0), color(0, 150, 0), temp)); 
//  flights = cr.readCSV("flights2k.csv");
//  for (int i = 0; i < flights.size(); i++)
//  {
//    Flight currentFlight = flights.get(i);
//    String displayString = currentFlight.getData(); // Uses data from string
//    temp.add(displayString);
//  }
//}

//  void draw(){
//  background(0);
//  widgetList.display();
//  fill(255);

  
//  if (showFlights) {
//    textFont(text);
//    textSize(10);
//    textAlign(LEFT);
  
//  //For loop to print 5 sets of data using the string getData() 
//  // We limit the loop to 5 items
//  for (int i = 0; i < 5 && i < flights.size(); i++) {
//    Flight currentFlight = flights.get(i);
    
//    float yPos = 40 + (i * 30); // Spacing each line 30 pixels apart
//    text(displayString, 60, yPos);
    
//  }
// }
//}

//void mousePressed() {
//  widgetList.handleSearchEvents();  // ADD THIS LINE
  
//  Button clicked = widgetList.getEvent(mouseX, mouseY);
//  if (clicked != null) {
//    showFlights = true;
//    clicked.pressed = true;
//    if (!printedOnce) {
//      for (int i = 0; i < 5 && i < flights.size(); i++) {
//        System.out.println(flights.get(i).getData());
//      }
//      printedOnce = true;
//    }
//  }
//}

//void keyPressed() {
//  for (dropDownSearch s : widgetsSearch) {
//    s.keyPressed(key, keyCode);
//  }
//}
//void mouseReleased() {
//  widgetList.releaseAll();  
//}
