class LineChart {
  String[] labels;
  float[] values;
  int numberOfPoints;
  int hoveredPointIndex;

  int marginLeft   = 80;
  int marginRight  = 50;
  int marginTop    = 80;
  int marginBottom = 70;

  color lineColour = color(255, 105, 180);
  color textColour = color(80);
  color gridColour = color(210, 210, 210);

  LineChart(String filename, String labelColumn, String valueColumn) {
    hoveredPointIndex = -1;
    Table table       = loadTable(filename, "header");

    if (table == null) {
      numberOfPoints = 0;
      println("could not load " + filename);
      return;
    }

    numberOfPoints = table.getRowCount();
    labels         = new String[numberOfPoints];
    values         = new float[numberOfPoints];

    for (int i = 0; i < numberOfPoints; i++) {
      labels[i] = table.getString(i, labelColumn);
      values[i] = table.getFloat(i, valueColumn);
    }

    println("line chart loaded " + numberOfPoints + " rows");
  }

  void draw() {
    if (numberOfPoints == 0) {
      fill(80);
      textAlign(CENTER, CENTER);
      textSize(18);
      text("No data loaded.", width / 2, height / 2);
      return;
    }

    detectHover();
    drawGrid();
    drawLineAndDots();
    drawAxes();
    drawTitle();
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
      textSize(14);
      text(nf((i / float(numberOfGridLines)) * maxValue, 0, 0), marginLeft - 8, yPosition);
    }
  }

  void drawLineAndDots() {
    float maxValue  = max(values) * 1.1;
    int chartHeight = height - marginTop - marginBottom;
    int chartWidth  = width  - marginLeft - marginRight;

    float[] xPositions = new float[numberOfPoints];
    float[] yPositions = new float[numberOfPoints];

    for (int i = 0; i < numberOfPoints; i++) {
      xPositions[i] = marginLeft + i * (chartWidth / float(numberOfPoints - 1));
      yPositions[i] = marginTop + chartHeight - map(values[i], 0, maxValue, 0, chartHeight);
    }

    noStroke();
    fill(lineColour, 40);
    beginShape();
    vertex(xPositions[0], marginTop + chartHeight);
    for (int i = 0; i < numberOfPoints; i++) {
      vertex(xPositions[i], yPositions[i]);
    }
    vertex(xPositions[numberOfPoints - 1], marginTop + chartHeight);
    endShape(CLOSE);

    stroke(lineColour);
    strokeWeight(2.5);
    noFill();
    beginShape();
    for (int i = 0; i < numberOfPoints; i++) {
      vertex(xPositions[i], yPositions[i]);
    }
    endShape();

    for (int i = 0; i < numberOfPoints; i++) {
      boolean isHovered = (i == hoveredPointIndex);

      fill(lineColour);
      noStroke();

      if (isHovered == true) {
        ellipse(xPositions[i], yPositions[i], 14, 14);
      }
      else {
        ellipse(xPositions[i], yPositions[i], 8, 8);
      }

      fill(textColour);
      textAlign(CENTER, BOTTOM);
      textSize(14);
      text(nf(values[i], 0, 0), xPositions[i], yPositions[i] - 10);

      fill(textColour);
      textAlign(CENTER, TOP);
      textSize(14);
      text(labels[i], xPositions[i], height - marginBottom + 8);
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
    text("Hour", width / 2, height - marginBottom + 40);
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
    text("Most Popular Departure Hours", width / 2, 30);
  }

  void detectHover() {
    float maxValue  = max(values) * 1.1;
    int chartHeight = height - marginTop - marginBottom;
    int chartWidth  = width  - marginLeft - marginRight;

    hoveredPointIndex = -1;

    for (int i = 0; i < numberOfPoints; i++) {
      float xPosition = marginLeft + i * (chartWidth / float(numberOfPoints - 1));
      float yPosition = marginTop + chartHeight - map(values[i], 0, maxValue, 0, chartHeight);

      if (dist(mouseX, mouseY, xPosition, yPosition) < 12) {
        hoveredPointIndex = i;
        cursor(HAND);
        return;
      }
    }

    cursor(ARROW);
  }
}
