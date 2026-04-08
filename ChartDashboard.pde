// AUTHORSHIP: Odysseas Leonidou

class ChartDashboard {

  final int TOTAL_DATASETS   = 4;   // how many datasets exist
  final int TOTAL_CHART_TYPES = 3;   // how many chart styles exist (bar, pie, bubble)
  final int ENTRIES_PER_DATASET = 10; // every dataset has exactly 10 entries

  //label for each dataset — shown as the chart title
  String[] datasetTitleLabels = {
    "TOP 10 DESTINATIONS",
    "TOP 10 ORIGINS",
    "TOP 10 AIRLINES",
    "TOP 10 DESTINATION STATES"
  };

  //label for each chart type — shown alongside the title
  String[] chartTypeLabels = {
    "TYPE OF CHART: BAR",
    "TYPE OF CHART: PIE",
    "TYPE OF CHART: BUBBLE"
  };

  // ---- DATASET 0: Top 10 Flight Destinations ----
  String[] destinationShortCodes = {"DFW","ATL","ORD","DEN","CLT","LAX","LGA","SEA","PHX","EWR"};
  String[] destinationFullNames  = {"Dallas/Fort Worth","Atlanta","Chicago","Denver","Charlotte",
                                     "Los Angeles","New York","Seattle","Phoenix","Newark"};
  int[]    destinationFlightCounts = {4339,4293,4248,3687,3517,2832,2417,2409,2395,2232};

  // ---- DATASET 1: Top 10 Flight Origins ----
  String[] originShortCodes = {"DFW","ATL","ORD","DEN","CLT","LAX","SEA","LGA","PHX","EWR"};
  String[] originFullNames  = {"Dallas/Fort Worth","Atlanta","Chicago","Denver","Charlotte",
                                "Los Angeles","Seattle","New York","Phoenix","Newark"};
  int[]    originFlightCounts = {4319,4316,4245,3682,3522,2849,2412,2409,2387,2226};

  // ---- DATASET 2: Top 10 Airlines by number of flights operated ----
  String[] airlineShortCodes = {"AA","DL","UA","WN","AS","B6","NK","F9","G4","HA"};
  String[] airlineFullNames  = {"American","Delta","United","Southwest","Alaska",
                                 "JetBlue","Spirit","Frontier","Allegiant","Hawaiian"};
  int[]    airlineFlightCounts = {28937,19211,17956,16343,5792,4327,3049,2023,1335,1026};

  // ---- DATASET 3: Top 10 Destination States by number of flights received ----
  String[] stateShortCodes = {"TX","FL","CA","NY","IL","NC","GA","CO","VA","WA"};
  String[] stateFullNames  = {"Texas","Florida","California","New York","Illinois",
                               "N. Carolina","Georgia","Colorado","Virginia","Washington"};
  int[]    stateFlightCounts = {10708,9805,9677,5572,5342,4841,4679,4458,4182,2887};



  String[] activeShortCodes;    // e.g. ["DFW","ATL",...] for the current dataset
  String[] activeFullNames;     // e.g. ["Dallas/Fort Worth","Atlanta",...]
  int[]    activeFlightCounts;  // e.g. [4339,4293,...] — must be sorted high to low
  int      highestCountInDataset; // the biggest single value (used to scale bar heights)
  float    totalFlightsInDataset; // sum of all 10 values (used to calculate percentages)



  color[] entryColors = {
    color(0,   162, 232),   // entry 0 — bright blue
    color(255, 127,  39),   // entry 1 — orange
    color( 34, 177,  76),   // entry 2 — green
    color(237,  28,  36),   // entry 3 — red
    color(163,  73, 164),   // entry 4 — purple
    color(255, 201,  14),   // entry 5 — yellow
    color( 63,  72, 204),   // entry 6 — navy
    color(185, 122,  87),   // entry 7 — brown
    color(255, 174, 201),   // entry 8 — pink
    color(181, 230,  29)    // entry 9 — lime
  };



  final int PANEL_LEFT   = 332;
  final int PANEL_TOP    = 145;
  final int PANEL_WIDTH  = 834;
  final int PANEL_HEIGHT = 463;
  final int PANEL_RIGHT  = PANEL_LEFT + PANEL_WIDTH;   // = 1166
  final int PANEL_BOTTOM = PANEL_TOP  + PANEL_HEIGHT;  // = 608
  int panelCentreX;   // horizontal midpoint of the panel — set in constructor
  int panelCentreY;   // vertical   midpoint of the panel — set in constructor




