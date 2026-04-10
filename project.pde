import processing.sound.*;

PImage backgroundImage;
PImage weeklyChartImage;
PImage emissionsBackgroundImage;

boolean flightsMenuHover   = false;
boolean faqMenuHover       = false;
boolean emissionsMenuHover = false;

SoundFile jazzMusic;
boolean jazzMusicPlaying = false;

SoundFile gameAudioSound;
boolean gameAudioPlaying = false;

SoundFile clickSoundEffect;

ArrayList<Flight> myFlights;
int scrollYPosition = 0;

String currentPage = "home";

PieChart pieChart;
LineChart lineChart;
EmissionsChart emissionsChart;
BarChart barChart;
Game game;
WeeklyChart weeklyChart;

Screen currentScreen;
Screen queryScreen;
Screen screenOne;
Screen screenTwo;
Screen screenThree;
Screen screenFour;
Screen screenFive;
Screen screenSix;

void setup() {
  size(1200, 800);
  pixelDensity(1);

  jazzMusic        = new SoundFile(this, "jazz.mp3");
  gameAudioSound   = new SoundFile(this, "gameAudio.mp3");
  clickSoundEffect = new SoundFile(this, "clickSound.wav");

  backgroundImage           = loadImage("airhostessImage.jpg");
  weeklyChartImage          = loadImage("GRAPHHHHHHHHHHH.png");
  emissionsBackgroundImage  = loadImage("emissionsInfo.png");

  myFlights = new ArrayList<Flight>();
  loadFlights("flights2k.csv");

  String[] airlineNames = { "AS", "WN", "B6", "HA", "GA" };
  int[] cancelCounts    = { 93, 58, 33, 14, 11 };
  color[] sliceColors   = {
    color(255, 180, 180),
    color(230, 230, 230),
    color(255, 210, 210),
    color(210, 210, 210),
    color(255, 195, 195)
  };

  pieChart       = new PieChart(700, height / 2, 400, airlineNames, cancelCounts, sliceColors);
  lineChart      = new LineChart("top10departure.csv", "Hour", "Count");
  emissionsChart = new EmissionsChart();
  barChart       = new BarChart("top10.csv", "City", "Appearances");
  weeklyChart    = new WeeklyChart();
  game           = new Game();
  game.gameSetup();

  queryScreen = new Screen(color(255));

  Widget buttonGoToScreenOne   = new Widget(150, 170, 900, 60, "What are the airlines with the most cancelations?", color(230, 230, 230));
  Widget buttonGoToScreenTwo   = new Widget(150, 245, 900, 60, "What is the weekly flight activity?",               color(230, 230, 230));
  Widget buttonGoToScreenThree = new Widget(150, 320, 900, 60, "What are my flight emissions?",                     color(230, 230, 230));
  Widget buttonGoToScreenFour  = new Widget(150, 395, 900, 60, "How can I entertain my kids?",                      color(230, 230, 230));
  Widget buttonGoToScreenFive  = new Widget(150, 470, 900, 60, "What is the most popular departure time?",          color(230, 230, 230));
  Widget buttonGoToScreenSix   = new Widget(150, 545, 900, 60, "What are the most popular destinations?",           color(230, 230, 230));
  Widget homeButtonOnQuery     = new Widget(10,  10,  100, 40, "Home",                                              color(230, 230, 230));

  queryScreen.addWidget(buttonGoToScreenOne);
  queryScreen.addWidget(buttonGoToScreenTwo);
  queryScreen.addWidget(buttonGoToScreenThree);
  queryScreen.addWidget(buttonGoToScreenFour);
  queryScreen.addWidget(buttonGoToScreenFive);
  queryScreen.addWidget(buttonGoToScreenSix);
  queryScreen.addWidget(homeButtonOnQuery);

  screenOne = new Screen(color(255));
  Widget backButtonOnScreenOne = new Widget(10, 10, 100, 40, "Back", color(230, 230, 230));
  screenOne.addWidget(backButtonOnScreenOne);

  screenTwo = new Screen(color(255));
  Widget backButtonOnScreenTwo = new Widget(10, 10, 100, 40, "Back", color(230, 230, 230));
  screenTwo.addWidget(backButtonOnScreenTwo);

  screenThree = new Screen(color(255));
  Widget backButtonOnScreenThree = new Widget(10, 10, 100, 40, "Back", color(230, 230, 230));
  screenThree.addWidget(backButtonOnScreenThree);

  screenFour = new Screen(color(255));
  Widget backButtonOnScreenFour = new Widget(10, 10, 100, 40, "Back", color(230, 230, 230));
  screenFour.addWidget(backButtonOnScreenFour);

  screenFive = new Screen(color(255));
  Widget backButtonOnScreenFive = new Widget(10, 10, 100, 40, "Back", color(230, 230, 230));
  screenFive.addWidget(backButtonOnScreenFive);

  screenSix = new Screen(color(255));
  Widget backButtonOnScreenSix = new Widget(10, 10, 100, 40, "Back", color(230, 230, 230));
  screenSix.addWidget(backButtonOnScreenSix);

  currentScreen = queryScreen;
}

