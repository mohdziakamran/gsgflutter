import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gsgflutter/backend/api_backend.dart';
import 'package:gsgflutter/backend/search_response_model.dart';
import 'package:gsgflutter/config/global_properties.dart';
import 'package:gsgflutter/backend/search_request_model.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:gsgflutter/homepage/wig_in_dif.dart';
import 'package:gsgflutter/passenger_details/passenger_details_page.dart';

class BookingQueryResultPage extends StatefulWidget {
  SearchRequestModel ftd;
  TextEditingController originTAController;
  TextEditingController destTAController;
  BookingQueryResultPage(
      {Key? key,
      required this.ftd,
      required this.originTAController,
      required this.destTAController})
      : super(key: key);

  @override
  _BookingQueryResultPageState createState() => _BookingQueryResultPageState();
}

class _BookingQueryResultPageState extends State<BookingQueryResultPage> {
  /*widget for each result*/
  Widget eachResultWig(SearchResponseModel each) {
    Color mycol = ((int.parse(each.availableSeats) > 0)
        ? Colors.green.shade800
        : Colors.red.shade800);
    double pdn = 2;
    return Column(
      children: [
        ///Agency Name
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(pdn),
          child: Text(
            each.agencyName,
            style: TextStyle(fontSize: 15, color: Colors.grey[700]),
            overflow: TextOverflow.ellipsis,
          ),
        ),

        ///bus details
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.directions_bus,
              color: Colors.black,
            ),
            Padding(
              padding: EdgeInsets.all(pdn),
              child: Text(
                "${each.busNumber} - ${each.busName}",
                style: TextStyle(fontSize: 20, color: Colors.grey[850]),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),

        ///departure arrival schedules time
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(pdn),
              child: Text(
                "${each.departureTime} ${widget.ftd.datePicked.format('M j')}",
                style: TextStyle(fontSize: 22, color: Colors.grey[800]),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(pdn),
              child: Text(
                "${each.arrivalTime} ${widget.ftd.datePicked.format('M j')}",
                style: TextStyle(fontSize: 22, color: Colors.grey[800]),
              ),
            ),
          ],
        ),

        ///Departure and Arrival Stops
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(pdn),
                child: Text(
                  each.source,
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(pdn),
                child: Text(
                  each.destination,
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),

        ///->
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///Seats Avl
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                Padding(
                  padding: EdgeInsets.all(pdn),
                  child: Text(
                    'Seats Avl: ',
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(pdn),
                  child: Text(
                    each.availableSeats,
                    style: TextStyle(fontSize: 25, color: mycol),
                  ),
                ),
              ],
            ),

            ///Fare for each
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    'Rs: ',
                    style: TextStyle(fontSize: 20, color: Colors.green[800]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    each.fare,
                    style: TextStyle(fontSize: 25, color: Colors.green[800]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// Function for ontap any result
  /// It Forward to new page containg details about tickets and
  void onTapAnyResultAction(SearchResponseModel srpm) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PassengerDetailsPage(
          ftd: widget.ftd,
          searchResponseModel: srpm,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var responseList = ApiBackend.BookingQuerySearchCall(widget.ftd);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Results", style: TextStyle(fontSize: 25)),
        centerTitle: true,
      ),
      body: (responseList.isEmpty)
          ? const Center(
              child: Text(
                "No Result Found",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: responseList.length,
              itemBuilder: (BuildContext context, int index) {
                var temp = responseList[index];
                return TextButton(
                  onPressed: () {
                    onTapAnyResultAction(temp);
                  },
                  child: eachResultWig(temp),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
    );
  }
}
