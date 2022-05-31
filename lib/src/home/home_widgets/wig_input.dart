import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gsgflutter/MyException.dart';
import 'package:gsgflutter/src/utility/backend/api_backend.dart';
import 'package:gsgflutter/src/utility/my_lib.dart';
import 'package:gsgflutter/src/utility/theme.dart';
import 'package:http/http.dart' as http;

class WigInput extends StatefulWidget {
  TextEditingController typeAheadController;
  String lable;
  static List<String> states = [];
  WigInput({Key? key, required this.lable, required this.typeAheadController})
      : super(key: key);

  @override
  _WigFromState createState() => _WigFromState();
}

class _WigFromState extends State<WigInput> {
  @override
  void initState() {
    super.initState();
    WigInput.states.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            labelText: widget.lable,
            // icon: Icon(
            //   Icons.pin_drop,
            //   // color: Colors.green,
            //   color: myTertiaryColor,
            //   size: 30,
            // ),
          ),
          controller: widget.typeAheadController,
          style: const TextStyle(fontSize: 18),
        ),
        suggestionsCallback: (pattern) async {
          // return await ApiBackend.getSuggestions(pattern);
          if (WigInput.states.isEmpty) {
            try {
              WigInput.states =
                  await ApiBackend.getSuggestionsApiCall() as List<String>;
            } on UnknownException catch (e) {
              MyLib.myToast(e.message);
            } catch (e) {
              //do nothing
            }
          }
          List<String> matches = [];
          matches.addAll(WigInput.states);
          matches.retainWhere(
              (s) => s.toLowerCase().contains(pattern.toLowerCase()));
          return matches;
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