  // ---- Dataset slider — leftmost column ----
  final int DATASET_SLIDER_CENTRE_X = 220;   // sits 42px left of the panel edge
  final int DATASET_SLIDER_TOP_Y    = 180;   // top of the draggable range
  final int DATASET_SLIDER_BOTTOM_Y = 560;   // bottom of the draggable range
  final int DATASET_SLIDER_TRACK_HEIGHT = DATASET_SLIDER_BOTTOM_Y - DATASET_SLIDER_TOP_Y; // = 380
  int       datasetThumbY;                   // current thumb Y position (moves between top and bottom)
  boolean   datasetSliderBeingDragged = false; // true only while the user holds the mouse on this thumb
  int       selectedDatasetIndex = 0;          // which dataset is active right now (0-3)

  // ---- Chart type slider — second column, just right of the dataset slider ----
  final int CHARTTYPE_SLIDER_CENTRE_X = 300;  // sits 14px right of the dataset slider
  final int CHARTTYPE_SLIDER_TOP_Y    = 180;
  final int CHARTTYPE_SLIDER_BOTTOM_Y = 560;
  final int CHARTTYPE_SLIDER_TRACK_HEIGHT = CHARTTYPE_SLIDER_BOTTOM_Y - CHARTTYPE_SLIDER_TOP_Y; // = 380
  int       chartTypeThumbY;                    // current thumb Y position
  boolean   chartTypeSliderBeingDragged = false;
  int       selectedChartTypeIndex = 0;          // 0 = bar, 1 = pie, 2 = bubble

  // Shared thumb size for both sliders
  final int SLIDER_THUMB_RADIUS    = 10;
  final int SLIDER_TRACK_WIDTH     =  12;   // visual thickness of the slider rail



  float   animationProgress     = 0.0;   // current progress, 0 to 1
  float   animationEasingSpeed  = 0.06;  // how much of the remaining distance to cover each frame
  boolean animationIsRunning    = false; // true while progress < 1
  boolean animationIsComplete   = false; // true once progress has reached 1
  
   // Bubble chart needs its own position + velocity arrays for spring physics
  float[] bubbleCurrentX   = new float[ENTRIES_PER_DATASET];
  float[] bubbleCurrentY   = new float[ENTRIES_PER_DATASET];
  float[] bubbleVelocityX  = new float[ENTRIES_PER_DATASET];
  float[] bubbleVelocityY  = new float[ENTRIES_PER_DATASET];



  // Which entry the mouse is currently hovering (-1 = none)
  int hoveredEntryIndex = -1;


  // ===========================================================================
  ChartDashboard() {
    panelCentreX = PANEL_LEFT + PANEL_WIDTH  / 2;  // = 749
    panelCentreY = PANEL_TOP  + PANEL_HEIGHT / 2;  // = 376

    // Position thumbs at the top of their tracks (index 0 = top = first option)
    datasetThumbY   = DATASET_SLIDER_TOP_Y;
    chartTypeThumbY = CHARTTYPE_SLIDER_TOP_Y;

    // Load dataset 0 (Top Destinations) and begin the animation
    switchToDataset(0);
    restartAnimation();
  }



  void switchToDataset(int newIndex) {
    selectedDatasetIndex = newIndex;

    // Point the active arrays at the chosen dataset
    if (newIndex == 0) {
      activeShortCodes   = destinationShortCodes;
      activeFullNames    = destinationFullNames;
      activeFlightCounts = destinationFlightCounts;
    } else if (newIndex == 1) {
      activeShortCodes   = originShortCodes;
      activeFullNames    = originFullNames;
      activeFlightCounts = originFlightCounts;
    } else if (newIndex == 2) {
      activeShortCodes   = airlineShortCodes;
      activeFullNames    = airlineFullNames;
      activeFlightCounts = airlineFlightCounts;
    } else {
      activeShortCodes   = stateShortCodes;
      activeFullNames    = stateFullNames;
      activeFlightCounts = stateFlightCounts;
    }

    // The first entry is always the highest because data is pre-sorted descending
    highestCountInDataset = activeFlightCounts[0];

    // Sum all entries — needed for percentage calculations in the pie chart
    totalFlightsInDataset = 0;
    for (int count : activeFlightCounts) totalFlightsInDataset += count;

    // Snap the dataset slider thumb to the notch for this index
    // Index 0 → top, index (TOTAL_DATASETS-1) → bottom
    float notchFraction = newIndex / (float)(TOTAL_DATASETS - 1);
    datasetThumbY = (int)(DATASET_SLIDER_TOP_Y + notchFraction * DATASET_SLIDER_TRACK_HEIGHT);
  }


