class PieChart {
  float centreX;
  float centreY;
  float diameter;
  String[] airlineNames;
  int[] cancelCounts;
  color[] sliceColours;

  PieChart(float centreXPosition, float centreYPosition, float chartDiameter, String[] airlineNamesList, int[] cancelCountsList, color[] sliceColoursList) {
    this.centreX      = centreXPosition;
    this.centreY      = centreYPosition;
    this.diameter     = chartDiameter;
    this.airlineNames = airlineNamesList;
    this.cancelCounts = cancelCountsList;
    this.sliceColours = sliceColoursList;
  }

  void draw() {
    drawSlices();
    drawLegend();
  }

  void drawSlices() {
    int totalCancellations = 0;

    for (int i = 0; i < cancelCounts.length; i++) {
      totalCancellations = totalCancellations + cancelCounts[i];
    }

    float lastAngle = 0;

    for (int i = 0; i < cancelCounts.length; i++) {
      float sliceAngle = radians(360.0 * cancelCounts[i] / totalCancellations);
      fill(sliceColours[i]);
      stroke(255);
      strokeWeight(2);
      arc(centreX, centreY, diameter, diameter, lastAngle, lastAngle + sliceAngle);
      lastAngle = lastAngle + sliceAngle;
    }
  }

  void drawLegend() {
    fill(80);
    textAlign(LEFT, CENTER);
    textSize(18);
    text("Airlines by Cancellations", 30, 170);

    for (int i = 0; i < airlineNames.length; i++) {
      fill(sliceColours[i]);
      stroke(255);
      strokeWeight(2);
      rect(30, 200 + i * 80, 50, 40);
      fill(80);
      textAlign(LEFT, CENTER);
      textSize(16);
      text(airlineNames[i] + " - " + cancelCounts[i] + " cancellations", 90, 220 + i * 80);
    }
  }
}
