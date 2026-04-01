////===================== //<>//
////==== Main Screen ====
////=====================

import gifAnimation.*;
import processing.video.*;
import java.util.Set;
import java.util.HashSet;
import processing.sound.*;
import processing.data.Table;
import processing.data.TableRow;
 //<>//
PImage bg;
Gif weather;
Gif add1;
Gif add2;
Movie homeScreenVideo; // Declaring the Movie object
float westLon = -127;
float eastLon = -58;
float northLat = 59;
float southLat = 10;
float mapLeft = 332;
float mapRight = 1166;
float mapTop = 145;
float mapBottom = 608;
HashMap<String, Airport> airportMap = new HashMap<String, Airport>();
Flight selectedFlight = null;
Boolean typing = false;
public boolean searchButtonsCreated = false;
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
public ArrayList<String> date = new ArrayList<String>();      //Array lists of each data block
public ArrayList<String> origins = new ArrayList<String>();
public ArrayList<String> originsCityName = new ArrayList<String>();
public ArrayList<String> destinations = new ArrayList<String>();
public ArrayList<String> destinationsCityName = new ArrayList<String>();
String dateDataBlock = "1/1/2022";
String originDataBlock = "";
String originCityName = "";
String destination = "";
String destinationCityName = "";
int pageNum = 1;
boolean pageChange = false;
SoundFile backgroundMusic;
//Table table;

ChartDashboard chartDash;
boolean showChartDash = false;

// For tutorial
boolean tutorialActive = true;
int tutorialStep = 0; // 0 = highlight flights button, 1 = highlight search bar, 2 = done

void setup() {
  frameRate(120);
  pixelDensity(1);
  usaMap = loadImage("usa_map.jpg");
  mapScreen = new MapScreen(usaMap);
  loadAirports("merged_airports.csv");
  size(1500, 850);
  text = loadFont("AlTarikh-24.vlw");
  myFont = createFont("Arial Bold", 12);
  textFont(myFont);
  flights = cr.readCSV("flights_full.csv");
  
  for (int i = 0; i < flights.size(); i++)
  {
    Flight currentFlight = flights.get(i);
    String displayString = currentFlight.getDate(); // Uses data from string
    temp.add(displayString);
  }
  
  
// WALKING ANIMATIONS
  Walking w1 = new Walking(this, height - 280, "bunbun2loop.gif", "pompomturn.gif");
  w1.resize(120, 280, 480, 265); 
  walkers.add(w1);
  
  Walking w2 = new Walking(this, height - 280, "couplewalkop.gif", "handturn.gif");
  w2.resize(280, 300, 560, 360);
  walkers.add(w2);
  
  Walking w3 = new Walking(this, height - 340, "runnercol.gif", "kidturn.gif");
  w3.resize(380, 400, 680, 460);
  walkers.add(w3);
    
  Walking w4 = new Walking(this, height - 380, "walkerstation.gif", "BlueShirtturn.gif");
  w4.resize(600, 400, 580, 460);
  walkers.add(w4);
  
  
  // Background and gifs
  bg = loadImage("background1.png");
  weather = new Gif(this, "weather.gif");
  weather.loop(); // plays continuously
  add1 = new Gif(this, "addV1.gif");
  add1.loop();
  add2 = new Gif(this, "SatisfatoryGitFinal.gif");
  add2.loop();
  
  backgroundMusic = new SoundFile(this, "AirportSound.wav");
  backgroundMusic.loop();
  
  homeScreenVideo = new Movie(this, "AirPlaneFly.mov"); 
  homeScreenVideo.loop(); 
  homeScreenVideo.volume(0); // <--- THIS MUTES THE VIDEO
  
//  // Search Test
  search = new Searcher(flights); //<>//
  testFlights = search.Search("1/1/2022", "", -1, "", "", "", -1, "", "", "", -1, -1, -1, -1, -1, false, false, -1); //<>//
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
  
  chartDash = new ChartDashboard();
  widgetList.add(new Button(10, 305, 120, 35, "CHARTS",
               color(0,100,200), color(0,160,255), color(0,80,160), EVENT_CHART_DASH));
  
  widgetList.add(new Button(10, 155, 140, 45, "HOMESCREEN",   color(255, 0, 0), color(0, 150, 0), color(150, 0, 0), EVENT_GO_HOME_SCREEN));
  widgetList.add(new Button(10, 205, 140, 45, "FLIGHTS",   color(255, 0, 0), color(0, 150, 0), color(150, 0, 0), EVENT_PRINT_SCREEN));

}
  void movieEvent(Movie m) {
  m.read();
}

  void draw(){
    //print(isDropDownSearchExpanded); //<>//
      // Fraw Background and gifs
      image(bg, 0, 0);
      image(weather, 0, 0);
      image(add1, 1044, 179);
      image(add2, 1075, 515);
      fill(0);
      rect(332, 145, 834, 463);
      
      pushStyle();
      widgetList.displayWidgets();
      popStyle();
      
     if (showWelcome) {
       homeScreen.drawWelcomeScreen();

     }

        
     if (showFlights) { 
       result.drawDeparture(pageNum);
     }

     if (showMap) {
       mapScreen.drawMap();
     }
     
     
     if (showChartDash) {
      chartDash.draw();
    }
    


    
     for (Walking w : walkers) {
       w.update();
       w.display();
     }
     
     if (tutorialActive) {
     drawTutorialOverlay();
}
   }
   
