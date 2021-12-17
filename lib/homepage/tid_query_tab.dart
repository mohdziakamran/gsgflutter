import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TidQueryTab extends StatefulWidget {
  const TidQueryTab({Key? key}) : super(key: key);

  @override
  _TidQueryTabState createState() => _TidQueryTabState();
}

class _TidQueryTabState extends State<TidQueryTab> {
  TextEditingController _textEditingController = TextEditingController();

  Widget searchButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green, // background
          onPrimary: Colors.white, // foreground
        ),
        //TODO add on press funtion
        onPressed: () {
          print(_textEditingController.text);
          // searchButtonAction(
          //   sourceInputController.text,
          //   destInputController.text,
          //   datePickerWig.dateSelected,
          // );
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextFormField(
            style: const TextStyle(fontSize: 20),
            controller: _textEditingController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(labelText: 'TID Number'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter TID Number';
              }
              return null;
            },
          ),
          searchButton(),
        ],
      ),
    );
  }
}
