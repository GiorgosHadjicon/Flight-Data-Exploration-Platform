// =========================================
// ==== BubbleChartAnimated.pde ============
// =========================================


class BubbleChartAnimated {

  // --- Data ---
  String[] codes  = {"DFW","ATL","ORD","DEN","CLT","LAX","LGA","SEA","PHX","EWR"};
  String[] cities = {"Dallas/FW","Atlanta","Chicago","Denver","Charlotte",
                      "Los Angeles","New York","Seattle","Phoenix","Newark"};
  int[]    counts = {4339, 4293, 4248, 3687, 3517, 2832, 2417, 2409, 2395, 2232};

  color[] bubbleColors = {
    color(0, 162, 232),
    color(255, 127, 39),
    color(34, 177, 76),
    color(237, 28, 36),
    color(163, 73, 164),
    color(255, 201, 14),
    color(63, 72, 204),
    color(185, 122, 87),
    color(255, 174, 201),
    color(181, 230, 29)
  };

  // Layout panel
  int px = 332, py = 145, pw = 834, ph = 463;
  int panelCx, panelCy;

  // Bubble physics
  float[] bx, by;           // current positions
  float[] tx, ty;           // target positions
  float[] vx, vy;           // velocity for spring
  float[] radii;            // target radii
  float[] currentRadii;     // animated radii
  int     n;

  boolean animating = false;
  boolean done      = false;
  float   spring    = 0.08;
  float   damping   = 0.75;
  float   easing    = 0.06;

  // Hover
  int hoverBubble = -1;

  BubbleChartAnimated() {
    n = counts.length;
    bx = new float[n]; by = new float[n];
    tx = new float[n]; ty = new float[n];
    vx = new float[n]; vy = new float[n];
    radii        = new float[n];
    currentRadii = new float[n];

    panelCx = px + pw / 2;
    panelCy = py + ph / 2 + 15;


    float maxRadius = 80;
    float minRadius = 30;

    // Compute target radii proportional to count
    for (int i = 0; i < n; i++) {
      radii[i] = map(counts[i], counts[n-1], counts[0], minRadius, maxRadius);
    }

    // Lay targets out in a simple circle-pack ring
    computeTargetPositions();
  }

  void computeTargetPositions() {
    // Place the biggest bubble in the centre, rest around it
    tx[0] = panelCx;
    ty[0] = panelCy;

    int ring = n - 1;
    float ringRadius = radii[0] + radii[1] + 10;
    for (int i = 1; i < n; i++) {
      float angle = TWO_PI * (i - 1) / ring;
      tx[i] = panelCx + cos(angle) * ringRadius;
      ty[i] = panelCy + sin(angle) * ringRadius;
    }
  }

  void start() {
    // Spawn from random edges
    for (int i = 0; i < n; i++) {
      // random off-panel start
      bx[i] = px + random(pw);
      by[i] = py - 200 - random(200);
      vx[i] = random(-3, 3);
      vy[i] = random(0, 5);
      currentRadii[i] = 0;
    }
    animating = true;
    done = false;
  }

  void reset() {
    animating = false;
    done = false;
    for (int i = 0; i < n; i++) currentRadii[i] = 0;
  }

  void draw() {
    if (!animating && !done) return;

    pushStyle();

    // panel background
    fill(15, 15, 30);
    noStroke();
    rect(px, py, pw, ph, 8);

    // title
    fill(220);
    textAlign(CENTER);
    textSize(18);
    text("TOP 10 DESTINATIONS — Bubble Size = Volume", panelCx, py + 28);

    // update physics
    if (animating) {
      boolean allSettled = true;
      for (int i = 0; i < n; i++) {
        // spring toward target
        float fx = (tx[i] - bx[i]) * spring;
        float fy = (ty[i] - by[i]) * spring;
        vx[i] = (vx[i] + fx) * damping;
        vy[i] = (vy[i] + fy) * damping;
        bx[i] += vx[i];
        by[i] += vy[i];

        // grow radius
        currentRadii[i] += (radii[i] - currentRadii[i]) * easing;

        if (abs(bx[i] - tx[i]) > 1 || abs(by[i] - ty[i]) > 1 ||
            abs(currentRadii[i] - radii[i]) > 0.5) {
          allSettled = false;
        }
      }
      if (allSettled) { animating = false; done = true; }
    }

    // detect hover
    hoverBubble = -1;
    if (done) {
      for (int i = 0; i < n; i++) {
        float d = dist(mouseX, mouseY, bx[i], by[i]);
        if (d < radii[i]) { hoverBubble = i; break; }
      }
    }

    // draw bubbles (back to front by radius, already sorted desc)
    for (int i = n - 1; i >= 0; i--) {
      float cr2 = currentRadii[i];
      boolean hov = (i == hoverBubble);

      // main circle
      fill(bubbleColors[i]);
      stroke(hov ? color(255) : color(20));
      strokeWeight(hov ? 3 : 1);
      ellipse(bx[i], by[i], cr2 * 2, cr2 * 2);

      // label inside
      if (cr2 > 20) {
        fill(0, 0, 0, 160);
        noStroke();
        ellipse(bx[i], by[i], cr2 * 1.2, cr2 * 0.7);

        fill(255);
        textAlign(CENTER, CENTER);
        textSize(hov ? 14 : 12);
        text(codes[i], bx[i], by[i] - 6);
        textSize(9);
        fill(220);
        text(nfc(counts[i]), bx[i], by[i] + 8);
      }
    }

    // hover tooltip
    if (hoverBubble >= 0) {
      int hi = hoverBubble;
      float pct = (counts[hi] / totalCount()) * 100;
      float ttx = bx[hi] + radii[hi] + 8;
      float tty = by[hi] - 30;
      // keep on screen
      if (ttx + 160 > px + pw) ttx = bx[hi] - radii[hi] - 170;
      fill(20, 20, 40, 230);
      noStroke();
      rect(ttx, tty, 160, 60, 6);
      fill(255);
      textAlign(LEFT, TOP);
      textSize(12);
      text(codes[hi] + " — " + cities[hi], ttx + 8, tty + 6);
      textSize(11);
      fill(200);
      text("Flights: " + nfc(counts[hi]), ttx + 8, tty + 24);
      text("Share:   " + nf(pct, 1, 1) + "%", ttx + 8, tty + 40);
    }

    popStyle();
  }

  float totalCount() {
    float t = 0;
    for (int c : counts) t += c;
    return t;
  }
}
