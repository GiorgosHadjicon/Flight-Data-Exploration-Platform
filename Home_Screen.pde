//=============================
// Home Screen (one off object)
//=============================

// Make a simple creative welcome page beforer we select any other page.
class HomeScreen {
  
    void drawWelcomeScreen() {
      image(homeScreenAnimation, 0, 0, 832, 458);
      println(homeScreenAnimation.width, homeScreenAnimation.height);
    }
  
    // Required callback
    void movieEvent(Movie m) {
      println("frame read"); // debug
      m.read();
    }
  
  void drawMainProgram() { //function to display other events will add the corresponding events when created
    background(0);
    fill(255);
    textSize(30);
    textAlign(CENTER);
  }
  

}