  void restartAnimation() {
    animationProgress  = 0.0;
    animationIsRunning = true;
    animationIsComplete = false;

    // Snap the chart type slider thumb to the correct notch
    float notchFraction = selectedChartTypeIndex / (float)(TOTAL_CHART_TYPES - 1);
    chartTypeThumbY = (int)(CHARTTYPE_SLIDER_TOP_Y + notchFraction * CHARTTYPE_SLIDER_TRACK_HEIGHT);
    
      if (selectedChartTypeIndex == 2) {
      for (int i = 0; i < ENTRIES_PER_DATASET; i++) {
        bubbleCurrentX[i]  = PANEL_LEFT + random(PANEL_WIDTH);
        bubbleCurrentY[i]  = PANEL_TOP - 150 - random(200);  // above the panel
        bubbleVelocityX[i] = random(-2, 2);
        bubbleVelocityY[i] = random(1, 4);
      }
    }
  }




  void draw() {
    pushStyle();

    drawDarkPanelBackground();
    drawChartTitle();
    advanceAnimation();       // move animationProgress closer to 1.0

    // Draw whichever chart type is currently selected
    if      (selectedChartTypeIndex == 0) drawBarChart();
    else if (selectedChartTypeIndex == 1) drawPieChart();
    else if (selectedChartTypeIndex == 2) drawBubbleChart();

    drawBothSliders();        // always drawn last so they sit on top of everything

    popStyle();
  }



  void drawDarkPanelBackground() {
    fill(15, 15, 30);
    noStroke();
    rect(PANEL_LEFT, PANEL_TOP, PANEL_WIDTH, PANEL_HEIGHT, 8);
  }



  void drawChartTitle() {
    fill(220);
    textAlign(CENTER);
    textSize(17);
    text(datasetTitleLabels[selectedDatasetIndex], panelCentreX, PANEL_TOP + 24);
    fill(150);
    textSize(12);
    text(chartTypeLabels[selectedChartTypeIndex], panelCentreX, PANEL_TOP + 42);
  }



  // advanceAnimation()
  // Called every frame. Moves animationProgress from its current value toward
  // 1.0 by a fraction of the remaining distance (easing).
  // Once close enough, it snaps to exactly 1.0 and marks the animation done.

  void advanceAnimation() {
    if (!animationIsRunning) return;

    // Easing: close the gap by animationEasingSpeed each frame
    animationProgress += (1.0 - animationProgress) * animationEasingSpeed;

    // Snap and stop once we're within 0.004 of the target
    if (abs(animationProgress - 1.0) < 0.004) {
      animationProgress   = 1.0;
      animationIsRunning  = false;
      animationIsComplete = true;
    }
  }



