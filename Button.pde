//====================
//=== Button Class ===
//====================

// have size and colour ... as atributes
// communicate with main event handling when button is pressed

class Button implements Widget 
{
    int x, y, w, h;
    String label;
    color buttonColor;
    color hoverColor;
    color pressedColor;
    boolean pressed = false;
    int event;
    int flightIndex = -1;
    boolean isPressable = true;
    
    Button(int x, int y, int w, int h, String label, color buttonColor, color hoverColor, color pressedColor, int event) {
      this.x = x;
      this.y = y;
      this.w = w;
      this.h = h;
      this.label = label;
      this.buttonColor = buttonColor;
      this.hoverColor = hoverColor;
      this.pressedColor = pressedColor;
      this.event = event;
    }
    
    Button(int x, int y, int w, int h, String label, color buttonColor, color hoverColor, color pressedColor, int event, boolean isPressable) {
      this.x = x;
      this.y = y;
      this.w = w;
      this.h = h;
      this.label = label;
      this.buttonColor = buttonColor;
      this.hoverColor = hoverColor;
      this.pressedColor = pressedColor;
      this.event = event;
      this.isPressable = isPressable;
    }
    
    void display() {
      pushStyle();
      color currentColor;
      int offsetX = 0;
      int offsetY = 0;  // for indent effect
      color strokeColor;
      int strokeWeightValue;
      
      if (pressed)
      {
        currentColor = pressedColor;
        offsetX = 6;
        offsetY = 6;
        strokeWeightValue = 0;
        strokeColor = color(255, 255, 0); // Yellow stroke when pressed
      }
      else if (contains(mouseX, mouseY) && !widgetList.isExpanded() && isPressable)
      {
        currentColor = hoverColor;
        stroke(10);
        offsetX=0;
        offsetY=0;
        strokeWeightValue = 0;
        strokeColor = color(255, 255, 255); // white stroke when pressed
      }
      else
      {
        currentColor = buttonColor;
        stroke(0);
        offsetX=0;
        offsetY=0;
        strokeWeightValue = 0;
        strokeColor = color(0); 
      }
      
      stroke(strokeColor);
      strokeWeight(strokeWeightValue);
      fill(currentColor);
      rect(x+offsetX, y+offsetY, w, h);
      
        
      

      fill(0);
      textAlign(CENTER, CENTER);
      textFont(myFont);
      text(label, x + w/2 + offsetX, y + h/2 + offsetY);
      popStyle();
    }
    
    boolean contains(int mx, int my) 
    {
      return (mx >= x && mx <= x + w && my >= y && my <= y + h);
    }
    
    int getEvent() {
      return event;
    }
  }
