String[] carriers = {"AA", "AS", "B6", "DL", "F9", "G4", "HA", "NK", "UA", "WN"};

// flight distances per carrier (miles)
// sum of all distance values per carrier
float[] totalMiles = {
  // AA - American Airlines
  132047,
  // AS - Alaska Airlines
  113278,
  // B6 - JetBlue
  49563,
  // DL - Delta
  664,
  // F9 - Frontier
  24672,
  // G4 - Allegiant
  21059,
  // HA - Hawaiian
  147817,
  // NK - Spirit
  20566,
  // UA - United
  18034,
  // WN - Southwest
  36965
};

// Colors per airline (RGB)
int[][] airlineColors = {
  {230, 230, 230},   // AA - light grey
  {255, 210, 210},   // AS - light pink
  {255, 195, 195},    // B6 - dark pink
  {210, 210, 210},  // DL - grey
  {255, 180, 180},    // F9 - pink
  {230, 230, 230},    // G4 - light grey
  {255, 195, 195},   // HA - pink
  {255, 210, 210},   // NK - light pink
  {255, 195, 195},    // UA - dark pink
  {255, 180, 180}     // WN - red
};

float CO2_FACTOR = 0.0001;
float[] co2Values;
float maxCO2;

int margin = 80;
int chartTop = 80;
int chartBottom;
int barAreaWidth;
float barW;
float barGap;

void setup() {
  size(900, 560);
  smooth();
  textFont(createFont("SansSerif", 13));

  co2Values = new float[carriers.length];
  maxCO2 = 0;
  for (int i = 0; i < carriers.length; i++) {
    co2Values[i] = totalMiles[i] * CO2_FACTOR;
    if (co2Values[i] > maxCO2) maxCO2 = co2Values[i];
  }

  chartBottom = height - margin;
  barAreaWidth = width - margin * 2;
  barGap = barAreaWidth / (float) carriers.length;
  barW = barGap * 0.6;
}

void draw() {
  background(250);

  fill(30);
  textSize(16);
  textAlign(CENTER, TOP);
  text("Estimated CO\u2082 Emissions by Airline", width / 2, 18);
  textSize(11);
  fill(120);
  text("Jan 1\u20136, 2022  \u2022  CO\u2082 (tonnes) = distance (mi) \u00d7 0.0001", width / 2, 42);

  // Grid lines
  int gridCount = 5;
  stroke(200);
  strokeWeight(0.8);
  for (int i = 0; i <= gridCount; i++) {
    float y = map(i, 0, gridCount, chartBottom, chartTop);
    float val = maxCO2 * i / gridCount;
    line(margin, y, width - margin, y);

    fill(140);
    noStroke();
    textSize(10);
    textAlign(RIGHT, CENTER);
    text(nf(val, 0, 1), margin - 6, y);
  }

  // Y-axis label
  pushMatrix();
  translate(18, (chartTop + chartBottom) / 2);
  rotate(-HALF_PI);
  fill(100);
  textSize(11);
  textAlign(CENTER, CENTER);
  text("CO\u2082 (tonnes)", 0, 0);
  popMatrix();

  // Bars
  for (int i = 0; i < carriers.length; i++) {
    float x = margin + barGap * i + (barGap - barW) / 2;
    float barH = map(co2Values[i], 0, maxCO2, 0, chartBottom - chartTop);
    float y = chartBottom - barH;

    // Bar fill
    fill(airlineColors[i][0], airlineColors[i][1], airlineColors[i][2]);
    noStroke();
    rect(x, y, barW, barH, 4, 4, 0, 0);

    // Value label above bar
    fill(50);
    textSize(10);
    textAlign(CENTER, BOTTOM);
    text(nf(co2Values[i], 0, 1), x + barW / 2, y - 3);

    // Airline label below
    fill(60);
    textSize(12);
    textAlign(CENTER, TOP);
    text(carriers[i], x + barW / 2, chartBottom + 8);
  }

  // Axes 
  stroke(180);
  strokeWeight(1);
  line(margin, chartTop, margin, chartBottom);
  line(margin, chartBottom, width - margin, chartBottom);


  noLoop();
}
