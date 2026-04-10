class Flight {
  String date;
  String carrier;
  String originAirport;
  String origin;
  String originAbbrev;
  String destAirport;
  String dest;
  String destAbbrev;
  String distance;
  String cancel;

  Flight(String flightDate, String flightCarrier, String originAirportName, String originCityName, String originAbbreviation, String destAirportName, String destCityName, String destAbbreviation, String flightDistance, String cancelStatus) {
    this.date          = flightDate;
    this.carrier       = flightCarrier;
    this.originAirport = originAirportName;
    this.origin        = originCityName;
    this.originAbbrev  = originAbbreviation;
    this.destAirport   = destAirportName;
    this.dest          = destCityName;
    this.destAbbrev    = destAbbreviation;
    this.distance      = flightDistance;
    this.cancel        = cancelStatus;
  }
}
