class Screen {
  ArrayList<Widget> widgetList;
  color backgroundColour;

  Screen(color backgroundColourValue) {
    this.backgroundColour = backgroundColourValue;
    widgetList = new ArrayList<Widget>();
  }

  void addWidget(Widget widgetToAdd) {
    widgetList.add(widgetToAdd);
  }

  String getEvent(int mouseXPosition, int mouseYPosition) {
    for (int i = 0; i < widgetList.size(); i++) {
      Widget currentWidget = widgetList.get(i);
      if (currentWidget.clicked(mouseXPosition, mouseYPosition)) {
        return currentWidget.label;
      }
    }
    return null;
  }

  void draw() {
    background(backgroundColour);
    for (int i = 0; i < widgetList.size(); i++) {
      widgetList.get(i).draw();
    }
  }
}
