// =========================================
// ==== PieChartAnimated.pde ===============
// =========================================


class PieChartAnimated {


  // DATA SECTION
  // These three arrays hold our top-10 destination info.
  // The order matters — index 0 is first in all three.
  // So codes[0]="DFW", cities[0]="Dallas/FW", counts[0]=4339

  String[] codes  = {"DFW","ATL","ORD","DEN","CLT","LAX","LGA","SEA","PHX","EWR"};
  String[] cities = {"Dallas/FW","Atlanta","Chicago","Denver","Charlotte",
                      "Los Angeles","New York","Seattle","Phoenix","Newark"};
  int[]    counts = {4339, 4293, 4248, 3687, 3517, 2832, 2417, 2409, 2395, 2232};

  // One colour per slice — same order as the arrays above
  color[] sliceColors = {
    color(0, 162, 232),    // DFW — blue
    color(255, 127, 39),   // ATL — orange
    color(34, 177, 76),    // ORD — green
    color(237, 28, 36),    // DEN — red
    color(163, 73, 164),   // CLT — purple
    color(255, 201, 14),   // LAX — yellow
    color(63, 72, 204),    // LGA — navy
    color(185, 122, 87),   // SEA — brown
    color(255, 174, 201),  // PHX — pink
    color(181, 230, 29)    // EWR — lime
  };

  // ANIMATION STATE
  // totalAngle starts at 0 and creeps toward TWO_PI (= 360 degrees).
  // Each frame we move it a little closer

  float totalAngle  = 0;        // how much of the pie has been drawn so far
  float targetAngle = TWO_PI;   // TWO_PI = full circle (360 degrees in radians)
  boolean animating = false;    // true while the sweep is still moving
  boolean done      = false;    // true once the sweep has fully finished
  float   easing    = 0.055;    // how fast it eases — bigger = faster (0..1)


  // SLICE ANGLES
  // Each airport gets a slice whose angle is proportional
  // to its flight count vs the total of all counts.
  // e.g. DFW = 4339 / 32769 * TWO_PI = about 0.83 radians

  float[] sliceAngles;   // calculated in the constructor below
  float   total = 0;     // sum of all counts, calculated in constructor

  // Which slice is the mouse currently over? -1 means none.
  int hoverSlice = -1;


  // LAYOUT — position and size of the donut on screen
  // The main display panel runs from x=332 to x=1166
  // and y=145 to y=608, so we centre inside that.

  int cx, cy;    // centre point of the donut
  int r;         // outer radius of the donut
  int rInner;    // inner radius — the hole in the middle




  // Sets up totals and pre-calculates each slice's angle.

  PieChartAnimated() {

    // Add up all flight counts to get the grand total
    for (int c : counts) total += c;

    // Allocate the slice angles array (one entry per airport)
    sliceAngles = new float[counts.length];

    // For each airport, its slice angle = its share of the total * full circle
    for (int i = 0; i < counts.length; i++) {
      sliceAngles[i] = (counts[i] / total) * TWO_PI;
    }

    // Centre point: middle of our display panel
    cx = 332 + 834 / 2;       // horizontal centre 
    cy = 145 + 463 / 2 + 10;  // vertical centre  

    r      = 160;   // outer edge of the donut
    rInner =  80;   // inner edge (the hole)
  }


  //call this to kick off the animation from zero

  void start() {
    totalAngle = 0;    // reset sweep to nothing
    animating  = true;
    done       = false;
  }



  void reset() {
    totalAngle = 0;
    animating  = false;
    done       = false;
  }



  // updates animation, checks hover,
  // then paints everything onto the screen.

