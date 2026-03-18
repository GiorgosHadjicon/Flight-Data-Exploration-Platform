//=============================
// Home Screen (one off object)
//=============================

// Make a simple creative welcome page beforer we select any other page.
PFont pickedFont;
boolean showWelcome = true;

void setup() {
  size (800, 600);
  pickedFont = createFont("Verdana Italic", 90);
  textFont(pickedFont);
}

void draw() { //initially draw once
  if (showWelcome) {
    drawWelcomeScreen();
} else {
  drawOtherEvents();
}
}

void drawWelcomeScreen() {
  background(30, 40, 60);
  fill(255);
  textAlign(CENTER);
  textSize(30);
  text("WELCOME TO AVIATION CENTRAL", width/2, 250);
  textSize(15);
  text("where questions provide results", width/2, 300);
}

void drawMainProgram() { //function to display other events will add the corresponding events when created
  background(0);
  fill(255);
  textSize(30);
  textAlign(CENTER);
}

void mousePressed(){
  showWelcome = false; // boolean to change welcome screen 
}

  
