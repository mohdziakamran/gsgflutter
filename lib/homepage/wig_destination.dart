// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';

// class WigSource extends StatefulWidget {
//   const WigSource({Key? key}) : super(key: key);

//   @override
//   _WigFromState createState() => _WigFromState();
// }

// class _WigFromState extends State<WigSource> {
//   final TextEditingController _typeAheadController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return TypeAheadField(
//         textFieldConfiguration: TextFieldConfiguration(
//           decoration: const InputDecoration(labelText: 'From/Source Bus Stop'),
//           controller: _typeAheadController,
//         ),
//         suggestionsCallback: (pattern) async {
//           return await StateService.getSuggestions(pattern);
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
//           _typeAheadController.text = suggestion;
//         });
//   }
// }

// class StateService {
//   static final List<String> states = [
//     'ANDAMAN AND NICOBAR ISLANDS',
//     'ANDHRA PRADESH',
//     'ARUNACHAL PRADESH',
//     'ASSAM',
//     'BIHAR',
//     'CHATTISGARH',
//     'CHANDIGARH',
//     'DAMAN AND DIU',
//     'DELHI',
//     'DADRA AND NAGAR HAVELI',
//     'GOA',
//     'GUJARAT',
//     'HIMACHAL PRADESH',
//     'HARYANA',
//     'JAMMU AND KASHMIR',
//     'JHARKHAND',
//     'KERALA',
//     'KARNATAKA',
//     'LAKSHADWEEP',
//     'MEGHALAYA',
//     'MAHARASHTRA',
//     'MANIPUR',
//     'MADHYA PRADESH',
//     'MIZORAM',
//     'NAGALAND',
//     'ORISSA',
//     'PUNJAB',
//     'PONDICHERRY',
//     'RAJASTHAN',
//     'SIKKIM',
//     'TAMIL NADU',
//     'TRIPURA',
//     'UTTARAKHAND',
//     'UTTAR PRADESH',
//     'WEST BENGAL',
//     'TELANGANA',
//     'LADAKH'
//   ];
//   // ignore: slash_for_doc_comments
//   /**
//    * here we are supposed to make API GET calls to get the city lists
//    */
//   static List<String> getSuggestions(String query) {
//     List<String> matches = [];
//     matches.addAll(states);
//     matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
//     return matches;
//   }
// }
