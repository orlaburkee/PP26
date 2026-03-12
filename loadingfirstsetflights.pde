ArrayList<Flight> flights;
int scrollOffset = 0;

void setup() {
  size(1200, 800);
  flights = new ArrayList<Flight>();
  loadFlights("flights_full.csv");
}

void draw() {
  background(0);
  fill(255);
  textSize(12);
  
  int y = 20;
  for (int i = scrollOffset; i < flights.size(); i++) {
    text(flights.get(i).info(), 10, y);
    y += 16;
    if (y > height) break;
  }
}

void mouseWheel(MouseEvent e) {
  scrollOffset += (int)e.getCount();
  scrollOffset = constrain(scrollOffset, 0, flights.size() - 1);
}

void loadFlights(String filename) {
  String[] lines = loadStrings(filename);
  
  if (lines == null) {
    println("ERROR: Could not find file " + filename);
    return;
  }
  
  println("File found! Total lines: " + lines.length);
  
  for (int i = 1; i < lines.length; i++) {
    String[] cols = split(lines[i], ',');
    if (cols.length < 18) continue;

    String date     = cols[0];
    String carrier  = cols[1];
    String origin   = cols[3];
    String dest     = cols[7];
    float  distance = float(cols[17]);

    flights.add(new Flight(date, carrier, origin, dest, distance));
  }
  
  println("Done. Loaded " + flights.size() + " flights.");
}

class Flight {
  String date;
  String carrier;
  String origin;
  String dest;
  float distance;

  Flight(String date, String carrier, String origin, String dest, float distance) {
    this.date     = date;
    this.carrier  = carrier;
    this.origin   = origin;
    this.dest     = dest;
    this.distance = distance;
  }

  String info() {
    return date + "  " + carrier + "  " + origin + " -> " + dest + "  " + distance + " miles";
  }
}
