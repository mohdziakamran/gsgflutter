import 'package:intl/intl.dart';

class SearchResponseModel {
  String id, source, destination, busNumber, busName, agencyName;
  DateTime dateOfJourney, departure, arrival;
  int availableSeats;
  double fare;

  SearchResponseModel(
      this.id,
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
      : id = json['bus_id'],
        source = json['source'],
        destination = json['destination'],
        dateOfJourney =
            (DateFormat("dd-MM-yyyy")).parse(json['date_of_journey'] as String),
        busNumber = json['bus_number'],
        busName = json['bus_name'],
        agencyName = json['agency_name'],
        // availableSeats = int.parse(json['no_of_seats_available'] as String),
        availableSeats = json['no_of_seats_available'],
        departure = DateTime.parse(json['departure_time'] as String),
        arrival = DateTime.parse(json['arrival_time'] as String),
        // fare = int.parse(json['fare_for_one_seat'] as String);
        fare = json['fare_for_one_seat'];
}
