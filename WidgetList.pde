class WidgetList {
  ArrayList<Button> widgets;
  boolean isActive = false;    //boolean to recognise whether a widget is on display or not 
  int stateMachine = 0;        //state machine to toggle states for search function 


  WidgetList() {                                  //Array list of buttons
    widgets = new ArrayList<Button>();
  }

  void add(Button w) {                            //for every button, add it to ArrayList
    widgets.add(w);
  }
    
  void addDrop(dropDownSearch s) {                //for every dropDownButton (unique button) add to ArrayList of Search buttons
    pushStyle();
    widgetsSearch.add(s);
    popStyle();
  }

  void displayWidgets() {                        //display the widgets that should be displayed
    isActive = true;
    for (Button w : widgets) {
      w.display();
    }
    
  }

  Button getEvent(int mx, int my) {               //if mouse is over widget and dropDownSearch is not expanded and button is Prresseble -> return button
    for (Button w : widgets) {
      if (w.contains(mx, my) && !widgetList.isExpanded() && w.isPressable) {
        return w;
      }
    }
    return null;                                  //else return null
  }
  
  void releaseAll() {
  for (Button w : widgets)                        //for every button (once released) pressed = false
    {
      w.pressed = false;
    }
  }
  
  void clearFlights() {
  for (int i = widgets.size() - 1; i >= 0; i--) {
    if (widgets.get(i).getEvent() == EVENT_DISPLAY_SINGLE_FLIGHT || widgets.get(i).getEvent() == EVENT_CHANGE_PAGE) {  //for every flight displayed, clear every flight
      widgets.remove(i);
    }
  }
}
  void clearFlightsScreen() {
    for (int i = widgets.size() - 1; i >= 0; i--) {
      if (widgets.get(i).getEvent() == EVENT_DISPLAY_SINGLE_FLIGHT || widgets.get(i).getEvent() == EVENT_NONE || widgets.get(i).getEvent() == EVENT_CHANGE_PAGE || widgets.get(i).getEvent() == EVENT_RESET_DROP_DOWN) {
        widgets.remove(i);                                                          //clear the whole screen
      }
    }
    for (int i = widgetsSearch.size() - 1; i >= 0; i--) {
      widgetsSearch.remove(i);                                                    //also clear the drop down buttons
    }
  }
  
  boolean handleSearchEvents() {
    
    boolean clickUsed = false; //click used is dix overlap click bag             //what follows is a state machine to allow individual selection of a search component
                                                                                 //e.g select date -> filters all flights with selected date while keeping rest of search 
    if (isExpanded()) {                                                          //components the same i.e origins, originCityName etc...
      isDropDownSearchExpanded = true;
    }
    else {
      isDropDownSearchExpanded = false;
    }
    for (dropDownSearch s : widgetsSearch) {
     
      if (s.contains(mouseX, mouseY)) {
        clickUsed = true;
      }
      String selectedValue = s.handleEvent();
      
      if (selectedValue != null && selectedValue != "") {

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
            dateDataBlock = selectedValue;       //each selected value is assigned to its respective data block in main which in turns feeds into the search function                    
            break;                               //which takes in seperate strings for each search components(date, origin etc...)
          case 2:
            originDataBlock = selectedValue;
            break;
          case 3:
            originCityName = selectedValue;
            break;
          case 4:
            destination = selectedValue;
            break;
          case 5:
            destinationCityName = selectedValue;
            break;
          default:
            break; 
        }
      }
  
      testFlights = search.Search(dateDataBlock, "", -1, originDataBlock, originCityName, "", -1, destination, destinationCityName, "", -1, -1, -1, -1, -1, false, false, -1);  //this is fed the datablocks
      result = new Search_Results(testFlights);         //searches in backend for given dataBlocks
    }
    return clickUsed;
  }
    
  boolean isExpanded() {                              //checks if dropDownSearch buttons are expanded with panel showing
    for (dropDownSearch s : widgetsSearch) {
      if (s.expanded) {                            
        return true;
      }
    }
    return false;
  }
  
}
