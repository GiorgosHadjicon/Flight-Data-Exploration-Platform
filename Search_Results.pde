//====================
// Search Results Screen (one off object)
//====================

// draw things when this screen is selected
// airport like bar with results and ability to select specific flight ( maybe show details button here)

class Search_Results {

  ArrayList<Flight> flightsFiltered;
  PFont textDisplay;
  
  // Constructor takes in array of flights that have been already filtered and stores them
  Search_Results(ArrayList<Flight> flightsFiltered) {
  
    textDisplay = loadFont("AlTarikh-48.vlw");
    this.flightsFiltered = flightsFiltered;
    
  }
  
  
  void drawDepartureFromDate(int userDateDeparture) {
     
    stroke(0);
    strokeWeight(5);
    fill(180);
    rect(500, 200, 500, 400, 5);
    
    stroke(0);
    strokeWeight(5);
    fill(0, 100, 255);
    rect(525, 225, 450, 350, 5);
    
    for (int i = 0; i < flightsFiltered.size(); i++) {
      Flight currentFlight = flights.get(i);
      if (currentFlight.flightDate.day == userDateDeparture) {
        String displayString = currentFlight.getData(); // Uses data from string
        float yPos = 300 + (i * 40); // Spacing each line 40 pixels apart
        fill(0);
        textSize(20);
        text(displayString, 550, yPos);
      }
      
      
      
    } 
  }
  

}
