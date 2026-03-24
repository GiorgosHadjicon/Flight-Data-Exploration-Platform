//====================
// Drawing Graph Screen (one off object)
//====================

// draw things when this screen is selected
// make graphs using flight data

class GraphsScreen {

  PImage topOrigins;
  
  GraphsScreen(PImage topOrigins) {
    
    this.topOrigins = topOrigins;
    
  }
  
  void drawTopOrigins() {
  
    image(topOrigins, 332, 145, 834, 463);
    
  }


}