  void drawBarChart() {
    // The chart area sits inside the panel with padding for axis labels and slider labels
    int chartLeft   = PANEL_LEFT + 60;
    int chartTop    = PANEL_TOP  + 55;
    int chartWidth  = PANEL_WIDTH  - 80;
    int chartHeight = PANEL_HEIGHT - 100;

    // ---- Horizontal grid lines and Y-axis labels ----
    int numberOfGridLines = 5;
    stroke(50); strokeWeight(1);
    for (int gridLine = 0; gridLine <= numberOfGridLines; gridLine++) {
      // gridFraction goes from 0 (baseline) to 1 (top)
      float gridFraction = gridLine / (float)numberOfGridLines;
      int   gridY        = chartTop + chartHeight - (int)(chartHeight * gridFraction);

      // Draw the faint horizontal line across the chart
      line(chartLeft, gridY, chartLeft + chartWidth, gridY);

      // Label on the left showing what count this line represents
      int gridCountValue = (int)(highestCountInDataset * gridFraction);
      fill(130); noStroke(); textSize(10); textAlign(RIGHT);
      text(nfc(gridCountValue), chartLeft - 4, gridY + 4);
      stroke(50);
    }

    // ---- Bars ----
    float barSlotWidth = chartWidth / (float)ENTRIES_PER_DATASET;  // width of each bar's slot
    float barGap       = barSlotWidth * 0.18;                      // gap between bars

    hoveredEntryIndex = -1;  // reset hover each frame

    for (int entryIndex = 0; entryIndex < ENTRIES_PER_DATASET; entryIndex++) {

      // How tall should this bar be at full animation (0.0 to 1.0)?
      float targetHeightFraction = activeFlightCounts[entryIndex] / (float)highestCountInDataset;

      // Multiply by animationProgress so bars grow from 0 up to their target
      float currentBarHeight = targetHeightFraction * animationProgress * chartHeight;

      float barLeft = chartLeft + entryIndex * barSlotWidth + barGap / 2;
      float barTop  = chartTop + chartHeight - currentBarHeight;  // bars grow upward

      // Check if the mouse is hovering this bar
      boolean mouseIsOverThisBar = animationIsComplete
                                   && mouseX > barLeft
                                   && mouseX < barLeft + barSlotWidth - barGap
                                   && mouseY > barTop
                                   && mouseY < chartTop + chartHeight;
      if (mouseIsOverThisBar) hoveredEntryIndex = entryIndex;


      // Draw the bar itself (white when hovered, coloured otherwise)
      fill(mouseIsOverThisBar ? color(255) : entryColors[entryIndex]);
      rect(barLeft, barTop, barSlotWidth - barGap, currentBarHeight, 4, 4, 0, 0);

      // Show a count label above the bar once it's more than 8% grown
      if (animationProgress > 0.08) {
        int animatedCountLabel = (int)(activeFlightCounts[entryIndex] * animationProgress);
        fill(mouseIsOverThisBar ? color(0) : color(255));
        textSize(10); textAlign(CENTER);
        text(nfc(animatedCountLabel), barLeft + (barSlotWidth - barGap) / 2, barTop - 4);
      }

      // Short code label below the baseline (e.g. "DFW")
      fill(mouseIsOverThisBar ? color(255) : color(200));
      textSize(11); textAlign(CENTER);
      text(activeShortCodes[entryIndex],
           barLeft + (barSlotWidth - barGap) / 2,
           chartTop + chartHeight + 15);

      // Abbreviated full name below the short code (e.g. "Dallas/Fo.")
      fill(mouseIsOverThisBar ? color(220) : color(140));
      textSize(8); textAlign(CENTER);
      String abbreviatedName = activeFullNames[entryIndex].length() > 9
                               ? activeFullNames[entryIndex].substring(0, 9) + "."
                               : activeFullNames[entryIndex];
      text(abbreviatedName, barLeft + (barSlotWidth - barGap) / 2, chartTop + chartHeight + 26);
    }

    // ---- Axis lines (drawn after bars so they sit on top) ----
    stroke(180); strokeWeight(2);
    line(chartLeft, chartTop, chartLeft, chartTop + chartHeight);         // vertical Y axis
    line(chartLeft, chartTop + chartHeight, chartLeft + chartWidth, chartTop + chartHeight); // horizontal X axis

    // ---- Hover tooltip ----
    if (hoveredEntryIndex >= 0) {
      drawHoverTooltip(hoveredEntryIndex, mouseX, mouseY - 30);
    }
  }



