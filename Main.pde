//=====================
//==== Main Screen ====
//=====================

//(keep variable declarations in setting up)

// draw guy walking and looking at secondary screen

PFont text;
PFont myFont;
WidgetList widgetList;
boolean showFlights = false;
csvReader cr = new csvReader();
ArrayList<Flight> flights;
//Table table;

void setup() {
  size(600, 400);
  text = loadFont("AlTarikh-24.vlw");
  myFont = createFont("Arial Bold", 20);
  textFont(myFont);
  widgetList = new WidgetList();
  widgetList.add(new Widget(250, 150, 120, 45, "PRINT",   color(255, 0, 0)));
  
 // 1. Load the excel/csv file (ensure "flights.csv" is in your data folder)
//Table table = loadTable(filename, "header");


}

  void draw(){
  background(0);
  widgetList.display();
  textFont(text);
  textSize(10);
  fill(255);
  line(50, 0, 50, height);
  textAlign(LEFT);
  
  if (showFlights) {
    
  flights = cr.readCSV("flights2k.csv");
  
  //For loop to print 5 sets of data using the string getData() 
  // We limit the loop to 5 items
  for (int i = 0; i < 5 && i < flights.size(); i++) {
    Flight currentFlight = flights.get(i);
    String displayString = currentFlight.getData(); // Uses data from string
    
    float yPos = 40 + (i * 30); // Spacing each line 30 pixels apart
    text(displayString, 60, yPos);
    
    // This sends the text to the Terminal
    System.out.println(displayString);
  }
 }
}

void mousePressed() {
  Widget clicked = widgetList.getEvent(mouseX, mouseY);

  // If a widget was clicked, print
  if (clicked != null) {
    showFlights = true;
  }
}

class WidgetList {
  ArrayList<Widget> widgets;

  WidgetList() {
    widgets = new ArrayList<Widget>();
  }

  void add(Widget w) {
    widgets.add(w);
  }

  void display() {
    for (Widget w : widgets) {
      w.display();
    }
  }

  Widget getEvent(int mx, int my) {
    for (Widget w : widgets) {
      if (w.contains(mx, my)) {
        return w;
      }
    }
    return null;
  }
}

class Widget {
    int x, y, w, h;
    String label;
    color buttonColor;
    
    Widget(int x, int y, int w, int h, String label, color buttonColor) {
      this.x = x;
      this.y = y;
      this.w = w;
      this.h = h;
      this.label = label;
      this.buttonColor = buttonColor;
    }
    
    void display() {
      stroke(0);
      fill(buttonColor);
      rect(x, y, w, h, 8);
      
      fill(0);
      textAlign(CENTER, CENTER);
      textFont(myFont);
      text(label, x + w/2, y + h/2);
    }
    
    boolean contains(int mx, int my) {
      return (mx >= x && mx <= x + w && my >= y && my <= y + h);
    }
  }
