import 'package:date_time_format/src/date_time_extension_methods.dart';
import 'package:flutter/material.dart';
import 'package:gsgflutter/backend/api_backend.dart';
import 'package:gsgflutter/backend/search_request_model.dart';
import 'package:gsgflutter/backend/search_response_model.dart';
import 'package:gsgflutter/mylib/my_lib.dart';
import 'package:gsgflutter/passenger_details/passenger_details_page.dart';

class BqrAllType extends StatefulWidget {
  SearchRequestModel ftd;
  List<SearchResponseModel> responseList;
  BqrAllType({Key? key, required this.responseList, required this.ftd})
      : super(key: key);

  @override
  _BqrAllTypeState createState() => _BqrAllTypeState();
}

class _BqrAllTypeState extends State<BqrAllType> {
  /*widget for each result*/
  Widget eachResultWig(SearchResponseModel each) {
    Color mycol = ((each.availableSeats > 0)
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
                // "${each.departureTime} ${widget.ftd.datePicked.format('M j')}",
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
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Flexible(
        //       child: Padding(
        //         padding: EdgeInsets.all(pdn),
        //         child: Text(
        //           each.source,
        //           style: TextStyle(fontSize: 18, color: Colors.grey[700]),
        //           overflow: TextOverflow.ellipsis,
        //         ),
        //       ),
        //     ),
        //     Flexible(
        //       child: Padding(
        //         padding: EdgeInsets.all(pdn),
        //         child: Text(
        //           each.destination,
        //           style: TextStyle(fontSize: 18, color: Colors.grey[700]),
        //           overflow: TextOverflow.ellipsis,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),

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
                    'Rs: ',
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
    return RefreshIndicator(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: widget.responseList.length,
          itemBuilder: (BuildContext context, int index) {
            var temp = widget.responseList[index];
            return TextButton(
              onPressed: () {
                onTapAnyResultAction(temp);
              },
              child: eachResultWig(temp),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            thickness: 1,
          ),
        ),
        onRefresh: () async {
          MyLib.myWaitingWidget(context);
          var tempListFuture =
              await ApiBackend.BookingQuerySearchCall(widget.ftd);
          Navigator.pop(context);
          setState(() {
            widget.responseList = tempListFuture;
          });
        });
  }

  refreshPage() async {
    ;
  }
}