  void drawPieChart() {
    int outerRadius = 155;   // outer edge of the ring
    int holeRadius  =  78;   // inner edge — the empty hole in the middle

    // How far around the circle we've drawn so far (0 = nothing, TWO_PI = complete)
    float currentSweepAngle = animationProgress * TWO_PI;

    hoveredEntryIndex = -1;

    // Walk around the circle slice by slice
    float sliceStartAngle = -HALF_PI;  // -HALF_PI puts the start at 12 o'clock
    float totalAngleDrawnSoFar = 0;

    for (int entryIndex = 0; entryIndex < ENTRIES_PER_DATASET; entryIndex++) {

      // This entry's full slice angle = its share of the total * 360 degrees
      float fullSliceAngle = (activeFlightCounts[entryIndex] / totalFlightsInDataset) * TWO_PI;

      // How much of this slice has the sweep hand reached?
      float revealedAngle;
      if (totalAngleDrawnSoFar + fullSliceAngle <= currentSweepAngle) {
        revealedAngle = fullSliceAngle;                          // slice is fully revealed
      } else if (totalAngleDrawnSoFar < currentSweepAngle) {
        revealedAngle = currentSweepAngle - totalAngleDrawnSoFar; // slice is partially revealed
      } else {
        revealedAngle = 0;                                       // slice not reached yet
      }

      if (revealedAngle > 0) {
        boolean mouseIsOverThisSlice = animationIsComplete
                                       && isMouseInsideSlice(sliceStartAngle, fullSliceAngle,
                                                             outerRadius, holeRadius);
        if (mouseIsOverThisSlice) hoveredEntryIndex = entryIndex;

        // Hovered slices pop outward from the centre by 12 pixels
        float popOutDistance = mouseIsOverThisSlice ? 12 : 0;
        float sliceMidAngle  = sliceStartAngle + fullSliceAngle / 2;  // angle to the middle of this slice
        float popX = cos(sliceMidAngle) * popOutDistance;
        float popY = sin(sliceMidAngle) * popOutDistance;


        // Draw the actual slice
        fill(entryColors[entryIndex]);
        stroke(15); strokeWeight(2);
        arc(panelCentreX + popX, panelCentreY + popY,
            outerRadius * 2, outerRadius * 2,
            sliceStartAngle, sliceStartAngle + revealedAngle, PIE);
      }

      totalAngleDrawnSoFar += fullSliceAngle;
      sliceStartAngle      += fullSliceAngle;
    }

    // ---- Draw the donut hole (cover the pie centre with a dark circle) ----
    fill(15, 15, 30); noStroke();
    ellipse(panelCentreX, panelCentreY, holeRadius * 2, holeRadius * 2);

    // ---- Centre hole label ----
    if (animationIsComplete) {
      if (hoveredEntryIndex >= 0) {
        // Show the hovered entry's details inside the hole
        float hoverPercent = (activeFlightCounts[hoveredEntryIndex] / totalFlightsInDataset) * 100;
        fill(255); textAlign(CENTER, CENTER); textSize(18);
        text(activeShortCodes[hoveredEntryIndex], panelCentreX, panelCentreY - 14);
        textSize(13);
        text(nf(hoverPercent, 1, 1) + "%", panelCentreX, panelCentreY + 6);
        fill(170); textSize(9);
        text(nfc(activeFlightCounts[hoveredEntryIndex]) + " flights",
             panelCentreX, panelCentreY + 22);
      } else {
        // No hover — prompt the user to hover over a slice
        fill(170); textAlign(CENTER, CENTER); textSize(10);
        text("HOVER A SLICE", panelCentreX, panelCentreY - 6);
        text("FOR DETAILS",   panelCentreX, panelCentreY + 8);
      }
    } else {
      fill(170); textAlign(CENTER, CENTER); textSize(12);
      text("Loading...", panelCentreX, panelCentreY);
    }

    // ---- Legend on the right side of the donut ----
    int legendLeftX   = panelCentreX + outerRadius + 22;
    int legendStartY  = panelCentreY - (ENTRIES_PER_DATASET * 20) / 2;
    int legendRowHeight = 21;

    for (int entryIndex = 0; entryIndex < ENTRIES_PER_DATASET; entryIndex++) {
      boolean isThisEntryHovered = (entryIndex == hoveredEntryIndex) && animationIsComplete;
      float   entryPercent       = (activeFlightCounts[entryIndex] / totalFlightsInDataset) * 100;
      int     legendRowY         = legendStartY + entryIndex * legendRowHeight;

      // Colour swatch square — white when hovered
      fill(isThisEntryHovered ? color(255) : entryColors[entryIndex]);
      noStroke();
      rect(legendLeftX, legendRowY, 13, 13, 3);

      // Text label: short code + percentage
      fill(isThisEntryHovered ? color(255) : color(185));
      textAlign(LEFT, TOP);
      textSize(isThisEntryHovered ? 11 : 9);
      text(activeShortCodes[entryIndex] + "  " + nf(entryPercent, 1, 1) + "%",
           legendLeftX + 17, legendRowY);
    }
  }



