import 'dart:math';

import 'package:date_time_format/src/date_time_extension_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsgflutter/backend/api_backend.dart';
import 'package:gsgflutter/backend/search_request_model.dart';
import 'package:gsgflutter/backend/search_response_model.dart';
import 'package:gsgflutter/config/global_properties.dart';
import 'package:gsgflutter/mylib/my_lib.dart';
import 'package:gsgflutter/passenger_details/gender.dart';
import 'package:gsgflutter/passenger_details/mode_of_payment_enum.dart';
import 'package:gsgflutter/passenger_details/passenger_detain_model.dart';
import 'package:gsgflutter/review_journey_page/review_journey_page.dart';

class PassengerDetailsPage extends StatefulWidget {
  PassengerDetailsPage(
      {Key? key, required this.searchResponseModel, required this.ftd})
      : super(key: key);
  SearchRequestModel ftd;
  SearchResponseModel searchResponseModel;
  @override
  _PassengerDetailsPageState createState() => _PassengerDetailsPageState();
}

class _PassengerDetailsPageState extends State<PassengerDetailsPage> {
  //
  Widget busDetailsSection() {
    double pdn = 5;
    return Column(
      children: [
        ///Agency name
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(pdn),
          child: Text(widget.searchResponseModel.agencyName,
              style: TextStyle(fontSize: 15, color: Colors.grey[700]),
              overflow: TextOverflow.ellipsis),
        ),

        ///Bus name and bus number
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.directions_bus, color: Colors.black),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(pdn),
                child: Text(
                  "${widget.searchResponseModel.busName} (${widget.searchResponseModel.busNumber})",
                  style: TextStyle(fontSize: 20, color: Colors.grey[850]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),

        ///->
        const Divider(
          thickness: 3,
        ),

        ///Departure Arrival Schedule time
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///Departure time
            Padding(
              padding: EdgeInsets.all(pdn),
              child: Text(
                widget.searchResponseModel.departureTime,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold),
              ),
            ),

            ///Arrival time
            Padding(
              padding: EdgeInsets.all(pdn),
              child: Text(
                widget.searchResponseModel.arrivalTime,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),

        ///Departure Arrival Stops
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
                  widget.searchResponseModel.source,
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(
                Icons.arrow_right_alt_outlined,
                size: 30,
              ),
              Padding(
                padding: EdgeInsets.all(pdn),
                child: Text(
                  widget.searchResponseModel.destination,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
            ])
          ],
        ),

