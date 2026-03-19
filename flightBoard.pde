ArrayList<Flight> myFlights;

int scrollY = 0;  // tracks how far down the user has scrolled

void setup() {
  size(1100, 750);
  myFlights = new ArrayList<Flight>();
  loadFlights("flights2k.csv");
}

void draw() {
  background(255);
  drawBoard();
}

void drawBoard() {
  int y = 50 - scrollY;  // subtract scrollY so rows shift up when scrolling down


  fill(0);
  textSize(14);
  text("DATE",        30,  20);
  text("CARRIER",     200, 20);
  text("ORIGIN",      320, 20);
  text("DESTINATION", 550, 20);
  text("DISTANCE",    750, 20);
  text("STATUS",      900, 20);

  // line underneath the headers to separate them from the data
  line(20, 32, width - 20, 32);


  for (int i = 0; i < myFlights.size(); i++) {
    Flight f = myFlights.get(i);                   // loop through flights

    // only draw rows that are in the visible area of the screen
    if (y > 35 && y < height) {

      // pick red for cancelled flights or black for on time
      color mainCol = f.cancel.equals("1") ? color(200, 0, 0) : color(0);

      fill(mainCol);
      textSize(13);
      text(f.date,     30,  y);
      text(f.carrier,  200, y);
      text(f.distance, 750, y);

      // origin shows the full city name like "New York, NY"
      text(f.origin, 320, y);

      // destination shows the full city name like "Los Angeles, CA"
      text(f.dest, 550, y);

      // show cancelled or on time in the status column
      textSize(13);
      if (f.cancel.equals("1")) {
        text("CANCELLED", 900, y);
      } else {
        text("ON TIME", 900, y);
      }
    }

    // move y down by 25 pixels for the next row
    y = y + 25;
  }
}

// mouse wheel moves scrollY up and down to scroll through the list
void mouseWheel(MouseEvent e) {
  scrollY = scrollY + e.getCount() * 25;

  // stop scrolling above the top of the list
  if (scrollY < 0) scrollY = 0;
}

void loadFlights(String filename) {
  String[] lines = loadStrings(filename);

  // start at 1 to skip the header row in the csv
  for (int i = 1; i < lines.length; i++) {
    String[] cols = splitCSVLine(lines[i]);
    if (cols.length < 18) continue;

    // pull each field out by its column index
    String date     = cols[0];
    String carrier  = cols[1];
    String orgAIR   = cols[3];
    String origin   = cols[4];   // full city name e.g. "New York, NY"
    String orgABR   = cols[5];
    String destAIR  = cols[8];
    String dest     = cols[9];   // full city name e.g. "Los Angeles, CA"
    String destABR  = cols[10];
    String cancel   = cols[15];
    String distance = cols[17];

    myFlights.add(new Flight(date, carrier, orgAIR, origin, orgABR, destAIR, dest, destABR, distance, cancel));

    // print each flight to the console so we can check the data loaded correctly
    if (cancel.equals("1")) {
      println(date + " || carrier: " + carrier + " || " + origin + " (" + orgABR + ") -> " + dest + " (" + destABR + ") " + distance + " km || CANCELED");
    } else {
      println(date + " || carrier: " + carrier + " || " + origin + " (" + orgABR + ") -> " + dest + " (" + destABR + ") " + distance + " km");
    }
  }
  println("loaded " + myFlights.size() + " flights");
}

// splits a csv line without breaking on commas inside city names like "New York, NY"
String[] splitCSVLine(String line) {
  ArrayList<String> fields = new ArrayList<String>();
  boolean inQuotes = false;
  StringBuilder sb = new StringBuilder();

  for (int c = 0; c < line.length(); c++) {
    char ch = line.charAt(c);
    if (ch == '"') {
      inQuotes = !inQuotes;          // toggle in and out of a quoted section
    } else if (ch == ',' && !inQuotes) {
      fields.add(sb.toString());     // comma outside quotes means new column
      sb = new StringBuilder();
    } else {
      sb.append(ch);                 // normal character gets added to current field
    }
  }
  fields.add(sb.toString());         // add the last field after the loop ends
  return fields.toArray(new String[0]);
}

class Flight {
  String date;
  String carrier;
  String orgAIR;
  String origin;   // full city name e.g. "New York, NY"
  String orgABR;
  String destAIR;
  String dest;     // full city name e.g. "Los Angeles, CA"
  String destABR;
  String distance;
  String cancel;

  Flight(String date, String carrier, String orgAIR, String origin, String orgABR,
         String destAIR, String dest, String destABR, String distance, String cancel) {
    this.date     = date;
    this.carrier  = carrier;
    this.orgAIR   = orgAIR;
    this.origin   = origin;
    this.orgABR   = orgABR;
    this.destAIR  = destAIR;
    this.dest     = dest;
    this.destABR  = destABR;
    this.distance = distance;
    this.cancel   = cancel;
  }

  String info() {
    return date + "  " + carrier + "  " + origin + " (" + orgABR + ") -> " + dest + " (" + destABR + ")  " + distance + " miles";
  }
}
