//===============================
//====== Tutorial Function ======
//===============================
// AUTHORSHIP: Giorgos Zambas

void drawTutorialOverlay() {
  pushStyle(); // to protect global styles

  // Dark overlay
  fill(0, 180);
  noStroke();

  float pulse = 2 + 4 * sin(frameCount * 0.07);

  if (tutorialStep == 0) {
    // FLIGHTS BUTTON COORDINATES
    int x = 12;
    int y = 300;
    int w = 145;
    int h = 150;

    // Darken everything except button
    rect(0, 0, width, y);
    rect(0, y + h, width, height - (y + h));
    rect(0, y, x, h);
    rect(x + w, y, width - (x + w), h);

    // Pulsing highlight
    stroke(255, 255, 0);
    strokeWeight(3);
    noFill();
    rect(x - pulse, y - pulse, w + pulse * 2, h + pulse * 2, 10);
  }

  else if (tutorialStep == 1) {
    // SEARCH BAR COORDINATES
    int x = 335;
    int y = 165;
    int w = 665;
    int h = 50;

    int padding = 5;

    // Darken everything except search bar
    rect(0, 0, width, y - padding);
    rect(0, y + h + padding, width, height - (y + h + padding));
    rect(0, y - padding, x - padding, h + padding * 2);
    rect(x + w + padding, y - padding, width - (x + w + padding), h + padding * 2);

    // Pulsing highlight
    stroke(255, 255, 0);
    strokeWeight(3);
    noFill();
    rect(
      x - padding - pulse,
      y - padding - pulse,
      w + (padding * 2) + pulse * 2,
      h + (padding * 2) + pulse * 2,
      10
    );
  }

  // For the tutorual text on both screens
  fill(255);
  textAlign(CENTER);
  textSize(40);

  if (tutorialStep == 0) {
    text("Click to view flights", width/3, height/3 - 50);
  } 
  else if (tutorialStep == 1) {
    text("Now use the search bar", width/2, height/2);
  }

  popStyle();
}
