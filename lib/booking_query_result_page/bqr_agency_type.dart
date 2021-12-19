import 'dart:collection';

import 'package:date_time_format/src/date_time_extension_methods.dart';
import 'package:flutter/material.dart';
import 'package:gsgflutter/backend/search_request_model.dart';
import 'package:gsgflutter/backend/search_response_model.dart';
import 'package:gsgflutter/mylib/my_lib.dart';
import 'package:gsgflutter/passenger_details/passenger_details_page.dart';

class BqrAgencyType extends StatefulWidget {
  Map<String, List<SearchResponseModel>> responseListmap;
  SearchRequestModel ftd;

  BqrAgencyType({Key? key, required this.responseListmap, required this.ftd})
      : super(key: key);

  @override
  _BqrAgencyTypeState createState() => _BqrAgencyTypeState();
}

class _BqrAgencyTypeState extends State<BqrAgencyType> {
  /*widget for each result*/
  Widget eachResultWig(SearchResponseModel each) {
    Color mycol = ((int.parse(each.availableSeats) > 0)
        ? Colors.green.shade800
        : Colors.red.shade800);
    double pdn = 2;
    return Column(
      children: [
        ///Agency Name

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
    MyLib.myNewPage(
      context,
      PassengerDetailsPage(
        ftd: widget.ftd,
        searchResponseModel: srpm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> mapkeys = widget.responseListmap.keys.toList();
    return ListView.builder(
      itemCount: mapkeys.length,
      itemBuilder: (context, i) {
        return ExpansionTile(
          title: Padding(
            padding: EdgeInsets.all(18.0),
            child: Text(
              mapkeys[i],
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          children: <Widget>[
            Column(
              children:
                  _buildExpandableContent(widget.responseListmap[mapkeys[i]]),
            ),
          ],
        );
      },
    );
  }

  //build widget for each expandable
  _buildExpandableContent(List<SearchResponseModel>? responseList) {
    List<Widget> columnContent = [];
    for (SearchResponseModel content in responseList!) {
      columnContent.add(TextButton(
        onPressed: () {
          onTapAnyResultAction(content);
        },
        child: eachResultWig(content),
      ));
    }
    return columnContent;
  }
}
