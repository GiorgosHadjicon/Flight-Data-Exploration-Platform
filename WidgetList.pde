

class WidgetList {
  ArrayList<Button> widgets;
  boolean isActive = false;
  int stateMachine = 0;


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
  
  void clearFlights() {
  for (int i = widgets.size() - 1; i >= 0; i--) {
    if (widgets.get(i).getEvent() == EVENT_DISPLAY_SINGLE_FLIGHT) {
      widgets.remove(i);
    }
  }
}
  
  void handleSearchEvents() {
    for (dropDownSearch s : widgetsSearch) {
      String selectedValue = s.handleEvent();
  
      if (selectedValue != null && selectedValue != "") {
        // Update the appropriate data block based on dropdown type
        if (s.getItemName().equals("date")) {
          stateMachine = 1;
        }
        else if (s.getItemName().equals("origins")) {
          stateMachine = 2;
        }
        else if (s.getItemName().equals("originsCityName")) {
          stateMachine = 3;
  
        }
        else if (s.getItemName().equals("destinations")) {
          stateMachine = 4;
        }
        else if (s.getItemName().equals("destinationsCityName")) {
          stateMachine = 5;
  
        }
        switch(stateMachine)
        {
          case 1:
            dateDataBlock = selectedValue; 
            println("Date selected: " + dateDataBlock);
            break;
          case 2:
            originDataBlock = selectedValue;
            println("Origin selected: " + originDataBlock);
            break;
          case 3:
            originCityName = selectedValue;
            println("Origin city selected: " + originCityName);
            break;
          case 4:
            destination = selectedValue;
            println("Destination selected: " + destination);
            break;
          case 5:
            destinationCityName = selectedValue;
            println("Destination city selected: " + destinationCityName);
            break;
          default:
            break; 
        }
      }
  
      testFlights = search.Search(dateDataBlock, "", -1, originDataBlock, originCityName, "", -1, "LAX", "", "", -1, -1, -1, -1, -1, false, false, -1);
      result = new Search_Results(testFlights);
    }
  }
  
}
