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
  
}
