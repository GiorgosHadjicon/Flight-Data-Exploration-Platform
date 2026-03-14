////=====================
////==== Main Screen ====
////=====================

// TODO here: draw guy walking and looking at secondary screen

// Declarations:
import java.util.Set;
import java.util.HashSet;

// For Sreach
Boolean typing = false;
String currentSearchString = "";
Searcher search;
ArrayList<Flight> testFlights;

//PFont text;
//PFont myFont;
//WidgetList widgetList;
//boolean showFlights = false;
//boolean printedOnce = false;
//csvReader cr = new csvReader();
//ArrayList<Flight> flights;
////Table table;

void setup() {
  size(1500, 850);
  text = loadFont("AlTarikh-24.vlw");
  myFont = createFont("Arial Bold", 20);
  textFont(myFont);
  widgetList = new WidgetList();
  widgetList.add(new Widget(250, 150, 120, 45, "PRINT",   color(255, 0, 0), color(0, 150, 0), color(150, 0, 0)));
  
//  flights = cr.readCSV("flights2k.csv");
  
  // Search Test
  search = new Searcher(flights); //<>//
  testFlights = search.Search("1/1/2022", "", -1, "JFK", "New York, NY", "", -1, "LAX", "", "", -1, -1, -1, -1, -1, false, false, -1); //<>//
  for (Flight i : testFlights) {
    System.out.print(i.flightDateString + " ");
    System.out.print(i.origin + " ");
    System.out.print(i.originCityName + " ");
    System.out.print(i.arrivalTime + " ");
    System.out.println(i.destination);
  } 
  // Search test end
}

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
//    String displayString = currentFlight.getData(); // Uses data from string
    
//    float yPos = 40 + (i * 30); // Spacing each line 30 pixels apart
//    text(displayString, 60, yPos);
    
//  }
// }
//}

//void mousePressed() {
//  Widget clicked = widgetList.getEvent(mouseX, mouseY);

//  // If a widget was clicked, print
//  if (clicked != null) {
//    showFlights = true;
//    clicked.pressed = true;
    
//    // This sends the text to the Terminal
//    if (!printedOnce) {
//      for (int i = 0; i < 5 && i < flights.size(); i++) {
//        System.out.println(flights.get(i).getData());
//      }
//      printedOnce = true;
//    }
//  }
//}
//void mouseReleased() {
//  widgetList.releaseAll();  // <-- THIS WAS MISSING - resets pressed state
//}

//class WidgetList {
//  ArrayList<Widget> widgets;

//  WidgetList() {
//    widgets = new ArrayList<Widget>();
//  }

//  void add(Widget w) {
//    widgets.add(w);
//  }

//  void display() {
//    for (Widget w : widgets) {
//      w.display();
//    }
//  }

//  Widget getEvent(int mx, int my) {
//    for (Widget w : widgets) {
//      if (w.contains(mx, my)) {
//        return w;
//      }
//    }
//    return null;
//  }
  
//  void releaseAll() {
//  for (Widget w : widgets) 
//    {
//      w.pressed = false;
//    }
//  }
//}

//class Widget {
//    int x, y, w, h;
//    String label;
//    color buttonColor;
//    color hoverColor;
//    color pressedColor;
//    boolean pressed = false;
//    Widget(int x, int y, int w, int h, String label, color buttonColor, color hoverColor, color pressedColor) {
//      this.x = x;
//      this.y = y;
//      this.w = w;
//      this.h = h;
//      this.label = label;
//      this.buttonColor = buttonColor;
//      this.hoverColor = hoverColor;
//      this.pressedColor = pressedColor;
//    }
    
//    void display() {
//      color currentColor;
//      int offsetX = 0;
//      int offsetY = 0;  // for indent effect
//      color strokeColor;
//      int strokeWeightValue;
      
//      if (pressed)
//      {
//        currentColor = pressedColor;
//        offsetX = 2;
//        offsetY = 2;
//        strokeWeightValue = 3;
//        strokeColor = color(255, 255, 0); // Yellow stroke when pressed
//      }
//      else if (contains(mouseX, mouseY))
//      {
//        currentColor = hoverColor;
//        stroke(10);
//        offsetX=0;
//        offsetY=0;
//        strokeWeightValue = 3;
//        strokeColor = color(255, 255, 255); // Yellow stroke when pressed
//      }
//      else
//      {
//        currentColor = buttonColor;
//        stroke(0);
//        offsetX=0;
//        offsetY=0;
//        strokeWeightValue = 1;
//        strokeColor = color(0); // Yellow stroke when pressed
//      }
      
//      stroke(strokeColor);
//      strokeWeight(strokeWeightValue);
//      fill(currentColor);
//      rect(x+offsetX, y+offsetY, w, h, 8);
      
        
      

//      fill(0);
//      textAlign(CENTER, CENTER);
//      textFont(myFont);
//      text(label, x + w/2 + offsetX, y + h/2 + offsetY);
//    }
    
//    boolean contains(int mx, int my) {
//      return (mx >= x && mx <= x + w && my >= y && my <= y + h);
//    }
//  }
