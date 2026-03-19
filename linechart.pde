Table table;

String[] labels;
float[] values;
int numBars;

String labelColumn = "Hour";
String valueColumn = "Count";

int marginLeft   = 80;
int marginRight  = 400;
int marginTop    = 60;
int marginBottom = 70;

color bgColor   = #1a1a2e;
color gridColor = #2a2a4a;
color lineColor = #ff69b4;
color dotColor  = #ff69b4;
color fillColor = #e9456033; // transparent fill under line
color textColor = #e0e0f0;

int hoveredPoint = -1;

void setup() {
  size(1200, 800);
  smooth(4);
  loadCSV();
}

void loadCSV() {
  table = loadTable("top10departure.csv", "header");

  if (table == null) {
    println("ERROR: Could not load data/data.csv");
    numBars = 0;
    return;
  }

  numBars = table.getRowCount();
  labels  = new String[numBars];
  values  = new float[numBars];

  for (int i = 0; i < numBars; i++) {
    labels[i] = table.getString(i, labelColumn);
    values[i] = table.getFloat(i, valueColumn);
  }

  println("Loaded " + numBars + " rows");
}

void draw() {
  background(bgColor);

  if (numBars == 0) {
    fill(255, 80, 80);
    textAlign(CENTER, CENTER);
    textSize(18);
    text("No data loaded.", width / 2, height / 2);
    return;
  }
  

  detectHover();
  drawGrid();
  drawLine();
  drawAxes();
  drawTitle();
  
  //textBox
  fill(255);
  rect(850, marginTop, 300, 670, 28);
  
  fill(#1a1a2e);
  textSize(30);
  text("Graph Info", 990, marginTop + 10);
  textSize(24);
  text("This line chart shows the top 10 most popular hour of scheduled flight departure and how often flights occur at that time", 950, marginTop + 40);
  
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
    textSize(18);
    text(nf((i / float(gridLines)) * maxVal, 0, 1), marginLeft - 8, y);
  }
}

void drawLine() {
  float maxVal = max(values) * 1.1;
  int chartH   = height - marginTop - marginBottom;
  int chartW   = width  - marginLeft - marginRight;

  // Calculate point positions
  float[] px = new float[numBars];
  float[] py = new float[numBars];
  for (int i = 0; i < numBars; i++) {
    px[i] = marginLeft + i * (chartW / float(numBars - 1));
    py[i] = marginTop + chartH - map(values[i], 0, maxVal, 0, chartH);
  }

  // Shaded area under the line
  noStroke();
  fill(lineColor, 40);
  beginShape();
  vertex(px[0], marginTop + chartH);
  for (int i = 0; i < numBars; i++) {
    vertex(px[i], py[i]);
  }
  vertex(px[numBars - 1], marginTop + chartH);
  endShape(CLOSE);

  // Line
  stroke(lineColor);
  strokeWeight(2.5);
  noFill();
  beginShape();
  for (int i = 0; i < numBars; i++) {
    vertex(px[i], py[i]);
  }
  endShape();

  for (int i = 0; i < numBars; i++) {
    boolean hovered = (i == hoveredPoint);

    //dot
    fill(hovered ? dotColor : lineColor);
    noStroke();
    ellipse(px[i], py[i], hovered ? 12 : 8, hovered ? 12 : 8);

    // value label
    fill(textColor);
    textAlign(CENTER, BOTTOM);
    textSize(16);
    text(nf(values[i], 0, 1), px[i], py[i] - 10);

    // x axis label
    fill(textColor, 200);
    textAlign(CENTER, TOP);
    textSize(16);
    text(labels[i], px[i], height - marginBottom + 8);
    
    //y axis label
    pushMatrix();
    float angle2 = radians(270);
    translate(10, 450);
    rotate(angle2);
    textSize(24);
    text("Appearences", 0, 0);
    line(0, 0, 150, 0);
    popMatrix();

    textSize(24);
    text("Hour", width /2, 767);
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
  textSize(22);
  text("Line Chart of Most Popular Departure Hour", width / 2, 16);
}

void detectHover() {
  float maxVal = max(values) * 1.1;
  int chartH   = height - marginTop - marginBottom;
  int chartW   = width  - marginLeft - marginRight;

  hoveredPoint = -1;
  for (int i = 0; i < numBars; i++) {
    float px = marginLeft + i * (chartW / float(numBars - 1));
    float py = marginTop + chartH - map(values[i], 0, maxVal, 0, chartH);

    if (dist(mouseX, mouseY, px, py) < 12) {
      hoveredPoint = i;
      cursor(HAND);
      return;
    }
  }
  cursor(ARROW);
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    loadCSV();
  }
}
