//=====================
//==== Main Screen ====
//=====================

//(keep variable declarations in setting up)

// draw guy walking and looking at secondary screen

PFont text;
PFont myFont;
WidgetList widgetList;
boolean showFlights = false;
boolean printedOnce = false;
csvReader cr = new csvReader();
ArrayList<Flight> flights;
//Table table;

void setup() {
  size(600, 400);
  text = loadFont("AlTarikh-24.vlw");
  myFont = createFont("Arial Bold", 20);
  textFont(myFont);
  widgetList = new WidgetList();
  widgetList.add(new Button(250, 150, 120, 45, "PRINT",   color(255, 0, 0), color(0, 150, 0), color(150, 0, 0)));
  
  flights = cr.readCSV("flights2k.csv");
  
}

  void draw(){
  background(0);
  widgetList.display();
  fill(255);

  
  if (showFlights) {
    textFont(text);
    textSize(10);
    textAlign(LEFT);
  
  //For loop to print 5 sets of data using the string getData() 
  // We limit the loop to 5 items
  for (int i = 0; i < 5 && i < flights.size(); i++) {
    Flight currentFlight = flights.get(i);
    String displayString = currentFlight.getData(); // Uses data from string
    
    float yPos = 40 + (i * 30); // Spacing each line 30 pixels apart
    text(displayString, 60, yPos);
    
  }
 }
}

void mousePressed() {
  Button clicked = widgetList.getEvent(mouseX, mouseY);

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
  widgetList.releaseAll();  
}

class WidgetList {
  ArrayList<Button> widgets;

  WidgetList() {
    widgets = new ArrayList<Button>();
  }

  void add(Button w) {
    widgets.add(w);
  }

  void display() {
    for (Widget w : widgets) {
      w.display();
    }
  }

  Button getEvent(int mx, int my) {
    for (Button w : widgets) {
      if (w.contains(mx, my)) {
        return w;
      }
    }
    return null;
  }
  
  void releaseAll() {
  for (Button b : widgets) 
    {
      b.pressed = false;
    }
  }
}
