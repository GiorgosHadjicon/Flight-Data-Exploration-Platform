

class WidgetList {
  ArrayList<Button> widgets;
  boolean isActive = false;


  WidgetList() {
    widgets = new ArrayList<Button>();
  }

  void add(Button w) {
    widgets.add(w);
  }
  
  void addDrop(dropDownSearch s) {
    widgetsSearch.add(s);
    
  }

  void displayWidgets() {
    isActive = true;
    for (Button w : widgets) {
      w.display();
    }
    
    for (dropDownSearch s: widgetsSearch) {
      s.display();
      
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
  
  void handleSearchEvents() {
  for (dropDownSearch s : widgetsSearch) {
    s.handleEvent();
  }
}
  
}
