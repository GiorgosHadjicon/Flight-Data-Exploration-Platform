class Walking {
  Gif walkIn, action, walkOut;
  float x, y;
  float targetX;
  float speed = 3;
  int state = 0; // 0: Start, 1: Middle, 2: Action, 3: Leaving
  
  // FIXED: Added width and height variables
  float w = 150; 
  float h = 200;
  
  // FIXED: Set to -500 to prevent a double-click trigger right when the app starts
  long lastClickTime = -500;

  Walking(PApplet p, float ypos, String walkFile, String actionFile) {
    walkIn = new Gif(p, walkFile);
    action = new Gif(p, actionFile); 
    action.ignoreRepeat();
    walkOut = new Gif(p, walkFile); 
    
    walkIn.loop();
    walkOut.loop();
    
    reset();
    y = ypos;
  }
  
  // FIXED: Added the missing resize method!
  void resize(float newWidth, float newHeight) {
    w = newWidth;
    h = newHeight;
  }

 void reset() {
    x = -300; // Keep them well off-screen
    targetX = x;
    state = 0; // State 0 now means "Waiting to be summoned"
  }

  void handleClick() {
    long currentTime = millis();
    
    if (currentTime - lastClickTime < 500) {
      reset();
      lastClickTime = 0;
      return; 
    } 
    
    if (state == 0) {
      targetX = width/2 - 50;
      state = 1;
    } else if (state == 1) {
      action.jump(0); 
      action.play();  
      state = 2;
    } else if (state == 2) {
      targetX = width + 150;
      state = 3;
    }
    
    lastClickTime = currentTime;
  }

  void update() {
    if (abs(x - targetX) > speed) {
      x += (x < targetX) ? speed : -speed;
    }
  }

  void display() {
    // Only draw if the state is NOT 0
    if (state > 0) {
      if (state == 1) {
        image(walkIn, x, y, w, h);
      } 
      else if (state == 2) {
        image(action, x, y, w, h);
      }
      else if (state == 3) {
        image(walkOut, x, y, w, h);
      }
      
      // Optional: Auto-reset if they walk off the right side of the screen
      if (state == 3 && x > width + 100) {
        reset();
      }
    }
  }
}
