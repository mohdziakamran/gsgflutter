import 'package:gsgflutter/model/passenger.dart';
import 'package:gsgflutter/passenger_details/passenger_details_page.dart';

class TidQueryResponseModel {
  /*
agency
busNumber
busName
source
destination
passengerList
paidAmount
departure
arrival

  */
  String tid, agency, busNumber, busName, source, destination;
  int paidAmount;
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
      busName: responseData['busName'],
      busNumber: responseData['busNumber'],
      departure: DateTime.parse(responseData['departure'] as String),
      destination: responseData['destination'],
      paidAmount: int.parse(responseData['paidAmount'] as String),
      passengerList: List<Passanger>.from(responseData['passengerList']
          .map((i) => Passanger.fromJson(i))
          .toList()),
      // passengerList: List<Passanger>.from['passengerList'],
      source: responseData['source'],
    );
  }
}
