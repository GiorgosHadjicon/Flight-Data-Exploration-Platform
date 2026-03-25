//====================
// Drawing Map Screen (one off object)
//====================
void calibrateMap() {

  mapLeft = 90;          // Seattle X
  mapTop = 120;          // Seattle Y

  mapRight = width - 90; // Miami X
  mapBottom = height - 50; // Miami Y
}

class MapScreen {
  PImage usaMap;
  Flight currentFlight = null;
  float planeT = 0;
  float planeSpeed = 0.005;
  boolean flightFinished = false;
  float mapLon(float lon) {
  return map(lon, westLon, eastLon, mapLeft, mapRight);
}

float mapLat(float lat) {
  return map(lat, northLat, southLat, mapTop, mapBottom);
}
  
  MapScreen(PImage usaMap) {
    this.usaMap = usaMap;

  }
  
void setFlight(Flight f) {
  currentFlight = f;
  planeT = 0;
  planeSpeed = 0.005;
  flightFinished = false;
}
  
  void drawMap() {
    pushStyle();
    drawBackgroundMap();
    drawFlights();
    //drawTopBar();
    popStyle();
  }
  
  
  void drawBackgroundMap() {
    //background(15, 45, 80);
  
      image(usaMap, 332, 145, 834, 463);
  
      // blue tint overlay to match the reference style
      fill(20, 70, 110, 140);
      noStroke();
      rect(332, 145, 834, 463);
   
  }
  
  void drawFlights() {

  if (currentFlight == null) return;

  Airport a1 = airportMap.get(currentFlight.origin);
  Airport a2 = airportMap.get(currentFlight.destination);

  if (a1 == null || a2 == null) return;

  float x1 = mapLon(a1.lon);
  float y1 = mapLat(a1.lat);

  float x2 = mapLon(a2.lon);
  float y2 = mapLat(a2.lat);
  
  x1 = constrain(x1, 80, width-80);
  x2 = constrain(x2, 80, width-80);
  
  y1 = constrain(y1, 100, height-40);
  y2 = constrain(y2, 100, height-40);
    
  fill(0,255,120);
  ellipse(x1, y1, 8, 8);
  ellipse(x2, y2, 8, 8);

  // CURVE CONTROL POINT
  float dist = dist(x1, y1, x2, y2);
  float curveHeight = constrain(dist * 0.25, 40, 180);
  
  float cx = (x1 + x2) / 2.0;
  float cy = min(y1, y2) - curveHeight;
  
  // Prevent curve going off top of map
  float mapTop = 80;
  cy = max(cy, mapTop + 40);

  // DRAW CURVE
  stroke(0, 255, 120);
  strokeWeight(3);
  noFill();
  beginShape();
  for (float t = 0; t <= 1; t += 0.02) {
    float xt = bezierPoint(x1, cx, cx, x2, t);
    float yt = bezierPoint(y1, cy, cy, y2, t);
    vertex(xt, yt);
  }
  endShape();

  // ANIMATE PLANE
 if (!flightFinished) {

  planeT += planeSpeed;

  // acceleration at start
  if (planeT < 0.2) {
    planeSpeed = 0.002 + planeT * 0.01;
  }

  // cruise
  else if (planeT < 0.8) {
    planeSpeed = 0.01;
  }

  // slow down near destination
  else {
    planeSpeed = max(0.003, 0.01 * (1 - planeT));
  }
 }

  if (planeT >= 1) {
    planeT = 1;
    flightFinished = true;
  }


if (flightFinished) {
  fill(0,255,120,150);
  ellipse(x2, y2, 20, 20);
}
  
  float px = bezierPoint(x1, cx, cx, x2, planeT);
  float py = bezierPoint(y1, cy, cy, y2, planeT);
  
  float dx = bezierTangent(x1, cx, cx, x2, planeT);
  float dy = bezierTangent(y1, cy, cy, y2, planeT);
  
  float angle = atan2(dy, dx);
  
  drawPlane(px, py, angle, 0.8, color(255,230,80));
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
  
  void drawTopBar() {
  fill(35, 130, 180);
  noStroke();
  rect(0, 0, width, 80);

  fill(255);
  textAlign(CENTER, CENTER);

  textSize(34);
  text("FLIGHT MAP", width/2, 28);

  textSize(18);

  if (currentFlight != null) {
    String label = currentFlight.origin + " → " + currentFlight.destination;
    text(label, width/2, 58);
  } else {
    text("No flight selected", width/2, 58);
  }
}
}
  
