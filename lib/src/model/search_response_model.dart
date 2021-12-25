class SearchResponseModel {
  String source, destination, busNumber, busName, agencyName;
  DateTime dateOfJourney, departure, arrival;
  int availableSeats, fare;

  SearchResponseModel(
      this.source,
      this.destination,
      this.dateOfJourney,
      this.busNumber,
      this.busName,
      this.agencyName,
      this.availableSeats,
      this.departure,
      this.arrival,
      this.fare);

  SearchResponseModel.fromJson(Map<String, dynamic> json)
      : source = json['source'],
        destination = json['destination'],
        dateOfJourney = DateTime.parse(json['dateOfJourney'] as String),
        busNumber = json['busNumber'],
        busName = json['busName'],
        agencyName = json['agencyName'],
        availableSeats = int.parse(json['availableSeats'] as String),
        departure = DateTime.parse(json['departure'] as String),
        arrival = DateTime.parse(json['arrival'] as String),
        fare = int.parse(json['fare'] as String);
}
