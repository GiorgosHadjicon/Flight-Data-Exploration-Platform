//=====================
//==== Main Screen ====
//=====================

//(keep variable declarations in setting up)

// draw guy walking and looking at secondary screen
import gifAnimation.*;

PFont text;
PFont myFont;
WidgetList widgetList;
boolean showFlights = false;
boolean printedOnce = false;
csvReader cr = new csvReader();
ArrayList<Flight> flights;
ArrayList<Walking> walkers = new ArrayList<Walking>();
//Table table;

void setup() {
  size(600, 400);
  text = loadFont("AlTarikh-24.vlw");
  myFont = createFont("Arial Bold", 20);
  textFont(myFont);
  widgetList = new WidgetList();
  widgetList.add(new Widget(250, 150, 120, 45, "PRINT",   color(255, 0, 0), color(0, 150, 0), color(150, 0, 0)));
  
  flights = cr.readCSV("flights2k.csv");
  
Walking w1 = new Walking(this, height - 225, "BlueShirtwalk.gif", "guyLook.gif");
  w1.resize(300, 300);
  walkers.add(w1);
  
  Walking w2 = new Walking(this, height - 220, "guyRun.gif", "guyTurn.gif");
  w2.resize(300, 300);
  walkers.add(w2);
  
  Walking w3 = new Walking(this, height - 150, "girlWalk.gif", "girlTurn.gif");
  w3.resize(200, 200);
  walkers.add(w3);
  
  Walking w4 = new Walking(this, height - 220, "ggWalk.gif", "ggTurn.gif");
  w4.resize(300, 300);
  walkers.add(w4);
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
 drawButtons();

for (Walking w : walkers) {
  w.update();
  w.display();
 }
}

void drawButtons() {

  for(int i = 0; i < walkers.size(); i++) {
    // Check if mouse is over button (Updated size & spacing from test sketch)
    if (mouseX > 50 && mouseX < 80 && mouseY > 40 + (i * 45) && mouseY < 70 + (i * 45)) {
      fill(250, 120, 126); // hover color pink
    } 
    else {
      fill(200); // normal color (grey)
    }
    // Draw buttons
    rect(50, 40 + (i * 45), 30, 30);
  }
}

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
 if (mouseX > 50 && mouseX < 80) {
    for (int i = 0; i < walkers.size(); i++) {
      if (mouseY > 40 + (i * 45) && mouseY < 70 + (i * 45)) {
        // Changed from .toggle() to .handleClick() to match your new class
        walkers.get(i).handleClick(); 
      }

    }
  }
}
void mouseReleased() {
  widgetList.releaseAll();  // <-- THIS WAS MISSING - resets pressed state
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
  
  void releaseAll() {
  for (Widget w : widgets) 
    {
      w.pressed = false;
    }
  }
}

class Widget {
    int x, y, w, h;
    String label;
    color buttonColor;
    color hoverColor;
    color pressedColor;
    boolean pressed = false;
    Widget(int x, int y, int w, int h, String label, color buttonColor, color hoverColor, color pressedColor) {
      this.x = x;
      this.y = y;
      this.w = w;
      this.h = h;
      this.label = label;
      this.buttonColor = buttonColor;
      this.hoverColor = hoverColor;
      this.pressedColor = pressedColor;
    }
    
    void display() {
      color currentColor;
      int offsetX = 0;
      int offsetY = 0;  // for indent effect
      color strokeColor;
      int strokeWeightValue;
      
      if (pressed)
      {
        currentColor = pressedColor;
        offsetX = 2;
        offsetY = 2;
        strokeWeightValue = 3;
        strokeColor = color(255, 255, 0); // Yellow stroke when pressed
      }
      else if (contains(mouseX, mouseY))
      {
        currentColor = hoverColor;
        stroke(10);
        offsetX=0;
        offsetY=0;
        strokeWeightValue = 3;
        strokeColor = color(255, 255, 255); // Yellow stroke when pressed
      }
      else
      {
        currentColor = buttonColor;
        stroke(0);
        offsetX=0;
        offsetY=0;
        strokeWeightValue = 1;
        strokeColor = color(0); // Yellow stroke when pressed
      }
      
      stroke(strokeColor);
      strokeWeight(strokeWeightValue);
      fill(currentColor);
      rect(x+offsetX, y+offsetY, w, h, 8);
      
        
      

      fill(0);
      textAlign(CENTER, CENTER);
      textFont(myFont);
      text(label, x + w/2 + offsetX, y + h/2 + offsetY);
    }
    
    boolean contains(int mx, int my) {
      return (mx >= x && mx <= x + w && my >= y && my <= y + h);
    }
  }
