class Widget {
  int xPosition;
  int yPosition;
  int widgetWidth;
  int widgetHeight;
  String label;
  color backgroundColour;
  color hoverColour;

  Widget(int xPos, int yPos, int widgetW, int widgetH, String labelText, color backgroundColourValue) {
    this.xPosition        = xPos;
    this.yPosition        = yPos;
    this.widgetWidth      = widgetW;
    this.widgetHeight     = widgetH;
    this.label            = labelText;
    this.backgroundColour = backgroundColourValue;
    this.hoverColour      = color(255, 210, 210);
  }

  void draw() {
    if (hovering(mouseX, mouseY) == true) {
      fill(hoverColour);
    }
    else {
      fill(backgroundColour);
    }

    noStroke();
    rect(xPosition, yPosition, widgetWidth, widgetHeight);
    fill(80);
    textAlign(CENTER, CENTER);
    textSize(16);
    text(label, xPosition + widgetWidth / 2, yPosition + widgetHeight / 2);
  }

  boolean clicked(int mouseXPosition, int mouseYPosition) {
    if (mouseXPosition > xPosition && mouseXPosition < xPosition + widgetWidth && mouseYPosition > yPosition && mouseYPosition < yPosition + widgetHeight) {
      return true;
    }
    else {
      return false;
    }
  }

  boolean hovering(int mouseXPosition, int mouseYPosition) {
    if (mouseXPosition > xPosition && mouseXPosition < xPosition + widgetWidth && mouseYPosition > yPosition && mouseYPosition < yPosition + widgetHeight) {
      return true;
    }
    else {
      return false;
    }
  }
}
