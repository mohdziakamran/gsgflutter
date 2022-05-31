import 'package:gsgflutter/src/model/passenger.dart';

class TidQueryResponseModel {
  String tid, agency, busNumber, busName, source, destination;
  double paidAmount;
  List<Passanger> passengerList;
  DateTime departure, arrival;

  TidQueryResponseModel(
      {required this.tid,
      required this.agency,
      required this.arrival,
      required this.busName,
      required this.busNumber,
      required this.departure,
      required this.destination,
      required this.paidAmount,
      required this.passengerList,
      required this.source});

  factory TidQueryResponseModel.fromJson(Map<String, dynamic> responseData) {
    return TidQueryResponseModel(
      tid: responseData['tid'],
      agency: responseData['agency'],
      arrival: DateTime.parse(responseData['arrival'] as String),
      busName: responseData['bus_name'],
      busNumber: responseData['bus_number'],
      departure: DateTime.parse(responseData['departure'] as String),
      destination: responseData['destination'],
      // paidAmount: int.parse(responseData['paidAmount'] as String),
      paidAmount: responseData['paidAmount'],
      passengerList: List<Passanger>.from(responseData['passenger_list']
          .map((i) => Passanger.fromJson(i))
          .toList()),
      // passengerList: List<Passanger>.from['passengerList'],
      source: responseData['source'],
    );
  }
}