  void draw() {

    // If the chart isn't running at all, do nothing and bail out early
    if (!animating && !done) return;


    // Each frame, nudge totalAngle a little closer to TWO_PI.
    // The easing formula moves X% of the remaining distance each frame,
    // so it starts fast and naturally slows as it approaches the end.
    if (animating) {
      totalAngle += (targetAngle - totalAngle) * easing;

      // Once we're close enough, snap to exactly TWO_PI and mark done
      if (abs(totalAngle - targetAngle) < 0.005) {
        totalAngle = targetAngle;
        animating  = false;
        done       = true;
      }
    }


    hoverSlice = getHoverSlice();   // returns -1 if mouse is not on any slice

    pushStyle();  // save current colour/stroke settings so we don't mess up other code



    fill(15, 15, 30);   // very dark navy
    noStroke();
    rect(332, 145, 834, 463, 8);   // rounded rectangle covering the display area



    fill(220);
    textAlign(CENTER);
    textSize(18);
    text("TOP 10 DESTINATIONS — Share of Flights", cx, 175);



    // We walk around the circle, slice by slice.
    // startA tracks where the next slice should begin (in radians).
    // drawn  tracks how many radians of the circle we've already passed.
    float startA = -HALF_PI;  // start at the top of the circle (12 o'clock)
    float drawn  = 0;

    for (int i = 0; i < counts.length; i++) {
      float sweep = sliceAngles[i];   // full angle this slice would occupy

      // Figure out how much of this slice to actually reveal right now.
      // Think of totalAngle as a "sweep hand" moving clockwise.
      // Anything behind the hand is visible; anything ahead is hidden.
      float reveal;
      if (drawn + sweep <= totalAngle) {
        reveal = sweep;              // this entire slice is behind the sweep hand — show it all
      } else if (drawn < totalAngle) {
        reveal = totalAngle - drawn; // partially behind — show only what the hand has passed
      } else {
        reveal = 0;                  // hand hasn't reached this slice yet — hide it
      }

      if (reveal > 0) {
        boolean hov    = (i == hoverSlice) && done;  // is the mouse currently over this slice?
        float offset   = hov ? 12 : 0;               // pop hovered slice outward by 12 pixels
        float midA     = startA + reveal / 2;         // angle pointing to the middle of this slice
        float ox       = cos(midA) * offset;          // how far to shift it horizontally
        float oy       = sin(midA) * offset;          // how far to shift it vertically



        // Draw the actual slice 
        fill(sliceColors[i]);
        stroke(15);       // thin dark line between slices
        strokeWeight(2);
        arc(cx + ox, cy + oy, r * 2, r * 2, startA, startA + reveal, PIE);
      }

      // Move our trackers forward for the next slice
      drawn  += sweep;
      startA += sweep;
    }



    // Paint a dark circle in the middle to cover the pie centre.
    // This turns a solid pie into a donut shape.
    fill(15, 15, 30);
    noStroke();
    ellipse(cx, cy, rInner * 2, rInner * 2);


    //Centre label
    if (done) {
      if (hoverSlice >= 0) {
        // Mouse is hovering a slice — show that airport's details in the hole
        float pct = (counts[hoverSlice] / total) * 100;
        fill(255);
        textAlign(CENTER, CENTER);
        textSize(20);
        text(codes[hoverSlice], cx, cy - 14);     // airport code e.g. "DFW"
        textSize(13);
        text(nf(pct, 1, 1) + "%", cx, cy + 8);   // percentage e.g. "13.2%"
        fill(170);
        textSize(9);
        text(nfc(counts[hoverSlice]) + " flights", cx, cy + 24);  // count e.g. "4,339 flights"
      } else {
        // Nothing hovered — show a prompt to guide the user
        fill(180);
        textAlign(CENTER, CENTER);
        textSize(11);
        text("HOVER SLICE", cx, cy - 7);
        text("FOR DETAILS", cx, cy + 7);
      }
    } else {
      // Animation still running — show a loading message
      fill(180);
      textAlign(CENTER, CENTER);
      textSize(13);
      text("Loading...", cx, cy);
    }


    // legend to the right 
    // Stack coloured swatches + labels in a column to the right
    int lx = cx + r + 30;                          // X: start just to the right of the donut
    int ly = cy - (counts.length * 20) / 2;        // Y: vertically centre the legend block

    for (int i = 0; i < counts.length; i++) {
      boolean hov = (i == hoverSlice) && done;
      float pct   = (counts[i] / total) * 100;
      int ry      = ly + i * 22;                   // Y position of this row (spaced 22px apart)

      // Small coloured square swatch — white when hovered, otherwise the slice colour
      fill(hov ? color(255) : sliceColors[i]);
      noStroke();
      rect(lx, ry, 14, 14, 3);

      // Text label: airport code + percentage
      fill(hov ? color(255) : color(190));
      textAlign(LEFT, TOP);
      textSize(hov ? 12 : 10);   // slightly bigger text when hovered
      text(codes[i] + "  " + nf(pct, 1, 1) + "%", lx + 18, ry);
    }

    popStyle();  // restore whatever colour/stroke settings were active before this draw() call
  }



  // getHoverSlice()
  // Works out which slice (if any) the mouse is sitting on.
  // Returns the slice index (0–9), or -1 if mouse is off the donut.
  // -------------------------------------------------------
  int getHoverSlice() {

    // Vector from donut centre to current mouse position
    float dx = mouseX - cx;
    float dy = mouseY - cy;

    // Straight-line distance from centre to mouse
    float dist2 = sqrt(dx * dx + dy * dy);

    // Mouse is inside the hole OR outside the outer ring — not on any slice
    if (dist2 < rInner || dist2 > r) return -1;

    // atan2 gives the angle of the mouse around the centre.
    // Range is -PI to PI, where 0 = right (3 o'clock).
    float angle = atan2(dy, dx);

    // Shift by HALF_PI so that 0 = top (12 o'clock),
    // matching how we drew the slices starting at -HALF_PI
    float a = angle + HALF_PI;

    // Wrap any negative value around so everything sits in 0..TWO_PI
    if (a < 0)       a += TWO_PI;
    if (a > TWO_PI)  a -= TWO_PI;

    // Walk through the slices, accumulating angles.
    // The first slice whose cumulative angle exceeds 'a' is the one the mouse is on.
    float cumulative = 0;
    for (int i = 0; i < sliceAngles.length; i++) {
      cumulative += sliceAngles[i];
      if (a < cumulative) return i;
    }

    return -1;  // fallback — shouldn't normally reach here
  }
}
