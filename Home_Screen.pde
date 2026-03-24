//=============================
// Home Screen (one off object)
//=============================

// Make a simple creative welcome page beforer we select any other page.
class HomeScreen {
  PFont pickedFont;
  
  
  void drawWelcomeScreen() {
    pushStyle();
    fill (30, 40, 60);
    rect(332, 145, 834, 463);
    fill(255);
    textAlign(CENTER);
    textSize(30);
    text("WELCOME TO AVIATION CENTRAL", width/2, 250);
    textSize(15);
    text("Press any mousekey to continue", width/2, 300);
    popStyle();
  }
  
  void drawMainProgram() { //function to display other events will add the corresponding events when created
    background(0);
    fill(255);
    textSize(30);
    textAlign(CENTER);
  }
  

}