  void drawBubbleChart() {

    // Calculate the target radius for each bubble (proportional to flight count)
    float largestBubbleRadius  = 78;
    float smallestBubbleRadius = 28;
    float[] targetBubbleRadius = new float[ENTRIES_PER_DATASET];
    for (int i = 0; i < ENTRIES_PER_DATASET; i++) {
      targetBubbleRadius[i] = map(activeFlightCounts[i],
                                   activeFlightCounts[ENTRIES_PER_DATASET - 1],  // smallest = minR
                                   activeFlightCounts[0],                         // largest  = maxR
                                   smallestBubbleRadius, largestBubbleRadius);
    }

    // Calculate where each bubble should come to rest
    // Entry 0 (biggest) goes in the centre; entries 1-9 spread in a ring around it
    float[] targetX = new float[ENTRIES_PER_DATASET];
    float[] targetY = new float[ENTRIES_PER_DATASET];
    targetX[0] = panelCentreX;
    targetY[0] = panelCentreY;
    float ringRadius = targetBubbleRadius[0] + targetBubbleRadius[1] + 8;
    for (int i = 1; i < ENTRIES_PER_DATASET; i++) {
      float ringAngle = TWO_PI * (i - 1) / (ENTRIES_PER_DATASET - 1);
      targetX[i] = panelCentreX + cos(ringAngle) * ringRadius;
      targetY[i] = panelCentreY + sin(ringAngle) * ringRadius;
    }

    hoveredEntryIndex = -1;

    // ---- Apply spring physics each frame while animating ----
    // Each bubble is pulled toward its target position with a spring force,
    // then slowed by damping so it settles without overshooting forever.
    if (animationIsRunning) {
      float springStrength = 0.07;  // how strongly each bubble is pulled toward its target
      float dampingFactor  = 0.74;  // how much velocity is lost each frame (friction)
      for (int i = 0; i < ENTRIES_PER_DATASET; i++) {
        float forceX = (targetX[i] - bubbleCurrentX[i]) * springStrength;
        float forceY = (targetY[i] - bubbleCurrentY[i]) * springStrength;
        bubbleVelocityX[i] = (bubbleVelocityX[i] + forceX) * dampingFactor;
        bubbleVelocityY[i] = (bubbleVelocityY[i] + forceY) * dampingFactor;
        bubbleCurrentX[i] += bubbleVelocityX[i];
        bubbleCurrentY[i] += bubbleVelocityY[i];
      }
    } else {
      // Animation finished — snap every bubble exactly to its target
      for (int i = 0; i < ENTRIES_PER_DATASET; i++) {
        bubbleCurrentX[i] = targetX[i];
        bubbleCurrentY[i] = targetY[i];
      }
    }

    // ---- Draw bubbles from back to front (largest first so small sit on top) ----
    for (int i = ENTRIES_PER_DATASET - 1; i >= 0; i--) {
      float drawnRadius = targetBubbleRadius[i] * animationProgress; // grow with animation

      boolean mouseIsOverThisBubble = animationIsComplete
                                      && dist(mouseX, mouseY,
                                              bubbleCurrentX[i], bubbleCurrentY[i])
                                         < targetBubbleRadius[i];
      if (mouseIsOverThisBubble) hoveredEntryIndex = i;


      // Main bubble circle
      fill(entryColors[i]);
      stroke(mouseIsOverThisBubble ? color(255) : color(20));
      strokeWeight(mouseIsOverThisBubble ? 3 : 1);
      ellipse(bubbleCurrentX[i], bubbleCurrentY[i], drawnRadius * 2, drawnRadius * 2);

      // Text inside the bubble (only once the bubble is large enough to fit text)
      if (drawnRadius > 22) {
        // Semi-transparent pill shape behind the text for readability
        fill(0, 0, 0, 150); noStroke();
        ellipse(bubbleCurrentX[i], bubbleCurrentY[i], drawnRadius * 1.15, drawnRadius * 0.65);

        fill(255); textAlign(CENTER, CENTER);
        textSize(mouseIsOverThisBubble ? 13 : 11);
        text(activeShortCodes[i], bubbleCurrentX[i], bubbleCurrentY[i] - 5);

        fill(220); textSize(8);
        text(nfc(activeFlightCounts[i]), bubbleCurrentX[i], bubbleCurrentY[i] + 7);
      }
    }

    // ---- Hover tooltip ----
    if (hoveredEntryIndex >= 0) {
      drawHoverTooltip(hoveredEntryIndex, mouseX, mouseY - 30);
    }
  }



