//====================
// Widget Parent Class (Abstract)
//====================

interface Widget 
{  
  // Abstract methods that child classes MUST implement
  void display();
  boolean contains(int mx, int my);
}
