import 'package:date_time_format/src/date_time_extension_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsgflutter/src/model/gender.dart';
import 'package:gsgflutter/src/model/tid_response_model.dart';

class TidQueryResultScreen extends StatefulWidget {
  TidQueryResponseModel responseModel;
  TidQueryResultScreen({Key? key, required this.responseModel})
      : super(key: key);

  @override
  _TidQueryResultScreenState createState() => _TidQueryResultScreenState();
}

class _TidQueryResultScreenState extends State<TidQueryResultScreen> {
  ///Busdetails Section
  Widget busDetailsSection() {
    double pdn = 5;
    return Column(
      children: [
        /**agencyname widget */
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(pdn),
          child: Text(
            widget.responseModel.agency,
            style: TextStyle(fontSize: 15, color: Colors.grey[700]),
            overflow: TextOverflow.ellipsis,
          ),
        ),

        /**buslogo bus name bus number */
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.directions_bus,
              color: Colors.black,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(pdn),
                child: Text(
                  "${widget.responseModel.busName} (${widget.responseModel.busNumber})",
                  style: TextStyle(fontSize: 20, color: Colors.grey[850]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              CupertinoIcons.number_square,
              color: Colors.black,
            ),
            Padding(
              padding: EdgeInsets.all(pdn),
              child: Text(
                "TID:",
                style: TextStyle(fontSize: 20, color: Colors.grey[850]),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(pdn),
                child: Text(
                  "${widget.responseModel.tid}",
                  style: TextStyle(fontSize: 20, color: Colors.grey[850]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
        /**line divide */
        const Divider(
          thickness: 3,
        ),
        /**departure details widgets list */
        Table(
          children: [
            TableRow(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(pdn),
                      child: Text(
                        "Departure Details",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 20,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(pdn),
                      child: Text(
                        "${widget.responseModel.departure.format('H:i')} ${widget.responseModel.departure.format('M j, l')}",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(pdn),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.my_location),
                            ),
                            Expanded(
                              child: Text(
                                widget.responseModel.source,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey[700]),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ],
            ),
            /**Arrival details widgets list */
            TableRow(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(pdn),
                      child: Text(
                        "Arrival Details",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 20,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(pdn),
                      child: Text(
                        "${widget.responseModel.arrival.format('H:i')} ${widget.responseModel.arrival.format('M j, l')}",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(pdn),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.my_location),
                            ),
                            Text(
                              widget.responseModel.destination,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[700]),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  //passsenger secton
  Widget passengerSection() {
    return Column(
      children: [
        /**Title widget for passenger details */
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Passenger Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        /**line deivider */
        const Divider(
          thickness: 3,
        ),
        /**person or passenger list builder */
        Table(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          columnWidths: const {
            0: FractionColumnWidth(.15),
            1: FractionColumnWidth(.50),
            2: FractionColumnWidth(.1),
            3: FractionColumnWidth(.15),
          },
          children: const [
            TableRow(
              children: [
                Text(""),
                Text(
                  "Name",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Age",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Gen",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          itemCount: widget.responseModel.passengerList.length,
          itemBuilder: (contex, index) {
            return Table(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              columnWidths: const {
                0: FractionColumnWidth(.15),
                1: FractionColumnWidth(.50),
                2: FractionColumnWidth(.1),
                3: FractionColumnWidth(.15),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,

              children: [
                TableRow(
                  children: [
                    const Icon(Icons.person),
                    Text(
                      widget.responseModel.passengerList[index].name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${widget.responseModel.passengerList[index].age}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      (widget.responseModel.passengerList[index].gender ==
                              Gender.FEMALE)
                          ? "FEMALE"
                          : "MALE",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Total Amount Paid: Rs ${widget.responseModel.paidAmount}\nTotal Number of Seats: ${widget.responseModel.passengerList.length}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: const [
            Text(
              "Ticker Query",
              style: TextStyle(
                fontSize: 23,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(8.0),
              color: Colors.white,
              child: busDetailsSection(),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(8.0),
              color: Colors.white,
              child: passengerSection(),
            ),
            ElevatedButton(
                onPressed: () {
                  downloadTicketAction();
                },
                child: Text("Download Ticket"))
          ],
        ),
      ),
    );
  }

  ///Download ticket action button
  ///onpress generate ticket with uniqueID
  void downloadTicketAction() {}
}