        ///Departure Arrival Schedule Dates
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///Departure Date
            Padding(
              padding: EdgeInsets.all(pdn),
              child: Text(
                widget.ftd.datePicked.format('l, M j'),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold),
              ),
            ),

            ///Arrival Date
            Padding(
              padding: EdgeInsets.all(pdn),
              child: Text(
                widget.ftd.datePicked.format('l, M j'),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),

        ///Available Seats now
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(pdn),
              child: Text(
                'AVAILABLE-${getCurrentAvlSeats()}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  ///passsenger secton Widget
  List<PassangerDetail> addPassengerList = [];
  Widget passengerSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Select Passenger",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Table(
          columnWidths: const {
            0: FractionColumnWidth(.15),
            1: FractionColumnWidth(.45),
            2: FractionColumnWidth(.1),
            3: FractionColumnWidth(.15),
            4: FractionColumnWidth(.15)
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
                Text("")
              ],
            )
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          itemCount: addPassengerList.length,
          itemBuilder: (contex, index) {
            return Table(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              columnWidths: const {
                0: FractionColumnWidth(.15),
                1: FractionColumnWidth(.45),
                2: FractionColumnWidth(.1),
                3: FractionColumnWidth(.1),
                4: FractionColumnWidth(.15)
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,

              children: [
                TableRow(
                  children: [
                    const Icon(Icons.person),
                    Text(
                      addPassengerList[index].name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${addPassengerList[index].age}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      (addPassengerList[index].gender == Gender.FEMALE)
                          ? "F"
                          : "M",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          addPassengerList.removeAt(index);
                        });
                      },
                      child: const Icon(Icons.delete),
                    )
                  ],
                )
              ],
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                addPassengerAction();
              },
              child: const Text(
                "+ Add New",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

//
  ModeOfPayment modeOfPayment = ModeOfPayment.CARD;
  Widget modeOfPaymentWig() {
    return Column(
      children: [
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Payment Mode",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            )
          ],
        ),
        Column(
          children: <Widget>[
            ListTile(
              title: const Text('Pay Through Credits/Debit Card'),
              leading: Radio<ModeOfPayment>(
                value: ModeOfPayment.CARD,
                groupValue: modeOfPayment,
                onChanged: (ModeOfPayment? value) {
                  setState(() {
                    modeOfPayment = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Pay Through Internet/Mobile Banking'),
              leading: Radio<ModeOfPayment>(
                value: ModeOfPayment.IB,
                groupValue: modeOfPayment,
                onChanged: (ModeOfPayment? value) {
                  setState(() {
                    modeOfPayment = value!;
                  });
                },
              ),
            ),
          ],
        )
      ],
    );
  }

//
  int passMobNum = 0;
  Widget passangerMobileNumberWig() {
    TextEditingController mobController = TextEditingController();
    return Column(
      children: [
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Passenger Mobile Number",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 15),
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "+91",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              child: TextFormField(
                style: const TextStyle(fontSize: 18),
                controller: mobController,
                decoration: const InputDecoration(hintText: '9876543210'),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
              ),
            )
          ],
        ),
        Table(
          children: const [
            TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "*Your E-Ticket will be sent to this Number and/or to your registered mobile number and email address",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Passanger Details",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          children: [
            scafoldBodyShorter(busDetailsSection()),
            scafoldBodyShorter(passengerSection()),
            scafoldBodyShorter(modeOfPaymentWig()),
            scafoldBodyShorter(passangerMobileNumberWig()),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            reviewDetailButtonAction();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Review Journey Details ",
                  style: TextStyle(
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Scafold body element shortener
  Widget scafoldBodyShorter(Widget child) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: child,
    );
  }

  ///latest available seats in this bus
  getCurrentAvlSeats() {
    return ApiBackend.getCurrentAvlSeats(widget.searchResponseModel);
  }

  ///AddPassanger button OnPress Mehtod
  void addPassengerAction() {
    if (addPassengerList.length >=
        min(5, int.parse(widget.searchResponseModel.availableSeats))) {
      //cannot add morethan 5 passenger at atime sorry;
      MyLib.myToast("cannot add more than 10 passenger at a time");
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Gender? gender = Gender.MALE;
        var nameController = TextEditingController();
        var ageController = TextEditingController();
        return AlertDialog(
          title: const Text('Add Passanger Details'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: 'Name'),
                      textCapitalization: TextCapitalization.words,
                    ),
                    TextFormField(
                      controller: ageController,
                      decoration: const InputDecoration(hintText: 'Age'),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Gender",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Radio<Gender>(
                          value: Gender.MALE,
                          groupValue: gender,
                          onChanged: (Gender? value) {
                            setState(
                              () {
                                gender = value;
                              },
                            );
                          },
                        ),
                        const Text("Male"),
                        Radio<Gender>(
                          value: Gender.FEMALE,
                          groupValue: gender,
                          onChanged: (Gender? value) {
                            setState(
                              () {
                                gender = value;
                              },
                            );
                          },
                        ),
                        const Text("Female"),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (nameController.text.isEmpty || ageController.text.isEmpty) {
                  MyLib.myToast("Please Fill Above Fields Properly");
                  return;
                }
                PassangerDetail p = PassangerDetail(nameController.text,
                    int.parse(ageController.text), gender!);
                setState(
                  () {
                    addPassengerList.add(p);
                  },
                );
                Navigator.pop(context);
              },
              child: const Text('+ Add New'),
            ),
          ],
        );
      },
    );
  }

  void reviewDetailButtonAction() {
    MyLib.myNewPage(
      context,
      ReviewJourneyPage(
        searchResponseModel: widget.searchResponseModel,
        ftd: widget.ftd,
        passengerList: addPassengerList,
        modeOfPayment: modeOfPayment,
      ),
    );
  }
}
