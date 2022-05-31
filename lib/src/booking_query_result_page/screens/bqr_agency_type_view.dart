import 'package:date_time_format/src/date_time_extension_methods.dart';
import 'package:flutter/material.dart';
import 'package:gsgflutter/src/model/search_response_model.dart';
import 'package:gsgflutter/src/passenger_details/screens/passenger_details_screen.dart';
import 'package:gsgflutter/src/utility/my_lib.dart';

class BqrAgencyType extends StatefulWidget {
  Map<String, List<SearchResponseModel>> responseListmap;

  BqrAgencyType({Key? key, required this.responseListmap}) : super(key: key);

  @override
  _BqrAgencyTypeState createState() => _BqrAgencyTypeState();
}

class _BqrAgencyTypeState extends State<BqrAgencyType> {
  /*widget for each result*/
  Widget eachResultWig(SearchResponseModel each) {
    Color mycol = ((each.availableSeats > 0)
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
                "${each.departure.format('H:i')} ${each.departure.format('M j')}",
                style: TextStyle(fontSize: 22, color: Colors.grey[800]),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(pdn),
              child: Text(
                "${each.arrival.format('H:i')}  ${each.arrival.format('M j')}",
                style: TextStyle(fontSize: 22, color: Colors.grey[800]),
              ),
            ),
          ],
        ),

        ///Departure and Arrival Stops
        Table(
          columnWidths: const {
            0: FractionColumnWidth(0.45),
            1: FractionColumnWidth(0.1),
            2: FractionColumnWidth(0.45),
          },
          children: [
            TableRow(children: [
              Padding(
                padding: EdgeInsets.all(pdn),
                child: Text(
                  each.source,
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              ),
              const Icon(
                Icons.arrow_right_alt_outlined,
                size: 30,
                color: Colors.black,
              ),
              Padding(
                padding: EdgeInsets.all(pdn),
                child: Text(
                  each.destination,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ])
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
                    '${each.availableSeats}',
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
                    'ETB: ',
                    style: TextStyle(fontSize: 20, color: Colors.green[800]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    '${each.fare}',
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
          leading: Icon(
            Icons.apartment_outlined,
            size: 35,
          ),
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
