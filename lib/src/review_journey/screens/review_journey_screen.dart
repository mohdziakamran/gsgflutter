import 'package:date_time_format/src/date_time_extension_methods.dart';
import 'package:flutter/material.dart';
import 'package:gsgflutter/src/model/gender.dart';
import 'package:gsgflutter/src/model/mode_of_payment_enum.dart';
import 'package:gsgflutter/src/model/passenger.dart';
import 'package:gsgflutter/src/model/search_response_model.dart';
import 'package:gsgflutter/src/utility/backend/api_backend.dart';
import 'package:gsgflutter/src/utility/my_lib.dart';

import '../../../MyException.dart';

class ReviewJourneyPage extends StatefulWidget {
  ReviewJourneyPage(
      {Key? key,
      required this.searchResponseModel,
      required this.modeOfPayment,
      required this.passengerList})
      : super(key: key);
  SearchResponseModel searchResponseModel;
  List<Passanger> passengerList;
  ModeOfPayment modeOfPayment;

  @override
  _ReviewJourneyPageState createState() => _ReviewJourneyPageState();
}

class _ReviewJourneyPageState extends State<ReviewJourneyPage> {
  ///Busdetails Section
  Widget busDetailsSection() {
    double pdn = 5;
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(pdn),
          child: Text(
            widget.searchResponseModel.agencyName,
            style: TextStyle(fontSize: 15, color: Colors.grey[700]),
            overflow: TextOverflow.ellipsis,
          ),
        ),
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
                  "${widget.searchResponseModel.busName} (${widget.searchResponseModel.busNumber})",
                  style: TextStyle(fontSize: 20, color: Colors.grey[850]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
        const Divider(
          thickness: 3,
        ),
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
                        "${widget.searchResponseModel.departure.format('H:i')} ${widget.searchResponseModel.departure.format('M j, l')}",
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
                                widget.searchResponseModel.source,
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
                        "${widget.searchResponseModel.arrival.format('H:i')} ${widget.searchResponseModel.arrival.format('M j, l')}",
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
                              widget.searchResponseModel.destination,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(pdn),
              child: Text(
                'AVAILABLE SEATS-${widget.searchResponseModel.availableSeats}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                MyLib.myWaitingWidget(context);
                try {
                  int j = await ApiBackend.getCurrentAvlSeats(
                      widget.searchResponseModel);
                  setState(() {
                    widget.searchResponseModel.availableSeats = j;
                  });
                } on NoInternetException catch (e) {
                  Navigator.pop(context);
                  MyLib.myToast(e.message);
                  return;
                } on Exception catch (e) {
                  Navigator.pop(context);
                  MyLib.mySnackbar(context, e.toString().split(": ")[1]);
                  return;
                }
                Navigator.pop(context);
                MyLib.myToast("Updated Successfully");
              },
              child: const Icon(
                Icons.refresh_outlined,
                color: Colors.green,
              ),
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
        const Divider(
          thickness: 3,
        ),
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
          itemCount: widget.passengerList.length,
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
                      widget.passengerList[index].name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${widget.passengerList[index].age}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      (widget.passengerList[index].gender == Gender.FEMALE)
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
              "Total Fare: ETB ${widget.searchResponseModel.fare * widget.passengerList.length}",
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

  ///mode of payment section
  bool isCheckedSelfValidation = false;
  Widget modeOfPaymentSection() {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.green;
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                // "Payment Method Details",
                "Acknowledgement",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Table(
          children: [
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    // "Mode of payment Seelcted ${widget.modeOfPayment} ",
                    "Please confirm that Above information is legitmitane as per your Knoweledge and you Agerre to our terms and condition",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Table(
          columnWidths: const {
            0: FractionColumnWidth(.1),
            1: FractionColumnWidth(.8),
          },
          children: [
            TableRow(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isCheckedSelfValidation,
                  onChanged: (bool? value) {
                    setState(() {
                      isCheckedSelfValidation = value!;
                    });
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      "I confirm all the information provided above is correct."),
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
        title: Column(
          children: const [
            Text(
              "REVIEW JOURNEY",
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
            Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(8.0),
              color: Colors.white,
              child: modeOfPaymentSection(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            goToPaymentAction();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "PAYMENT ",
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

//while is check not true raise a toast to check the checkbox
//on press-> popup to confirm to pre=oceed then redirect to respective payment page
  void goToPaymentAction() {
    if (isCheckedSelfValidation) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Confirm Payment'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This will take you to Payment page.'),
                Text('Would you like to confirm to go for payment?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, 'Cancel');
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.pop(context, 'Ok');
                MyLib.myNewPage(context, const Text("Not Implemented yet!!!"));
              },
            ),
          ],
        ),
      );
    } else {
      MyLib.myToast("Please select the Check box first");
    }
  }
}