  void drawHoverTooltip(int entryIndex, float tipX, float tipY) {
    float entryPercent = (activeFlightCounts[entryIndex] / totalFlightsInDataset) * 100;

    // Prevent the tooltip from going off the right or top edges of the panel
    if (tipX + 165 > PANEL_RIGHT)  tipX = tipX - 170;
    if (tipY - 60  < PANEL_TOP)    tipY = tipY + 70;

    // Tooltip background box
    fill(20, 20, 45, 225); noStroke();
    rect(tipX, tipY - 55, 162, 58, 6);

    // Coloured header strip at the top of the tooltip box
    fill(entryColors[entryIndex]); noStroke();
    rect(tipX, tipY - 55, 162, 14, 6, 6, 0, 0);

    // Header text: short code — full name
    fill(255); textAlign(LEFT, TOP); textSize(11);
    text(activeShortCodes[entryIndex] + " — " + activeFullNames[entryIndex],
         tipX + 6, tipY - 52);

    // Body: count and share percentage
    fill(200); textSize(10); textAlign(LEFT);
    text("Count:  " + nfc(activeFlightCounts[entryIndex]), tipX + 6, tipY - 26);
    text("Share:  " + nf(entryPercent, 1, 1) + "%",        tipX + 6, tipY - 10);
  }



  boolean isMouseInsideSlice(float sliceStartAngle, float sliceFullAngle,
                               int outerRadius, int holeRadius) {
    float dx = mouseX - panelCentreX;
    float dy = mouseY - panelCentreY;
    float distanceFromCentre = sqrt(dx * dx + dy * dy);

    // Must be in the ring — not inside the hole, not outside the outer edge
    if (distanceFromCentre < holeRadius || distanceFromCentre > outerRadius) return false;

    // atan2 returns the angle in range -PI to PI (0 = 3 o'clock)
    // Adding HALF_PI rotates so 0 = 12 o'clock, matching how slices were drawn
    float mouseAngle = atan2(dy, dx) + HALF_PI;

    // Wrap into 0..TWO_PI range
    if (mouseAngle < 0)       mouseAngle += TWO_PI;
    if (mouseAngle > TWO_PI)  mouseAngle -= TWO_PI;

    // Convert slice bounds into the same 0..TWO_PI coordinate space
    float sliceStart = sliceStartAngle + HALF_PI;
    float sliceEnd   = sliceStart + sliceFullAngle;
    while (sliceStart < 0)      sliceStart += TWO_PI;
    while (sliceStart > TWO_PI) sliceStart -= TWO_PI;

    // Handle slices that wrap past TWO_PI back around to 0
    if (sliceEnd > TWO_PI) {
      return mouseAngle >= sliceStart || mouseAngle <= sliceEnd - TWO_PI;
    }
    return mouseAngle >= sliceStart && mouseAngle <= sliceEnd;
  }



  void drawBothSliders() {
    // Draw the dataset slider on the left
    drawVerticalSlider(
      DATASET_SLIDER_CENTRE_X,
      DATASET_SLIDER_TOP_Y,
      DATASET_SLIDER_BOTTOM_Y,
      TOTAL_DATASETS,
      selectedDatasetIndex,
      datasetTitleLabels,
      datasetThumbY
    );

    // Draw the chart type slider on the right
    drawVerticalSlider(
      CHARTTYPE_SLIDER_CENTRE_X,
      CHARTTYPE_SLIDER_TOP_Y,
      CHARTTYPE_SLIDER_BOTTOM_Y,
      TOTAL_CHART_TYPES,
      selectedChartTypeIndex,
      chartTypeLabels,
      chartTypeThumbY
    );
  }


  void drawVerticalSlider(int centreX, int trackTopY, int trackBottomY,
                           int totalNotches, int activeIndex, String[] optionLabels,
                           int thumbY) {
    int trackHeight = trackBottomY - trackTopY;

    // ---- Track background (full height, grey) ----
    fill(50); noStroke();
    rect(centreX - SLIDER_TRACK_WIDTH / 2, trackTopY,
         SLIDER_TRACK_WIDTH, trackHeight, SLIDER_TRACK_WIDTH / 2);

    // ---- Active fill (from top down to the thumb, blue) ----
    // This shows visually how far down the slider is set
    fill(0, 140, 210);
    rect(centreX - SLIDER_TRACK_WIDTH / 2, trackTopY,
         SLIDER_TRACK_WIDTH, thumbY - trackTopY, SLIDER_TRACK_WIDTH / 2);

    // ---- Notch dots (one per option, evenly spaced along the track) ----
    for (int notchIndex = 0; notchIndex < totalNotches; notchIndex++) {
      float notchFraction = notchIndex / (float)(totalNotches - 1);
      int   notchY        = (int)(trackTopY + notchFraction * trackHeight);

      // Active notch is bright white; others are dimmer
      fill(notchIndex == activeIndex ? color(255) : color(120));
      noStroke();
      ellipse(centreX, notchY, 7, 7);
    }

    // ---- Thumb circle ----
    fill(255); stroke(180); strokeWeight(1.5);
    ellipse(centreX, thumbY, SLIDER_THUMB_RADIUS * 2, SLIDER_THUMB_RADIUS * 2);


    // ---- Active selection label below the thumb ----
    // Show the short version of the current option label (first word only if long)
    fill(255); textAlign(CENTER); textSize(13);
    String shortLabel = optionLabels[activeIndex]
            .split(" ")[optionLabels[activeIndex].split(" ").length - 1]; // e.g. "AIRLINES" from "TOP 10 AIRLINES"
    text(shortLabel, centreX, thumbY + SLIDER_THUMB_RADIUS + 20);
  }




