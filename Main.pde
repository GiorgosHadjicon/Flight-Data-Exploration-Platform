////===================== //<>// //<>//
////==== Main Screen ====
////=====================

// TODO here: draw guy walking and looking at secondary screen

// draw guy walking and looking at secondary screen
import gifAnimation.*;
// Declarations:
import java.util.Set;
import java.util.HashSet;

// For Sreach //<>//
//background and gifs
PImage bg;
Gif tickerScreen;

Boolean typing = false;
String currentSearchString = "";
Searcher search;
ArrayList<Flight> testFlights;
public boolean showWelcome = true;
PFont text;
PFont myFont;
WidgetList widgetList;
boolean showFlights = false;
boolean printedOnce = false;
boolean showMap = false;
csvReader cr = new csvReader();
ArrayList<Flight> flights;
public ArrayList<Walking> walkers = new ArrayList<Walking>();
ArrayList<String> temp = new ArrayList<String>();
public ArrayList<dropDownSearch> widgetsSearch = new ArrayList<dropDownSearch>();
Search_Results result; //<>//
HomeScreen homeScreen = new HomeScreen();
PImage usaMap;
MapScreen mapScreen;
public boolean isDropDownSearchExpanded = false; 
//Table table;


void setup() {
  frameRate(120);
  usaMap = loadImage("usa_map.jpg");
  mapScreen = new MapScreen(usaMap);
  size(1500, 850);
  text = loadFont("AlTarikh-24.vlw");
  myFont = createFont("Arial Bold", 20);
  textFont(myFont);
  widgetList = new WidgetList();
  widgetList.add(new Button(360, 45, 120, 45, "PRINT",   color(255, 0, 0), color(0, 150, 0), color(150, 0, 0), 1)); // 820
  widgetList.add(new Button(490, 45, 120, 45, "PRINTMAP",   color(255, 0, 0), color(0, 150, 0), color(150, 0, 0), 3));
  widgetList.addDrop(new dropDownSearch(10, 55, 60, 30, "SEARCH", color(255, 0, 0), color(0, 150, 0), temp)); 
  widgetList.addDrop(new dropDownSearch(80, 55, 60, 30, "SEARCH", color(255, 0, 0), color(0, 150, 0), temp)); 
  widgetList.addDrop(new dropDownSearch(150, 55, 60, 30, "SEARCH", color(255, 0, 0), color(0, 150, 0), temp)); 
  widgetList.addDrop(new dropDownSearch(220, 55, 60, 30, "SEARCH", color(255, 0, 0), color(0, 150, 0), temp)); 
  widgetList.addDrop(new dropDownSearch(290, 55, 60, 30, "SEARCH", color(255, 0, 0), color(0, 150, 0), temp)); 
  flights = cr.readCSV("flights2k.csv");
  for (int i = 0; i < flights.size(); i++)
  {
    Flight currentFlight = flights.get(i);
    String displayString = currentFlight.getDate(); // Uses data from string
    temp.add(displayString);
  }
// WALKING ANIMATIONS
  Walking w1 = new Walking(this, height - 225, "BlueShirtwalk.gif", "guyLook.gif");
  w1.resize(300, 300);
  walkers.add(w1);
  
  Walking w2 = new Walking(this, height - 220, "guyRun.gif", "guyTurn.gif");
  w2.resize(300, 300);
  walkers.add(w2);
  
  Walking w3 = new Walking(this, height - 150, "girlWalk.gif", "girlTurn.gif");
  w3.resize(200, 200);
  walkers.add(w3);
  
  Walking w4 = new Walking(this, height - 220, "ggWalk.gif", "ggTurn.gif");
  w4.resize(300, 300);
  walkers.add(w4);
  
  // Background and gifs
  bg = loadImage("background1.png");
  tickerScreen = new Gif(this, "gifscreen.gif");
  tickerScreen.loop(); // plays continuously
  
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
    if (showWelcome) {
      homeScreen.drawWelcomeScreen(); //<>//
     }
    else {
      // Fraw Background and gifs
      image(bg, 0, 0);
      image(tickerScreen, 640, 10, 780, 110);
      fill(0);
      rect(332, 145, 834, 463);
  
      if (showFlights) {
        textFont(text);
        textSize(10);
        textAlign(LEFT);
        
        result.drawDeparture(1);
      }
      else if (showMap) {
        mapScreen.drawMap();
      }
      
      pushStyle();
      widgetList.displayWidgets();
      popStyle();
      
      for (Walking w : walkers) {
        w.update();
        w.display();
      }
     }
     


}
