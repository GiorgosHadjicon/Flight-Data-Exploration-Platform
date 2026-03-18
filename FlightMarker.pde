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
}