void draw() {
  if (currentPage.equals("home")) {
    drawHomePage();
  }
  else if (currentPage.equals("flights")) {
    drawFlightsPage();
  }
  else if (currentPage.equals("faq")) {
    drawFAQPage();
  }
  else if (currentPage.equals("emissions")) {
    drawEmissionsPage();
  }
  else if (currentPage.equals("emissionsChart")) {
    drawEmissionsChartPage();
  }
}

void drawHomePage() {
  image(backgroundImage, 0, 0, width, height);

  fill(255);
  textSize(28);
  textAlign(LEFT, CENTER);
  text("FEMirates", 30, 35);

  checkMenuHovers();

  textAlign(CENTER, CENTER);
  textSize(18);

  if (flightsMenuHover == true) {
    fill(255, 150, 200);
  }
  else {
    fill(255);
  }
  text("Flights", width - 350, 35);

  if (faqMenuHover == true) {
    fill(255, 150, 200);
  }
  else {
    fill(255);
  }
  text("FAQ", width - 220, 35);

  if (emissionsMenuHover == true) {
    fill(255, 150, 200);
  }
  else {
    fill(255);
  }
  text("Emissions Data", width - 80, 35);

  fill(255, 105, 180, 120);
  rectMode(CENTER);
  rect(width / 2, height / 2 + 150, 500, 150, 20);

  fill(255);
  textSize(36);
  text("Welcome to FEMirates", width / 2, height / 2 + 130);
  textSize(18);
  text("Your journey begins here", width / 2, height / 2 + 180);

  rectMode(CORNER);
}

void drawFlightsPage() {
  background(255);

  fill(80);
  textSize(14);
  textAlign(LEFT, CENTER);
  text("DATE",        30,  20);
  text("CARRIER",     200, 20);
  text("ORIGIN",      320, 20);
  text("DESTINATION", 550, 20);
  text("DISTANCE",    750, 20);
  text("STATUS",      900, 20);
  line(20, 32, width - 20, 32);

  int yPosition = 50 - scrollYPosition;

  for (int i = 0; i < myFlights.size(); i++) {
    Flight currentFlight = myFlights.get(i);

    if (yPosition > 35 && yPosition < height) {
      if (currentFlight.cancel.equals("1")) {
        fill(200, 0, 0);
      }
      else {
        fill(80);
      }

      textSize(13);
      textAlign(LEFT, CENTER);
      text(currentFlight.date,     30,  yPosition);
      text(currentFlight.carrier,  200, yPosition);
      text(currentFlight.origin,   320, yPosition);
      text(currentFlight.dest,     550, yPosition);
      text(currentFlight.distance, 750, yPosition);

      if (currentFlight.cancel.equals("1")) {
        text("CANCELLED", 900, yPosition);
      }
      else {
        text("ON TIME", 900, yPosition);
      }
    }

    yPosition = yPosition + 25;
  }

  boolean homeButtonHover = (mouseX > width - 110 && mouseX < width - 10 && mouseY > 10 && mouseY < 50);

  if (homeButtonHover == true) {
    fill(255, 210, 210);
  }
  else {
    fill(230);
  }

  stroke(255);
  strokeWeight(2);
  rect(width - 110, 10, 100, 40);
  fill(80);
  textAlign(CENTER, CENTER);
  textSize(16);
  text("Home", width - 60, 30);
  strokeWeight(1);
  stroke(0);
}

