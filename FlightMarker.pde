//===========================
//=== Flight Marker Class ===
//===========================
// AUTHORSHIP: Zuhairia Sahjabin
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


  // SOLID FLIGHT PATH 
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
