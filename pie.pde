
String[] airlineNames = { "AS", "WN", "B6", "HA", "GA" };
int[] cancelCounts = { 93, 58, 33, 14, 11 };

PImage sunsetImg;  

void setup() {
  size(1200, 800);
  //noStroke();
  noLoop();
  sunsetImg = loadImage("sunset.jpg");  
}

void draw() {

  image(sunsetImg, 0, 0, width, height);
  pieChart(400, cancelCounts);
  drawPie();
  //noStroke();
}

void pieChart(float diameter, int[] data) {
  int total = 0;
  for (int i = 0; i < data.length; i++) {  // add totals
    total = total + data[i];
  }

  float lastAngle = 0;
  for (int i = 0; i < data.length; i++) {     // pink to red
    float sunsetImg = map(i, 0, data.length, 150, 0);
    fill(255, sunsetImg, sunsetImg);
    
    // work out the angle of this slice based on its share of the total
    float pieAngle = radians(360.0 * data[i] / total);
    arc(width/2, height/2, diameter, diameter, lastAngle, lastAngle + pieAngle);
    // move along for the next slice
    lastAngle = lastAngle + pieAngle;
  }
}

void drawPie() {
  textSize(15);
  for (int i = 0; i < 5; i++) {
    // same colour as the matching slice
    float sunsetImg = map(i, 0, 5, 150, 0);
    fill(255, sunsetImg, sunsetImg);
    rect(30, 30 + i * 50, 50, 40);
    fill(0);
    text(airlineNames[i] + " - " + cancelCounts[i] + " cancels", 88, 46 + i * 52);
  }
}