void drawFAQPage() {
  currentScreen.draw();

  if (currentScreen == queryScreen) {
    fill(80);
    textAlign(CENTER, CENTER);
    textSize(28);
    text("Frequently Asked Questions", width / 2, 110);
  }

  if (currentScreen == screenOne) {
    pieChart.draw();
  }

  if (currentScreen == screenTwo) {
    weeklyChart.draw();

    boolean backButtonHover = (mouseX > 10 && mouseX < 110 && mouseY > 10 && mouseY < 50);

    if (backButtonHover == true) {
      fill(255, 210, 210);
    }
    else {
      fill(230, 230, 230);
    }

    stroke(255);
    strokeWeight(2);
    rect(10, 10, 100, 40);
    fill(80);
    noStroke();
    textAlign(CENTER, CENTER);
    textSize(16);
    text("Back", 60, 30);
    stroke(0);
    strokeWeight(1);
  }

  if (currentScreen == screenThree) {
    emissionsChart.draw();
  }

  if (currentScreen == screenFour) {
    game.draw();

    boolean backButtonHover = (mouseX > 10 && mouseX < 110 && mouseY > 10 && mouseY < 50);

    if (backButtonHover == true) {
      fill(255, 210, 210);
    }
    else {
      fill(230, 230, 230);
    }

    stroke(255);
    strokeWeight(2);
    rect(10, 10, 100, 40);
    fill(80);
    noStroke();
    textAlign(CENTER, CENTER);
    textSize(16);
    text("Back", 60, 30);
    stroke(0);
    strokeWeight(1);
  }

  if (currentScreen == screenFive) {
    lineChart.draw();
  }

  if (currentScreen == screenSix) {
    barChart.draw();
  }
}

void drawEmissionsPage() {
  image(emissionsBackgroundImage, 0, 0, width, height);

  boolean viewChartButtonHover = (mouseX > 40 && mouseX < 200 && mouseY > 510 && mouseY < 550);

  noStroke();

  if (viewChartButtonHover == true) {
    fill(255, 100, 150);
  }
  else {
    fill(255, 150, 180);
  }

  rect(40, 510, 160, 40, 8);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(15);
  text("View Chart", 120, 530);

  boolean homeButtonHover = (mouseX > width - 110 && mouseX < width - 10 && mouseY > 10 && mouseY < 50);

  noStroke();

  if (homeButtonHover == true) {
    fill(255, 210, 210);
  }
  else {
    fill(220);
  }

  rect(width - 110, 10, 100, 40, 6);
  fill(80);
  textAlign(CENTER, CENTER);
  textSize(16);
  text("Home", width - 60, 30);
}

void drawEmissionsChartPage() {
  background(250);

  emissionsChart.draw();

  boolean backButtonHover = (mouseX > 10 && mouseX < 110 && mouseY > 10 && mouseY < 50);

  if (backButtonHover == true) {
    fill(255, 210, 210);
  }
  else {
    fill(230);
  }

  stroke(255);
  strokeWeight(2);
  rect(10, 10, 100, 40);
  fill(80);
  textAlign(CENTER, CENTER);
  textSize(16);
  text("Back", 60, 30);
  strokeWeight(1);
  stroke(0);
}

void checkMenuHovers() {
  if (mouseX > width - 400 && mouseX < width - 300 && mouseY < 70) {
    flightsMenuHover = true;
  }
  else {
    flightsMenuHover = false;
  }

  if (mouseX > width - 260 && mouseX < width - 160 && mouseY < 70) {
    faqMenuHover = true;
  }
  else {
    faqMenuHover = false;
  }

  if (mouseX > width - 150 && mouseX < width && mouseY < 70) {
    emissionsMenuHover = true;
  }
  else {
    emissionsMenuHover = false;
  }
}

void playClickSound() {
  if (clickSoundEffect != null) {
    clickSoundEffect.play();
  }
}

