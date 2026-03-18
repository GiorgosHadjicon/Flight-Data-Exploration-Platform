//====================
// Drawing Map Screen (one off object)
//====================

class MapScreen {
  PImage usaMap;
  ArrayList<FlightMarker> flights = new ArrayList<FlightMarker>();
  int selectedFlight = -1;   
  
  MapScreen(PImage usaMap) {
    this.usaMap = usaMap;

    // Make the random positions fixed every run
    randomSeed(42);
    createFlights();
  }
  
  void drawMap() {
    pushStyle();
    drawBackgroundMap();
    drawFlights();
    drawTopBar();
    drawInstructions();
    popStyle();
  }
  
  void createFlights() {
    flights.clear();
  
    // Create 6 random flight markers on the US map area
    for (int i = 0; i < 6; i++) {
      float x1 = random(120, width - 140);
      float y1 = random(150, height - 90);
  
      // destination also random
      float x2 = constrain(x1 + random(-220, 220), 80, width - 80);
      float y2 = constrain(y1 + random(-150, 150), 120, height - 60);
  
      String code = "FL" + nf(i + 1, 2);
      flights.add(new FlightMarker(x1, y1, x2, y2, code));
    }
  
    selectedFlight = 0;   // first flight highlighted at start
  }
  
  void drawBackgroundMap() {
    background(15, 45, 80);
  
      image(usaMap, 0, 80, width, height - 80);
  
      // blue tint overlay to match the reference style
      fill(20, 70, 110, 140);
      noStroke();
      rect(0, 80, width, height - 80);
   
  }
  
  void drawFlights() {
    // Draw all non-selected flights first
    for (int i = 0; i < flights.size(); i++) {
      if (i != selectedFlight) {
        flights.get(i).display(false);
      }
    }
  
    // Draw selected flight last so it stays on top
    if (selectedFlight >= 0 && selectedFlight < flights.size()) {
      flights.get(selectedFlight).display(true);
    }
  }
  
  void drawTopBar() {
    fill(35, 130, 180);
    noStroke();
    rect(0, 0, width, 80);
  
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(34);
    text("FLIGHT MAP", width/2, 28);
  
    textSize(18);
    if (selectedFlight >= 0) {
      FlightMarker f = flights.get(selectedFlight);
      text("Selected: " + f.code, width/2, 58);
    } else {
      text("Selected: none", width/2, 58);
    }
  }
  
  void drawInstructions() {
    fill(255);
    textAlign(LEFT, TOP);
    textSize(14);
    text("Click a plane to highlight it", 20, 92);
  }
}

//void mousePressed() {
//  float bestDist = 999999;
//  int bestIndex = -1;

//  for (int i = 0; i < flights.size(); i++) {
//    float d = dist(mouseX, mouseY, flights.get(i).x1, flights.get(i).y1);
//    if (d < 20 && d < bestDist) {
//      bestDist = d;
//      bestIndex = i;
//    }
//  }

//  if (bestIndex != -1) {
//    selectedFlight = bestIndex;
//  }
//}

//void keyPressed() {
//  if (key >= '1' && key <= '6') {
//    int index = key - '1';
//    if (index < flights.size()) {
//      selectedFlight = index;
//    }
//  }
//}
