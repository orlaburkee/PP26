class WeeklyChart {
  void draw() {
    background(255);
    textAlign(LEFT);

    fill(200, 21, 58);
    textSize(14);
    text("FEMIRATES", 30, 80);

    fill(0);
    textSize(80);
    text("Weekly", 30, 180);
    fill(200, 21, 58);
    text("Flight", 30, 270);
    fill(0);
    text("Activity", 30, 360);

    fill(120);
    textSize(14);
    text("Jan 1-6, 2022",      30, 410);
    text("866 total flights",  30, 435);
    text("Peak: Sunday 163",   30, 460);
    text("Low:  Thursday 113", 30, 485);

    image(weeklyChartImage, 470, 100, 600, 500);
  }
}
