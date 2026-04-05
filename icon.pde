class icons extends Button {
  PImage img;
  
  // Removed redundant drawX, drawY, drawW, drawH variables.
  // We will just use the x, y, w, h inherited from Button.

  icons(int x, int y, int w, int h, String label, PImage img, int event) {
    // Pass everything directly to the parent Button constructor
    super(x, y, w, h, label, color(0), color(0), color(0), event);
    this.img = img;
  }

  void display() {
    pushStyle();
    
    // CRITICAL FIX: Ensure images are drawn from the top-left corner
    // so the visual lines up perfectly with the contains() math.
    imageMode(CORNER); 

    if (img != null) {
      if (contains(mouseX, mouseY)) {
        tint(180); // hover effect
      } else {
        noTint();
      }

      // x, y, w, h are automatically available from the Button class
      image(img, x, y, w, h); 
    }

    popStyle();
  }
}
