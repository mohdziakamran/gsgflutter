import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsgflutter/booking_query_result_page/booking_query_result.dart';
import 'package:gsgflutter/homepage/date_picker_wig.dart';
import 'package:gsgflutter/backend/search_request_model.dart';
import 'package:gsgflutter/homepage/wig_input.dart';
import 'package:gsgflutter/mylib/my_lib.dart';

class BookingQueryTab extends StatefulWidget {
  const BookingQueryTab({Key? key}) : super(key: key);
  @override
  _BookingQueryTabState createState() => _BookingQueryTabState();
}

class _BookingQueryTabState extends State<BookingQueryTab> {
  @override
  Widget build(BuildContext context) {
    var sourceInputController = TextEditingController(),
        destInputController = TextEditingController();

    var sourceInputWidget = WigInput(
      lable: 'From/ Source',
      typeAheadController: sourceInputController,
    );

    var destinationInputWidget = WigInput(
      lable: 'To/ Destination',
      typeAheadController: destInputController,
    );

    var datePickerWig = DatePickerWig();

    void searchButtonAction(
        String source, String destination, DateTime datePicked) {
      SearchRequestModel tmp =
          SearchRequestModel(source, destination, datePicked);
      if (source.isEmpty || destination.isEmpty) {
        MyLib.myToast("Please Fill Above Fields Properly");
        return;
      }
      MyLib.myNewPage(
          context,
          BookingQueryResultPage(
            ftd: tmp,
            originTAController: sourceInputController,
            destTAController: destInputController,
          ));
    }

    /**
     * add missing onpres func
     */
    var searchButton = Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green, // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: () {
          searchButtonAction(
            sourceInputController.text,
            destInputController.text,
            datePickerWig.dateSelected,
          );
        },
        child: Container(
          // margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(10.0),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
              Text(
                'Search',
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            sourceInputWidget,
            destinationInputWidget,
            datePickerWig,
            searchButton,
            const Text("~this is end~")
          ],
        ),
      ),
    );
  }
}
