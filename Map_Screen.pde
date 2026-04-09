//========================
//== Drawing Map Screen ==
//========================
// AUTHORSHIP: Zuhairia Sahjabin

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
    
  fill(0,255,120);
  ellipse(x1, y1, 8, 8);
  ellipse(x2, y2, 8, 8);

  // CURVE CONTROL POINT
  float dist = dist(x1, y1, x2, y2);
  float curveHeight = constrain(dist * 0.25, 40, 180);
  
  float cx = (x1 + x2) / 2.0;
  float cy = (y1 + y2) / 2.0 - curveHeight;
  cy = constrain(cy, mapTop + 10, mapBottom - 10);
  
  x1 = constrain(x1, mapLeft, mapRight);
  y1 = constrain(y1, mapTop, mapBottom);
  
  x2 = constrain(x2, mapLeft, mapRight);
  y2 = constrain(y2, mapTop, mapBottom);

  // DRAW BEZIER CURVE 
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
  
  px = constrain(px, mapLeft, mapRight);
  py = constrain(py, mapTop, mapBottom);
  
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

  noStroke();

  // BODY SHADOW (depth)
  fill(150,150,150,120);
  ellipse(-2, 2, 22, 8);

  // MAIN BODY
  fill(240,240,240);
  ellipse(0,0,20,6);

  // NOSE
  fill(255,230,80);
  triangle(10,0,4,-3,4,3);

  // TOP WING
  fill(210);
  quad(-2,-1, 5,-2, -6,-10, -10,-6);

  // BOTTOM WING
  fill(180);
  quad(-2,1, 5,2, -6,10, -10,6);

  // TAIL
  fill(200);
  triangle(-10,0,-18,-5,-10,-1);
  triangle(-10,0,-18,5,-10,1);

  // COCKPIT
  fill(40,80,120);
  ellipse(6,0,4,3);

  popMatrix();
}
  
}
  
