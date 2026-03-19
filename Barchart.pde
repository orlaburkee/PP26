Table table;

String[] labels;
int[] values;
int numBars;

String labelColumn = "City";
String valueColumn = "Appearances";

// Layout
int marginLeft   = 80;
int marginRight  = 400;
int marginTop    = 60;
int marginBottom = 70;

// Colours
color bgColor    = #1a1a2e;
color gridColor  = #2a2a4a;
color barColor   = #ff69b4;
color barHover   = #ff6b8a;
color textColor  = #e0e0f0;


void setup() {
  size(1200, 800);
  smooth(4);
  loadCSV();
}

void loadCSV() {
  table = loadTable("top10.csv", "header");

  if (table == null) {
    println("ERROR: Could not load data/data.csv");
    numBars = 0;
    return;
  }

  numBars = table.getRowCount();
  labels  = new String[numBars];
  values  = new int[numBars];

  for (int i = 0; i < numBars; i++) {
    labels[i] = table.getString(i, labelColumn); // uses named column
    values[i] = table.getInt(i, valueColumn);  // uses named column
  }

  println("Loaded " + numBars + " rows using columns: '" + labelColumn + "', '" + valueColumn + "'");
}

void draw() {
  background(bgColor);

  if (numBars == 0) {
    fill(255, 80, 80);
    textAlign(CENTER, CENTER);
    textSize(18);
    text("No data loaded.\nPlace data.csv in the sketch's data/ folder.", width / 2, height / 2);
    return;
  }

  drawGrid();
  drawBars();
  drawAxes();
  drawTitle();
  
    
  //textBox
  fill(255);
  rect(850, marginTop, 300, 670, 28);
  
  fill(#1a1a2e);
  textSize(30);
  text("Graph Info", 990, marginTop + 10);
  
}

void drawGrid() {
  int gridLines = 5;
  float maxVal  = max(values) * 1.1;
  int chartH    = height - marginTop - marginBottom;
  int chartW    = width  - marginLeft - marginRight;

  stroke(gridColor);
  strokeWeight(1);

  for (int i = 0; i <= gridLines; i++) {
    float y = marginTop + chartH - (i / float(gridLines)) * chartH;
    line(marginLeft, y, marginLeft + chartW, y);

    fill(textColor, 160);
    noStroke();
    textAlign(RIGHT, CENTER);
    textSize(12);
    float labelVal = (i / float(gridLines)) * maxVal;
    text(nf(labelVal, 0, 1), marginLeft - 8, y);
  }
}

void drawBars() {
  float maxVal = max(values) * 1.1;
  int chartH   = height - marginTop - marginBottom;
  int chartW   = width  - marginLeft - marginRight;

  float barW = (chartW / float(numBars)) * 0.6;
  float gap  = (chartW / float(numBars));

  for (int i = 0; i < numBars; i++) {
    float barH = map(values[i], 0, maxVal, 0, chartH);
    float x    = marginLeft + i * gap + gap * 0.2;
    float y    = marginTop  + chartH - barH;

    //shadow
    fill(0, 60);
    noStroke();
    rect(x + 4, y + 4, barW, barH, 4);

    //bar
    fill(barColor);
    rect(x, y, barW, barH, 4, 4, 0, 0);

    //value label 
    fill(textColor);
    textAlign(CENTER, BOTTOM);
    textSize(15);
    text(nf(values[i], 0, 1), x + barW / 2, y - 4);

    //category label
    fill(textColor, 200);
    textAlign(CENTER, TOP);
    textSize(18);
    text(labels[i], x + barW / 2, height - marginBottom + 8);
    
    //y axis label
    pushMatrix();
    float angle2 = radians(270);
    translate(15, 450);
    rotate(angle2);
    textSize(24);
    text("Appearences", 0, 0);
    line(0, 0, 150, 0);
    popMatrix();
    
    //x axis label
    textSize(24);
    text("Airport Destination", width /2, 767);
    textAlign(CENTER, BOTTOM);
    
  }
}

void drawAxes() {
  stroke(textColor, 180);
  strokeWeight(2);
  int chartH = height - marginTop - marginBottom;
  int chartW = width  - marginLeft - marginRight;

  line(marginLeft, marginTop, marginLeft, marginTop + chartH);
  line(marginLeft, marginTop + chartH, marginLeft + chartW, marginTop + chartH);
}

void drawTitle() {
  fill(textColor);
  textAlign(CENTER, TOP);
  textSize(30);
  text("Top 10 Most Popular Destinations", width / 2, 16);
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    println("Reloading CSV...");
    loadCSV();
  }
}
