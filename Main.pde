////===================== //<>// //<>//
////==== Main Screen ====
////=====================

// TODO here: draw guy walking and looking at secondary screen

// draw guy walking and looking at secondary screen
import gifAnimation.*;
// Declarations:
import java.util.Set;
import java.util.HashSet;
import processing.data.Table;
import processing.data.TableRow;

// For Sreach //<>//
//background and gifs
PImage bg;
Gif tickerScreen;
Gif add1;
Gif add2;
float westLon = -124.8;
float eastLon = -66.9;
float northLat = 49.3;
float southLat = 24.5;
float mapLeft = 0;
float mapRight = 0;
float mapTop = 0;
float mapBottom = 0;
HashMap<String, Airport> airportMap = new HashMap<String, Airport>();
Flight selectedFlight = null;
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
boolean showFrequencyGraph = false;
csvReader cr = new csvReader();
ArrayList<Flight> flights;
public ArrayList<Walking> walkers = new ArrayList<Walking>();
ArrayList<String> temp = new ArrayList<String>();
public ArrayList<dropDownSearch> widgetsSearch = new ArrayList<dropDownSearch>();
Search_Results result; //<>//
HomeScreen homeScreen = new HomeScreen();
PImage usaMap;
MapScreen mapScreen;
PImage topOrigins;
GraphsScreen graphsScreen;
public boolean isDropDownSearchExpanded = false; 
ArrayList<String> date = new ArrayList<String>();      //Array lists of each data block
ArrayList<String> origins = new ArrayList<String>();
ArrayList<String> originsCityName = new ArrayList<String>();
ArrayList<String> destinations = new ArrayList<String>();
ArrayList<String> destinationsCityName = new ArrayList<String>();
String dateDataBlock = "1/1/2022";
String originDataBlock = "";
String originCityName = "";
String destination = "";
String destinationCityName = "";
int pageNum = 1;
boolean pageChange = false;
//Table table;


void setup() {
  frameRate(120);
  pixelDensity(1);
  usaMap = loadImage("usa_map.jpg");
  topOrigins = loadImage("flights_top_origins.png");
  mapScreen = new MapScreen(usaMap);
  loadAirports("merged_airports.csv");
  graphsScreen = new GraphsScreen(topOrigins);
  size(1500, 850);
  calibrateMap();
  text = loadFont("AlTarikh-24.vlw");
  myFont = createFont("Arial Bold", 15);
  textFont(myFont);
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
  add1 = new Gif(this, "addV1.gif");
  add1.loop();
  add2 = new Gif(this, "SatisfatoryGitFinal.gif");
  add2.loop();
  
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

//  //creating ArrayLists for each data block
  date = search.GetDates();
  origins = search.GetOrigins();
  originsCityName = search.GetOriginCityNames();
  destinations = search.GetDestinations();
  destinationsCityName = search.GetDestinationCityNames();
  
  widgetList = new WidgetList();
  widgetList.add(new Button(360, 45, 120, 45, "PRINTMAP",   color(255, 0, 0), color(0, 150, 0), color(150, 0, 0), SHOW_MAP));
  widgetList.add(new Button(10, 205, 140, 45, "TOP ORIGINS",   color(255, 0, 0), color(0, 150, 0), color(150, 0, 0), EVENT_FREQUENCY_GRAPH));
  widgetList.add(new Button(10, 105, 140, 45, "RESET DROPDOWN",   color(255, 0, 0), color(0, 150, 0), color(150, 0, 0), EVENT_RESET_DROP_DOWN));
  widgetList.addDrop(new dropDownSearch(10, 55, 60, 30, "DATE", color(255, 0, 0), color(0, 150, 0), date, "date")); 
  widgetList.addDrop(new dropDownSearch(80, 55, 60, 30, "ORIGIN", color(255, 0, 0), color(0, 150, 0), origins, "origins")); 
  widgetList.addDrop(new dropDownSearch(150, 55, 60, 30, "ORIGIN\n CITY", color(255, 0, 0), color(0, 150, 0), originsCityName, "originsCityName")); 
  widgetList.addDrop(new dropDownSearch(220, 55, 60, 30, "DESTIN", color(255, 0, 0), color(0, 150, 0), destinations, "destinations")); 
  widgetList.addDrop(new dropDownSearch(290, 55, 60, 30, "DESTIN\n CITY", color(255, 0, 0), color(0, 150, 0), destinationsCityName, "destinationsCityName")); 
}

  void draw(){
    //print(isDropDownSearchExpanded); //<>//
      // Fraw Background and gifs
      image(bg, 0, 0);
      image(tickerScreen, 640, 10, 780, 110);
      image(add1, 1044, 179);
      image(add2, 1075, 515);
      fill(0);
      rect(332, 145, 834, 463);
      
     if (showWelcome) {
       homeScreen.drawWelcomeScreen();
       pushStyle();
       widgetList.displayWidgets();
       popStyle();
     }
     else {
       
        textFont(text);
        textSize(10);
        textAlign(LEFT);
        
        result.drawDeparture(pageNum);
        
      if (showMap) {
        mapScreen.drawMap();
      }
      
      if (showFrequencyGraph) {
        graphsScreen.drawTopOrigins();
      }
      
      
      for (Walking w : walkers) {
        w.update();
        w.display();
      }
     }


}
