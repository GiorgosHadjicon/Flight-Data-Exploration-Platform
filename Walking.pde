// AUTHORSHIP: Teressa Domingos, Giorgos Hadjiconstantis 

class Walking {
  Gif walkIn, action, walkOut; 
  float x, y;                 
  float targetX;              
  float speed = 8;            
  int state = 0;              // 0: Off-screen, 1: Walking In, 2: Action, 3: Walking Out
  
  float walkW = 150;          // Default walk width
  float walkH = 200;          // Default walk height
  float actionW = 150;        // Default action width
  float actionH = 200;        // Default action height
  
  long lastClickTime = -500;  // Stores time of last click for double-click detection

  Walking(PApplet p, float ypos, String walkFile, String actionFile) {
    // Initialize GIFs
    walkIn = new Gif(p, walkFile);
    action = new Gif(p, actionFile); 
    action.ignoreRepeat();    // makes sure that the action GIF only plays once when clicked
    walkOut = new Gif(p, walkFile); 
    
    // Start looping for movement animations
    walkIn.loop();
    walkOut.loop();
    
    reset();                  // Put character in starting position
    y = ypos;
  }
  
  // Adjust the character's display size for both walk and action phases
  void resize(float newWalkW, float newWalkH, float newActionW, float newActionH) {
    walkW = newWalkW;
    walkH = newWalkH;
    actionW = newActionW;
    actionH = newActionH;
  }

  // Resets character to the left, off-screen
  void reset() {
    x = -400; 
    targetX = x;
    state = 0; 
  }

  void handleClick() {
    long currentTime = millis(); // current time in milliseconds
    
    // Double-click Logic: If clicked twice, reset the character
    if (currentTime - lastClickTime < 500) {
      reset();
      lastClickTime = 0;
      return; 
    } 
    
    if (state == 0) {
      // If off-screen, move to center of the canvas
      targetX = width/2 - (walkW/2); 
      state = 1;
    } else if (state == 2) {
      // If performing action in center, move to the right off-screen
      targetX = width + 400;
      state = 3;
    }
    
    lastClickTime = currentTime; // Update click timer
  }

  void update() {
    // 1. Movement logic (Keep this as is)
    if (abs(x - targetX) > speed) {
      x += (x < targetX) ? speed : -speed;
    } 
    else if (state == 1) {
      action.jump(0); 
      action.play();  
      state = 2; 
    }

    // 2. THE FIX: Increase GIF playback speed manually
    if (state == 2) {
      // If the GIF is playing, we "skip" ahead slightly each frame
      // This effectively multiplies the playback speed.
      if (action.isPlaying()) {
        int currentFrame = action.currentFrame();
        // You can increase this number to make it even faster
        action.jump(currentFrame + 2); 
      }
    }
    
    // Once the character is completely off the right side, reset its state
    if (state == 3 && x > width + 50) {
      reset();
    }
  }

  void display() {
    // Only render if the character is active (state > 0)
    if (state > 0) {
      if (state == 1) {
        image(walkIn, x, y, walkW, walkH);
      } 
      else if (state == 2) {
        // Calculate difference in height so the action GIF stays grounded
        float yOffset = walkH - actionH; 
        
        // If the action is wider/narrower, you might also want to center it:
        float xOffset = (walkW - actionW) / 2;
        
        image(action, x + xOffset, y + yOffset, actionW, actionH);
      }
      else if (state == 3) {
        image(walkOut, x, y, walkW, walkH);
      }
    }
  }
}
