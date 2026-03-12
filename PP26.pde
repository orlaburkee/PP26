ArrayList<Flight> myFlights;

void setup() {
  myFlights = new ArrayList<Flight>();
  loadFlights("flights_full.csv");                  //funxtion load data
}

void draw() {
}

void loadFlights(String filename) {
  String[] lines = loadStrings(filename);

  for (int i = 1; i < lines.length; i++) {
    String[] cols = split(lines[i], ',');      // comma seperator function
    if (cols.length < 18) continue;

    String date     = cols[0];
    String carrier  = cols[1];
    String origin   = cols[4];
    String dest     = cols[9];
    String cancel   = cols[15];
    //String canceled = cols[]
    float  distance = float(cols[17]);

       //flight object w data loaded into arraylist
    myFlights.add(new Flight(date, carrier, origin, dest, distance, cancel));
    if(cancel.equals("1")){
      println(date + " || carrier: " + carrier + " || " + origin + " -> " + dest + " " + distance + " miles || CANCELED");
    } else {
      println(date + " || carrier: " + carrier + " || " + origin + " -> " + dest + " " + distance + " miles");
    }
  }

  println("loaded " + myFlights.size() + " flights");
}
