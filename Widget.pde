//=========================
//== Widget Parent Class ==
//=========================
// AUTHORSHIP: Odysseas Leonidou

interface Widget 
{  
  // Abstract methods that child classes MUST implement
  void display();
  boolean contains(int mx, int my);
}
