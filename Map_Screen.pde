//====================
// Drawing Map Screen (one off object)
//====================
PImage usaMap;

ArrayList<FlightMarker> flights = new ArrayList<FlightMarker>();
int selectedFlight = -1;

void setup() {
  size(1000, 650);
  
  usaMap = loadImage("usa_map.jpg");
  
  // Make the random positions fixed every run
  randomSeed(42);

  createFlights();
}

void draw() {
  drawBackgroundMap();
  drawFlights();
  drawTopBar();
  drawInstructions();
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

void mousePressed() {
  float bestDist = 999999;
  int bestIndex = -1;

  for (int i = 0; i < flights.size(); i++) {
    float d = dist(mouseX, mouseY, flights.get(i).x1, flights.get(i).y1);
    if (d < 20 && d < bestDist) {
      bestDist = d;
      bestIndex = i;
    }
  }

  if (bestIndex != -1) {
    selectedFlight = bestIndex;
  }
}

void keyPressed() {
  if (key >= '1' && key <= '6') {
    int index = key - '1';
    if (index < flights.size()) {
      selectedFlight = index;
    }
  }
}

// FLIGHT CLASS
class FlightMarker {
  float x1, y1;   // plane position
  float x2, y2;   // destination
  String code;

  FlightMarker(float x1, float y1, float x2, float y2, String code) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.code = code;
  }

  void display(boolean selected) {
    if (selected) {
      // highlighted flight line
      stroke(0, 255, 120);
      strokeWeight(3);
      line(x1, y1, x2, y2);

      // start + end points
      noStroke();
      fill(0, 255, 120);
      ellipse(x1, y1, 10, 10);
      ellipse(x2, y2, 10, 10);

      // plane
      float ang = atan2(y2 - y1, x2 - x1);
      drawPlane(x1, y1, ang, 1.1, color(0, 255, 120));

      // label
      fill(0, 255, 120);
      textAlign(LEFT, BOTTOM);
      textSize(18);
      text(code, x1 + 14, y1 - 8);
    } else {
      // non-selected flight line
      stroke(120, 210, 255, 110);
      strokeWeight(1.5);
      dashedLine(x1, y1, x2, y2, 8);

      noStroke();
      fill(140, 220, 255, 120);
      ellipse(x2, y2, 7, 7);

      float ang = atan2(y2 - y1, x2 - x1);
      drawPlane(x1, y1, ang, 0.9, color(255, 230, 80));
    }
  }
}

// DRAW PLANE
void drawPlane(float x, float y, float angle, float scaleAmt, int c) {
  pushMatrix();
  translate(x, y);
  rotate(angle);
  scale(scaleAmt);

  fill(c);
  noStroke();

  // simple plane silhouette
  beginShape();
  vertex(18, 0);    // nose
  vertex(6, -4);
  vertex(2, -12);   // top wing front
  vertex(-2, -12);
  vertex(-5, -4);
  vertex(-14, -4);
  vertex(-18, -10); // tail top
  vertex(-21, -10);
  vertex(-18, 0);
  vertex(-21, 10);  // tail bottom
  vertex(-18, 10);
  vertex(-14, 4);
  vertex(-5, 4);
  vertex(-2, 12);   // bottom wing front
  vertex(2, 12);
  vertex(6, 4);
  endShape(CLOSE);

  popMatrix();
}

// DASHED LINE 
void dashedLine(float x1, float y1, float x2, float y2, float dashLength) {
  float totalDist = dist(x1, y1, x2, y2);
  float dx = x2 - x1;
  float dy = y2 - y1;
  float angle = atan2(dy, dx);

  for (float i = 0; i < totalDist; i += dashLength * 2) {
    float sx = x1 + cos(angle) * i;
    float sy = y1 + sin(angle) * i;
    float ex = x1 + cos(angle) * min(i + dashLength, totalDist);
    float ey = y1 + sin(angle) * min(i + dashLength, totalDist);
    line(sx, sy, ex, ey);
  }
}
