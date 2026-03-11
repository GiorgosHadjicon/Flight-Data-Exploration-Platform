//=====================
//==== Main Screen ====
//=====================

//(keep variable declarations in setting up)

// draw guy walking and looking at secondary screen

PFont zigBlack;
csvReader cr;
ArrayList<Flight> flights;
//Table table;

void setup() {
  size(600, 400);
  zigBlack = createFont("Ziggurat-Black", 24);
  
 // 1. Load the excel/csv file (ensure "flights.csv" is in your data folder)
//Table table = loadTable(filename, "header");


}


  void draw(){
  background(0);
  textFont(zigBlack);
  textSize(10);
  fill(255);
  line(50, 0, 50, height);
  textAlign(LEFT);
  flights = cr.readCSV("flights2k.csv");

  //For loop to print 5 sets of data using the string getData() 
  // We limit the loop to 5 items
  for (int i = 0; i < 5 && i < flights.size(); i++) {
    Flight currentFlight = flights.get(i);
    String displayString = currentFlight.getData(); // Uses data from string
    
    float yPos = 40 + (i * 30); // Spacing each line 30 pixels apart
    text(displayString, 60, yPos);
    
    // This sends the text to the Terminal
    System.out.println(displayString);
  }
}
