
class Flight{
  
  String date;
  String carrier;
  String origin;
  String dest;
  float  distance;
  String cancel;

  Flight(String date, String carrier, String origin, String dest, float distance, String cancel) {
    this.date     = date;
    this.carrier  = carrier;
    this.origin   = origin;
    this.dest     = dest;
    this.distance = distance;
    this.cancel   = cancel;
  }
          // method to retrun formatted string w fight info
  String info() {
    return date + "  " + carrier + "  " + origin + " -> " + dest + "  " + distance + " miles " + cancel ;
  }
}
