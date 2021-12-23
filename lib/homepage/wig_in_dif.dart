// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:gsgflutter/backend/api_backend.dart';

// class WigInDif extends StatefulWidget {
//   TextEditingController typeAheadController;
//   WigInDif({Key? key, required this.typeAheadController}) : super(key: key);

//   @override
//   _WigFromState createState() => _WigFromState();
// }

// class _WigFromState extends State<WigInDif> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // margin: const EdgeInsets.all(8.0),
//       padding: const EdgeInsets.all(5.0),
//       child: TypeAheadField(
//         textFieldConfiguration: TextFieldConfiguration(
//             maxLines: 1,
//             controller: widget.typeAheadController,
//             style:
//                 const TextStyle(fontSize: 15, overflow: TextOverflow.ellipsis),
//             decoration: const InputDecoration(border: InputBorder.none)),
//         suggestionsCallback: (pattern) async {
//           return await ApiBackend.getSuggestions(pattern);
//         },
//         transitionBuilder: (context, suggestionsBox, controller) {
//           return suggestionsBox;
//         },
//         itemBuilder: (BuildContext context, String suggestion) {
//           return ListTile(
//             title: Text(suggestion),
//           );
//         },
//         onSuggestionSelected: (String suggestion) {
//           widget.typeAheadController.text = suggestion;
//         },
//       ),
//     );
//   }
// }