void mousePressed() {
  playClickSound();

  if (currentPage.equals("home")) {
    if (flightsMenuHover == true) {
      scrollYPosition = 0;
      currentPage = "flights";
    }
    if (faqMenuHover == true) {
      currentScreen = queryScreen;
      currentPage = "faq";
      if (jazzMusicPlaying == false && jazzMusic != null) {
        jazzMusic.loop();
        jazzMusicPlaying = true;
      }
    }
    if (emissionsMenuHover == true) {
      currentPage = "emissions";
    }
  }
  else if (currentPage.equals("flights")) {
    boolean homeButtonHover = (mouseX > width - 110 && mouseX < width - 10 && mouseY > 10 && mouseY < 50);
    if (homeButtonHover == true) {
      currentPage = "home";
    }
  }
  else if (currentPage.equals("emissions")) {
    boolean homeButtonHover      = (mouseX > width - 110 && mouseX < width - 10 && mouseY > 10 && mouseY < 50);
    boolean viewChartButtonHover = (mouseX > 40 && mouseX < 200 && mouseY > 510 && mouseY < 550);
    if (homeButtonHover == true) {
      currentPage = "home";
    }
    if (viewChartButtonHover == true) {
      currentPage = "emissionsChart";
    }
  }
  else if (currentPage.equals("emissionsChart")) {
    boolean backButtonHover = (mouseX > 10 && mouseX < 110 && mouseY > 10 && mouseY < 50);
    if (backButtonHover == true) {
      currentPage = "emissions";
    }
  }
  else if (currentPage.equals("faq")) {
    if (currentScreen == screenTwo) {
      boolean backButtonHover = (mouseX > 10 && mouseX < 110 && mouseY > 10 && mouseY < 50);
      if (backButtonHover == true) {
        currentScreen = queryScreen;
        return;
      }
    }

    String buttonEvent = currentScreen.getEvent(mouseX, mouseY);

    if (buttonEvent == null) {
      return;
    }

    if (buttonEvent.equals("What are the airlines with the most cancelations?")) {
      currentScreen = screenOne;
    }
    else if (buttonEvent.equals("What is the weekly flight activity?")) {
      currentScreen = screenTwo;
    }
    else if (buttonEvent.equals("What are my flight emissions?")) {
      currentScreen = screenThree;
    }
    else if (buttonEvent.equals("How can I entertain my kids?")) {
      currentScreen = screenFour;
      if (jazzMusicPlaying == true && jazzMusic != null) {
        jazzMusic.stop();
        jazzMusicPlaying = false;
      }
      if (gameAudioSound != null) {
        gameAudioSound.loop();
      }
    }
    else if (buttonEvent.equals("What is the most popular departure time?")) {
      currentScreen = screenFive;
    }
    else if (buttonEvent.equals("What are the most popular destinations?")) {
      currentScreen = screenSix;
    }
    else if (buttonEvent.equals("Back")) {
      currentScreen = queryScreen;
      if (gameAudioSound != null) {
        gameAudioSound.stop();
      }
      if (jazzMusicPlaying == false && jazzMusic != null) {
        jazzMusic.loop();
        jazzMusicPlaying = true;
      }
    }
    else if (buttonEvent.equals("Home")) {
      currentPage = "home";
    }
  }
}

void mouseWheel(MouseEvent e) {
  if (currentPage.equals("flights")) {
    scrollYPosition = scrollYPosition + e.getCount() * 25;
    if (scrollYPosition < 0) {
      scrollYPosition = 0;
    }
  }
}

void loadFlights(String filename) {
  String[] lines = loadStrings(filename);

  for (int i = 1; i < lines.length; i++) {
    String[] cols = splitCSVLine(lines[i]);

    if (cols.length < 18) {
      continue;
    }

    String flightDate     = cols[0];
    String flightCarrier  = cols[1];
    String originAirport  = cols[3];
    String originCity     = cols[4];
    String originAbbrev   = cols[5];
    String destAirport    = cols[8];
    String destCity       = cols[9];
    String destAbbrev     = cols[10];
    String cancelStatus   = cols[15];
    String flightDistance = cols[17];

    myFlights.add(new Flight(flightDate, flightCarrier, originAirport, originCity, originAbbrev, destAirport, destCity, destAbbrev, flightDistance, cancelStatus));
  }

  println("loaded " + myFlights.size() + " flights");
}

String[] splitCSVLine(String line) {
  ArrayList<String> fields = new ArrayList<String>();
  boolean insideQuotes = false;
  StringBuilder currentField = new StringBuilder();

  for (int c = 0; c < line.length(); c++) {
    char currentChar = line.charAt(c);

    if (currentChar == '"') {
      insideQuotes = !insideQuotes;
    }
    else if (currentChar == ',' && insideQuotes == false) {
      fields.add(currentField.toString());
      currentField = new StringBuilder();
    }
    else {
      currentField.append(currentChar);
    }
  }

  fields.add(currentField.toString());
  return fields.toArray(new String[0]);
}

void keyPressed() {
  if (currentPage.equals("faq") && currentScreen == screenFour) {
    game.keyPressed();
  }
}
