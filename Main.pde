////=====================
////==== Main Screen ====
////=====================

// TODO here: draw guy walking and looking at secondary screen

// Declarations:
import java.util.Set;
import java.util.HashSet;

// For Sreach
Boolean typing = false;
String currentSearchString = "";
Searcher search;
ArrayList<Flight> testFlights;

PFont text;
PFont myFont;
WidgetList widgetList;
boolean showFlights = false;
boolean printedOnce = false;
csvReader cr = new csvReader();
ArrayList<Flight> flights;
Search_Results result;
//Table table;

void setup() {
  size(1500, 850);
  text = loadFont("AlTarikh-24.vlw");
  myFont = createFont("Arial Bold", 20);
  textFont(myFont);
  widgetList = new WidgetList();
  widgetList.add(new Button(250, 150, 120, 45, "PRINT",   color(255, 0, 0), color(0, 150, 0), color(150, 0, 0), 1));
  flights = cr.readCSV("flights2k.csv");
//  // Search Test
  search = new Searcher(flights); //<>//
  testFlights = search.Search("1/1/2022", "", -1, "JFK", "New York, NY", "", -1, "LAX", "", "", -1, -1, -1, -1, -1, false, false, -1); //<>//
  for (Flight i : testFlights) {
    System.out.print(i.flightDateString + " ");
    System.out.print(i.origin + " ");
    System.out.print(i.originCityName + " ");
    System.out.print(i.arrivalTime + " ");
    System.out.println(i.destination);
  } 
  result = new Search_Results(testFlights);
//  // Search test end
}

  void draw(){
  background(0);
  widgetList.display();
  fill(255);

  
  if (showFlights) {
    textFont(text);
    textSize(10);
    textAlign(LEFT);
    
    result.drawDeparture(1);

 }
}
