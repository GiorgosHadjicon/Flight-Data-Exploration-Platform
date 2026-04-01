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
    int curved = 0;
    
    
// Constructor of button 
// Creates a rectangular button, with an integer passed as a parameter which acts as a unique identifier of its purpose

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
    
// Constructor of button 
// One extra Parameter to check if button is pressable
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
        if (event == EVENT_DISPLAY_SINGLE_FLIGHT ) {
          strokeColor = color(70, 130, 180);
          strokeWeightValue = 1;
        }
        else {
          strokeWeightValue = 0;
          strokeColor = color(255);
        }
      }
      else
      {
        currentColor = buttonColor;
        stroke(0);
        offsetX=0;
        offsetY=0;
        if (event == EVENT_DISPLAY_SINGLE_FLIGHT ) {
          strokeColor = color(230, 233, 237); 
          strokeWeightValue = 1;
        }
        else {
          strokeWeightValue = 0;
          strokeColor = color(255);
        }
      }
      
   
      
      if (!this.isPressable || this.event == EVENT_RESET_DROP_DOWN || this.event == EVENT_CHANGE_PAGE) {
        strokeColor = color(0);
        strokeWeightValue = 1;
        if ( this.event == EVENT_RESET_DROP_DOWN) {
          strokeColor = color(200, 90, 90);
          curved = 5;
        }
        if ( this.event == EVENT_CHANGE_PAGE) {
          strokeWeightValue = 1; 
          strokeColor = color(210, 215, 223);
          curved = 8;
        }
      }
      
      if (event == EVENT_CHANGE_PAGE && Integer.parseInt(label) == pageNum) {
        currentColor = color(70, 130, 180);
        strokeColor = color(70, 130, 180);
      }
      
      if (event == EVENT_NONE) {
        strokeColor = color(185, 190, 195);
      }
      
      stroke(strokeColor);
      strokeWeight(strokeWeightValue);
      fill(currentColor);
      rect(x+offsetX, y+offsetY, w, h, curved);
      
        
      if ( this.event == EVENT_RESET_DROP_DOWN) {
          fill(200, 90, 90);
      }
      else if (event == EVENT_CHANGE_PAGE && Integer.parseInt(label) == pageNum) {
        fill(255);
      }
      else {
        fill(0);
      }

      
      textSize(15);
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
