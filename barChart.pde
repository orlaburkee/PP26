class BarChart {
  String[] labels;
  float[] values;
  int numberOfBars;

  int marginLeft   = 80;
  int marginRight  = 400;
  int marginTop    = 60;
  int marginBottom = 70;

  color barColour  = color(255, 105, 180);
  color textColour = color(80);
  color gridColour = color(210, 210, 210);

  BarChart(String filename, String labelColumn, String valueColumn) {
    Table table = loadTable(filename, "header");

    if (table == null) {
      numberOfBars = 0;
      println("could not load " + filename);
      return;
    }

    numberOfBars = table.getRowCount();
    labels       = new String[numberOfBars];
    values       = new float[numberOfBars];

    for (int i = 0; i < numberOfBars; i++) {
      labels[i] = table.getString(i, labelColumn);
      values[i] = table.getFloat(i, valueColumn);
    }

    println("bar chart loaded " + numberOfBars + " rows");
  }

  void draw() {
    if (numberOfBars == 0) {
      fill(80);
      textAlign(CENTER, CENTER);
      textSize(18);
      text("No data loaded.", width / 2, height / 2);
      return;
    }

    drawGrid();
    drawBars();
    drawAxes();
    drawTitle();
    drawInfoBox();
  }

  void drawGrid() {
    int numberOfGridLines = 5;
    float maxValue        = max(values) * 1.1;
    int chartHeight       = height - marginTop - marginBottom;
    int chartWidth        = width  - marginLeft - marginRight;

    stroke(gridColour);
    strokeWeight(1);

    for (int i = 0; i <= numberOfGridLines; i++) {
      float yPosition = marginTop + chartHeight - (i / float(numberOfGridLines)) * chartHeight;
      line(marginLeft, yPosition, marginLeft + chartWidth, yPosition);
      fill(textColour);
      noStroke();
      textAlign(RIGHT, CENTER);
      textSize(12);
      text(nf((i / float(numberOfGridLines)) * maxValue, 0, 0), marginLeft - 8, yPosition);
    }
  }

  void drawBars() {
    float maxValue  = max(values) * 1.1;
    int chartHeight = height - marginTop - marginBottom;
    int chartWidth  = width  - marginLeft - marginRight;
    float barWidth  = (chartWidth / float(numberOfBars)) * 0.6;
    float gapSize   = chartWidth / float(numberOfBars);

    for (int i = 0; i < numberOfBars; i++) {
      float barHeight = map(values[i], 0, maxValue, 0, chartHeight);
      float xPosition = marginLeft + i * gapSize + gapSize * 0.2;
      float yPosition = marginTop + chartHeight - barHeight;

      fill(0, 40);
      noStroke();
      rect(xPosition + 3, yPosition + 3, barWidth, barHeight, 4);

      fill(barColour);
      rect(xPosition, yPosition, barWidth, barHeight, 4, 4, 0, 0);

      fill(textColour);
      textAlign(CENTER, BOTTOM);
      textSize(13);
      text(nf(values[i], 0, 0), xPosition + barWidth / 2, yPosition - 4);

      fill(textColour);
      textAlign(CENTER, TOP);
      textSize(12);
      text(labels[i], xPosition + barWidth / 2, height - marginBottom + 8);
    }

    pushMatrix();
    translate(20, height / 2);
    rotate(radians(270));
    fill(textColour);
    textAlign(CENTER, CENTER);
    textSize(16);
    text("Appearances", 0, 0);
    popMatrix();

    fill(textColour);
    textAlign(CENTER, TOP);
    textSize(16);
    text("Airport Destination", width / 2, height - marginBottom + 40);
  }

  void drawAxes() {
    int chartHeight = height - marginTop - marginBottom;
    int chartWidth  = width  - marginLeft - marginRight;

    stroke(textColour);
    strokeWeight(2);
    line(marginLeft, marginTop, marginLeft, marginTop + chartHeight);
    line(marginLeft, marginTop + chartHeight, marginLeft + chartWidth, marginTop + chartHeight);
  }

  void drawTitle() {
    fill(textColour);
    textAlign(CENTER, TOP);
    textSize(22);
    text("Top 10 Most Popular Destinations", width / 2, 30);
  }

  void drawInfoBox() {
    fill(255);
    noStroke();
    rect(855, marginTop + 20, 300, 200, 16);
    fill(textColour);
    textAlign(CENTER, TOP);
    textSize(18);
    text("Graph Info", 855, marginTop + 32, 300, 30);
    textSize(14);
    text("This bar chart shows the top 10 most popular flight destinations. The X axis shows destination airports. The Y axis shows the number of flights.", 860, marginTop + 72, 285, 200);
  }
}
