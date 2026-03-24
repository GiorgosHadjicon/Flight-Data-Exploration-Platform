//==========================
// Drop Down Search Subclass
//==========================
class dropDownSearch implements Widget 
{
  int x, y, w, h;
  String label;
  color buttonColor;
  color hoverColor;
  boolean expanded = false;
  String searchText = "";
  ArrayList<String> items;         // Full master list from main
  ArrayList<String> filteredItems; // Items matching current search
  int selectedIndex = -1;          // Which item is selected (-1 = none)
  String itemName;
  
  final int ITEM_HEIGHT = 24;
  final int MAX_VISIBLE = 6;
  
  dropDownSearch(int x, int y, int w, int h, String label, color buttonColor, color hoverColor, ArrayList<String> items, String itemName) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    this.buttonColor = buttonColor;
    this.hoverColor = hoverColor;
    this.items = items;
    this.filteredItems = new ArrayList<String>(items);  //just make a copy of master list for now 
    this.itemName = itemName;
  }

  String getItemName()
  {
    return itemName;
  }
  
  void reset() {
    searchText = "";
    selectedIndex = -1;
    expanded = false;
    isDropDownSearchExpanded = false;
    filteredItems = new ArrayList<String>(items);
  }
  
  // Rebuilds filteredItems to only show items containing the search text
  void updateFilter() {
    filteredItems.clear();
    String query = searchText.toLowerCase().trim();
    for (String item : items) {
      if (query.length() == 0 || item.toLowerCase().contains(query)) {
        filteredItems.add(item);
      }
    }
  }
  
  void display() {
    // --- Draw button ---
    pushStyle();
    
    if (contains(mouseX, mouseY) && !expanded) fill(hoverColor);
    else fill(expanded ? color(220, 220, 255) : buttonColor);
    stroke(50);
    strokeWeight(1.5);
    rect(x, y, w, h, 6);
    
    // --- Draw button text ---
    fill(0);
    textAlign(LEFT, CENTER);
    textFont(myFont);
    textSize(10);
    
    
    if (expanded) {
      // Show typed search text with blinking cursor
      String cursor = (frameCount % 40 < 20) ? "|" : "";
      text(searchText + cursor, x + 5, y + h/2);
    } else if (selectedIndex >= 0 && selectedIndex < filteredItems.size()) {
      // A item has been chosen from the dropdown —
      // retrieve it from filteredItems using selectedIndex and display it on the button.
      // truncate() shortens it if the text is too wide to fit inside the button width.
      text(truncate(filteredItems.get(selectedIndex)), x + 5, y + h/2);
    } else {
      text(label, x + 5 , y + h/2);
    }
    
    // --- Draw dropdown arrow ---
    fill(0);
    noStroke();
    int ax = x + w - 14, ay = y + h/2;
    if (expanded) triangle(ax, ay+4, ax+8, ay+4, ax+4, ay-3); // up
    else          triangle(ax, ay-3, ax+8, ay-3, ax+4, ay+4); // down
    
    // --- Draw dropdown panel ---
    if (expanded) {
      int dropY = y + h + 2;                                     //different y for panel compared to the button 
      int visibleCount = min(MAX_VISIBLE, filteredItems.size()); //How many rows are visible, max 6
      int panelH = max(ITEM_HEIGHT, visibleCount * ITEM_HEIGHT); // at least 1 row tall
      
      fill(245); stroke(150); strokeWeight(1);
      rect(x, dropY, w, panelH, 0, 0, 4, 4);            //bottom corners rounded only
      
      if (filteredItems.size() == 0) {
        fill(160); textAlign(CENTER, CENTER); textSize(12); //no match case
        text("No results", x + w/2, dropY + ITEM_HEIGHT/2);
      } else {   
        //display the text for each tiem 
        textAlign(LEFT, CENTER); textSize(12);
        for (int i = 0; i < visibleCount; i++) {              //cycle through index of each item 
          int itemY = dropY + i * ITEM_HEIGHT;                //y position of each item 
          boolean isHovered = (mouseX >= x && mouseX <= x+w && mouseY >= itemY && mouseY <= itemY+ITEM_HEIGHT);
          boolean isSelected = (i == selectedIndex);
          
          if (isSelected)     fill(100, 180, 255);           //states items can be in 
          else if (isHovered) fill(200, 220, 255);
          else                fill(245);
          noStroke();
          rect(x+1, itemY, w-2, ITEM_HEIGHT);                //how to draw them
          
          fill(isSelected ? 255 : 0);                        //text color 
          text(truncate(filteredItems.get(i)), x + 8, itemY + ITEM_HEIGHT/2);  //text to display, getting text from arrayList of filtered items
        }
      }
    }
    popStyle();
  }
  
  // Shortens text so it doesn't overflow the button/row width
  String truncate(String s) {
    if (itemName.equals("originsCityName") || itemName.equals("destinationsCityName"))
    {
      textSize(10);
      while (s.length() > 5) {
        s = s.substring(s.length()-2, s.length());
      }
      return s;
    }
    else if (itemName.equals("date") )
    { 
      textSize(8);
      return s;
    }
    return s;

  }
  
  boolean contains(int mx, int my) {
     // Check if the mouse is inside the main button area
    if (mx >= x && mx <= x+w && my >= y && my <= y+h) return true;
    if (expanded) {
      // If the dropdown panel is open, also check if the mouse is inside that
      int panelH = max(ITEM_HEIGHT, min(MAX_VISIBLE, filteredItems.size()) * ITEM_HEIGHT);
      // Calculate the panel height — at least one row tall, at most MAX_VISIBLE rows tall
      if (mx >= x && mx <= x+w && my >= y+h && my <= y+h+panelH+2) return true;
    }
    return false;
  }
  
  String handleEvent() {
    // If the click was outside the button AND the dropdown panel, close everything and stop.
    if (!contains(mouseX, mouseY)) { expanded = false; return ""; }
    
    // If the click was on the main button (between top and bottom edge of button):
    // toggle the dropdown — if it was open, close it; if closed, open it.
    if (mouseY >= y && mouseY <= y+h) {
      expanded = !expanded;
      // If we just opened it, clear any previous search and reset the list to show everything
      if (expanded) { searchText = ""; updateFilter(); }
        return ""; // stop here, don't fall through to the row-click code below
    }
    // If we get here, the click was inside the dropdown panel (not the button).
    // Work out which row was clicked by taking the mouse Y position,
    // subtracting where the panel starts (y+h+2), then dividing by row height.
    // e.g. if panel starts at y=100 and ITEM_HEIGHT=24:
    //   clicking at y=112 gives (112-100)/24 = 0 → first row
    //   clicking at y=136 gives (136-100)/24 = 1 → second row
    
    // Click on a row = select it and close
    if (expanded && filteredItems.size() > 0) {
      int clickedRow = (mouseY - (y+h+2)) / ITEM_HEIGHT;
      if (clickedRow >= 0 && clickedRow < min(MAX_VISIBLE, filteredItems.size())) {
        selectedIndex = clickedRow;
        expanded = false;
        pageChange = true;
        pageNum = 1;
        println("Selected: " + filteredItems.get(selectedIndex));
        
        return filteredItems.get(selectedIndex);
      }
    }
    return "";
  }
  
  // Handles typing to filter the list
  void keyPressed(char key, int code) {
    // Ignore all keypresses if the dropdown is closed — no point filtering a hidden list
    if (!expanded) return;
    // ESC key — close the dropdown without selecting anything
    if (code == ESC)       { expanded = false; }
    // BACKSPACE — delete the last character from the search text, then re-filter.
    // The length check prevents errors from backspacing on an already empty string.
    else if (key == BACKSPACE && searchText.length() > 0) {
      searchText = searchText.substring(0, searchText.length() - 1);
      updateFilter();
      // Any standard typeable character (space through ~) — append it to the search text.
    } else if (key >= ' ' && key <= '~') {
      searchText += key;
      updateFilter();
    }
  }
  
  
}
