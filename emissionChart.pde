class EmissionsChart {
  String[] carrierNames  = {"AA", "AS", "B6", "DL", "F9", "G4", "HA", "NK", "UA", "WN"};
  float[] totalMilesList = {132047, 113278, 49563, 664, 24672, 21059, 147817, 20566, 18034, 36965};

  int[][] airlineColourValues = {
    {55, 138, 221},
    {29, 158, 117},
    {216, 90, 48},
    {127, 119, 221},
    {153, 60, 29},
    {15, 110, 86},
    {212, 83, 126},
    {186, 117, 23},
    {83, 74, 183},
    {226, 75, 74}
  };

  float co2ConversionFactor = 0.0001;
  float[] co2ValuesList;
  float maximumCO2Value;

  int marginLeft   = 70;
  int marginRight  = 70;
  int chartTop     = 110;
  int chartBottom  = 700;
  float barAreaWidth;
  float barGapSize;
  float barWidth;

  EmissionsChart() {
    co2ValuesList    = new float[carrierNames.length];
    maximumCO2Value  = 0;

    for (int i = 0; i < carrierNames.length; i++) {
      co2ValuesList[i] = totalMilesList[i] * co2ConversionFactor;
      if (co2ValuesList[i] > maximumCO2Value) {
        maximumCO2Value = co2ValuesList[i];
      }
    }

    barAreaWidth = width  - marginLeft - marginRight;
    barGapSize   = barAreaWidth / float(carrierNames.length);
    barWidth     = barGapSize * 0.55;
  }

  void draw() {
    fill(30);
    textSize(20);
    textAlign(CENTER, TOP);
    text("Estimated CO2 Emissions by Airline", width / 2, 18);

    fill(120);
    textSize(13);
    text("Jan 1-6, 2022  |  CO2 (tonnes) = distance (mi) x 0.0001", width / 2, 48);

    int numberOfGridLines = 5;
    stroke(200);
    strokeWeight(0.8);

    for (int i = 0; i <= numberOfGridLines; i++) {
      float yPosition  = map(i, 0, numberOfGridLines, chartBottom, chartTop);
      float gridValue  = maximumCO2Value * i / numberOfGridLines;
      line(marginLeft, yPosition, width - marginRight, yPosition);
      fill(140);
      noStroke();
      textSize(11);
      textAlign(RIGHT, CENTER);
      text(nf(gridValue, 0, 1), marginLeft - 6, yPosition);
    }

    pushMatrix();
    translate(18, (chartTop + chartBottom) / 2);
    rotate(-HALF_PI);
    fill(100);
    textSize(13);
    textAlign(CENTER, CENTER);
    text("CO2 (tonnes)", 0, 0);
    popMatrix();

    for (int i = 0; i < carrierNames.length; i++) {
      float xPosition = marginLeft + barGapSize * i + (barGapSize - barWidth) / 2;
      float barHeight = map(co2ValuesList[i], 0, maximumCO2Value, 0, chartBottom - chartTop);
      float yPosition = chartBottom - barHeight;

      fill(airlineColourValues[i][0], airlineColourValues[i][1], airlineColourValues[i][2]);
      noStroke();
      rect(xPosition, yPosition, barWidth, barHeight, 4, 4, 0, 0);

      fill(50);
      textSize(11);
      textAlign(CENTER, BOTTOM);
      text(nf(co2ValuesList[i], 0, 1), xPosition + barWidth / 2, yPosition - 3);

      fill(60);
      textSize(13);
      textAlign(CENTER, TOP);
      text(carrierNames[i], xPosition + barWidth / 2, chartBottom + 8);
    }

    stroke(180);
    strokeWeight(1);
    line(marginLeft, chartTop,    marginLeft,          chartBottom);
    line(marginLeft, chartBottom, width - marginRight, chartBottom);

    fill(160);
    textSize(11);
    textAlign(LEFT, BOTTOM);
    noStroke();
    text("Methodology: ICAO simplified factor, excludes load factor and aircraft type.", marginLeft, height - 8);
  }
}
