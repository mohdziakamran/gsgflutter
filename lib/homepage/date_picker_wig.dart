import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerWig extends StatefulWidget {
  DatePickerWig({Key? key}) : super(key: key);

  DateTime dateSelected = DateTime.now();

  @override
  _DatePickerWigState createState() => _DatePickerWigState();
}

class _DatePickerWigState extends State<DatePickerWig> {
  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().day - 1),
            lastDate: DateTime(DateTime.now().year + 1))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        widget.dateSelected = pickedDate;
      });
    });
  }

  // late DateTime _dateTime;
  // @override
  // void initState() {
  //   super.initState();
  //   _dateTime = DateTime.now();
  // }
  // _pickTime() async {
  //   DateTime? d = await showDatePicker(
  //     context: context,
  //     initialDate: _dateTime,
  //     firstDate: DateTime(DateTime.now().year - 5),
  //     lastDate: DateTime(DateTime.now().year + 5),
  //   );
  //   if (d != null) {
  //     setState(() {
  //       _dateTime = d;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: TextButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green[100], // background
            onPrimary: Colors.green[900], // foreground
          ),
          onPressed: _pickDateDialog,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.calendar_today,
                    size: 20,
                  ),
                  Text(
                    " Jorney Date",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.ideographic,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          widget.dateSelected.day.toString(),
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          DateFormat('MMMM').format(widget.dateSelected),
                          style: const TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  Text(
                    DateFormat('EEEE').format(widget.dateSelected),
                    style: const TextStyle(fontSize: 30),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
