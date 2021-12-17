import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gsgflutter/backend/api_backend.dart';

class WigInput extends StatefulWidget {
  TextEditingController typeAheadController;
  String lable;
  WigInput({Key? key, required this.lable, required this.typeAheadController})
      : super(key: key);

  @override
  _WigFromState createState() => _WigFromState();
}

class _WigFromState extends State<WigInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            labelText: widget.lable,
            icon: const Icon(
              Icons.pin_drop,
              color: Colors.green,
              size: 30,
            ),
          ),
          controller: widget.typeAheadController,
          style: const TextStyle(fontSize: 18),
        ),
        suggestionsCallback: (pattern) async {
          return await ApiBackend.getSuggestions(pattern);
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        itemBuilder: (BuildContext context, String suggestion) {
          return ListTile(
            title: Text(suggestion),
          );
        },
        onSuggestionSelected: (String suggestion) {
          widget.typeAheadController.text = suggestion;
        },
      ),
    );
  }
}