  // Called once when the mouse button goes down.
  // Checks if the click landed on either thumb and starts dragging if so.
  void handleMousePressed() {
    float distToDatasetThumb  = dist(mouseX, mouseY, DATASET_SLIDER_CENTRE_X,  datasetThumbY);
    float distToChartTypeThumb = dist(mouseX, mouseY, CHARTTYPE_SLIDER_CENTRE_X, chartTypeThumbY);

    if (distToDatasetThumb  < SLIDER_THUMB_RADIUS + 6) datasetSliderBeingDragged  = true;
    if (distToChartTypeThumb < SLIDER_THUMB_RADIUS + 6) chartTypeSliderBeingDragged = true;
  }

  // Called every frame while the mouse button is held and the mouse moves.
  // Moves the active thumb, snaps to the nearest notch, and triggers
  // a dataset or chart type change if the notch has changed.
  void handleMouseDragged() {

    if (datasetSliderBeingDragged) {
      // Clamp the thumb inside the track bounds
      datasetThumbY = constrain(mouseY, DATASET_SLIDER_TOP_Y, DATASET_SLIDER_BOTTOM_Y);

      // Convert the thumb's Y position to the nearest notch index (0 = top, max = bottom)
      float thumbFraction   = (datasetThumbY - DATASET_SLIDER_TOP_Y)
                              / (float)DATASET_SLIDER_TRACK_HEIGHT;
      int   nearestDataset  = round(thumbFraction * (TOTAL_DATASETS - 1));
      nearestDataset        = constrain(nearestDataset, 0, TOTAL_DATASETS - 1);

      // Only reload and reanimate if the index actually changed
      if (nearestDataset != selectedDatasetIndex) {
        switchToDataset(nearestDataset);
        restartAnimation();
      }
    }

    if (chartTypeSliderBeingDragged) {
      chartTypeThumbY = constrain(mouseY, CHARTTYPE_SLIDER_TOP_Y, CHARTTYPE_SLIDER_BOTTOM_Y);

      float thumbFraction    = (chartTypeThumbY - CHARTTYPE_SLIDER_TOP_Y)
                               / (float)CHARTTYPE_SLIDER_TRACK_HEIGHT;
      int   nearestChartType = round(thumbFraction * (TOTAL_CHART_TYPES - 1));
      nearestChartType       = constrain(nearestChartType, 0, TOTAL_CHART_TYPES - 1);

      if (nearestChartType != selectedChartTypeIndex) {
        selectedChartTypeIndex = nearestChartType;
        restartAnimation();
      }
    }
  }

  // Called once when the mouse button is released.
  // Snaps both thumbs exactly to their notch positions and clears drag flags.
  void handleMouseReleased() {
    if (datasetSliderBeingDragged) {
      float notchFraction = selectedDatasetIndex / (float)(TOTAL_DATASETS - 1);
      datasetThumbY       = (int)(DATASET_SLIDER_TOP_Y + notchFraction * DATASET_SLIDER_TRACK_HEIGHT);
      datasetSliderBeingDragged = false;
    }
    if (chartTypeSliderBeingDragged) {
      float notchFraction  = selectedChartTypeIndex / (float)(TOTAL_CHART_TYPES - 1);
      chartTypeThumbY      = (int)(CHARTTYPE_SLIDER_TOP_Y + notchFraction * CHARTTYPE_SLIDER_TRACK_HEIGHT);
      chartTypeSliderBeingDragged = false;
    }
  }

}
