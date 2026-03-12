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
Search_Results result;
//Table table;

void setup() {
  size(1500, 800);
  text = loadFont("AlTarikh-24.vlw");
  myFont = createFont("Arial Bold", 20);
  textFont(myFont);
  widgetList = new WidgetList();
  widgetList.add(new Button(250, 150, 120, 45, "PRINT",   color(255, 0, 0), color(0, 150, 0), color(150, 0, 0)));
  flights = cr.readCSV("flights2k.csv");
  result = new Search_Results(flights);
}

  void draw(){
  background(0);
  fill(255);
  widgetList.display();

  
  if (showFlights) {
    textFont(text);
    textSize(10);
    textAlign(LEFT);

  result.drawDepartureFromDate(1, 1);

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
        //System.out.println(flights.get(i).getData());
      }
      printedOnce = true;
    }
  }
}
void mouseReleased() {
  widgetList.releaseAll();  // <-- THIS WAS MISSING - resets pressed state
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
    for (Button w : widgets) {
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
  for (Button w : widgets) 
    {
      w.pressed = false;
    }
  }
  
  int size() {
    return widgets.size();
  }
  
}
