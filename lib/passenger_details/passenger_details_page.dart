import 'dart:math';

import 'package:date_time_format/src/date_time_extension_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsgflutter/backend/api_backend.dart';
import 'package:gsgflutter/backend/search_request_model.dart';
import 'package:gsgflutter/backend/search_response_model.dart';
import 'package:gsgflutter/config/global_properties.dart';
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
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(pdn),
          child: Flexible(
            child: Text(
              widget.searchResponseModel.agencyName,
              style: TextStyle(fontSize: 15, color: Colors.grey[700]),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.directions_bus,
              color: Colors.black,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(pdn),
                    child: Flexible(
                      child: Text(
                        "${widget.searchResponseModel.busName} (${widget.searchResponseModel.busNumber})",
                        style: TextStyle(fontSize: 20, color: Colors.grey[850]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const Divider(
          thickness: 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(pdn),
              child: Text(
                "${widget.searchResponseModel.departureTime}", // ${ftd.datePicked.format('M j')}",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(pdn),
              child: Text(
                "${widget.searchResponseModel.arrivalTime}", // ${ftd.datePicked.format('M j')}",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(pdn),
                child: Text(
                  widget.searchResponseModel.source,
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(pdn),
                child: Text(
                  widget.searchResponseModel.destination,
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(pdn),
              child: Text(
                "${widget.ftd.datePicked.format('l, M j')}",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(pdn),
              child: Text(
                "${widget.ftd.datePicked.format('l, M j')}",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(pdn),
              child: Text(
                'AVAILABLE-${getCurrentAvlSeats()}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.baseline,
            //   textBaseline: TextBaseline.ideographic,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.all(5),
            //       child: Text(
            //         'Rs: ',
            //         style: TextStyle(fontSize: 20, color: Colors.green[800]),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(5),
            //       child: Text(
            //         each.fare,
            //         style: TextStyle(fontSize: 25, color: Colors.green[800]),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ],
    );
  }

  //passsenger secton
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
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Flexible(
                        child: Text(
                      addPassengerList[index].name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
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
                style: TextStyle(fontSize: 18),
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
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.grey.shade200,
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
              Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(8.0),
                color: Colors.white,
                child: modeOfPaymentWig(),
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(8.0),
                color: Colors.white,
                child: passangerMobileNumberWig(),
              ),
            ],
          ),
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

  getCurrentAvlSeats() {
    return ApiBackend.getCurrentAvlSeats(widget.searchResponseModel);
  }

  // void addPassengerAction() {}

  void addPassengerAction() {
    if (addPassengerList.length >=
        min(5, int.parse(widget.searchResponseModel.availableSeats))) {
      //cannot add morethan 5 passenger at atime sorry;
      Fluttertoast.showToast(
          msg: "cannot add more than 10 passenger at a time",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
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
                      // keyboardType: keyboard,
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
                  Fluttertoast.showToast(
                      msg: "Please Fill Above Fields Properly",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 16.0);
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewJourneyPage(
          searchResponseModel: widget.searchResponseModel,
          ftd: widget.ftd,
          passengerList: addPassengerList,
          modeOfPayment: modeOfPayment,
        ),
      ),
    );
  }
}
