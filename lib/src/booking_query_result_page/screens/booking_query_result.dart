import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gsgflutter/src/booking_query_result_page/screens/bqr_all_type_view.dart';
import 'package:gsgflutter/src/model/search_request_model.dart';
import 'package:gsgflutter/src/model/search_response_model.dart';
import 'package:gsgflutter/src/utility/theme.dart';

import 'bqr_agency_type_view.dart';

class BookingQueryResultPage extends StatefulWidget {
  SearchRequestModel ftd;
  TextEditingController originTAController;
  TextEditingController destTAController;
  List<SearchResponseModel> responseList;
  BookingQueryResultPage(
      {Key? key,
      required this.ftd,
      required this.originTAController,
      required this.destTAController,
      required this.responseList})
      : super(key: key);

  @override
  _BookingQueryResultPageState createState() => _BookingQueryResultPageState();
}

class _BookingQueryResultPageState extends State<BookingQueryResultPage> {
  bool isSwitched = false;
  var switchTextValue = 'Show All';

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        switchTextValue = 'Hide All';
      });
    } else {
      setState(() {
        isSwitched = false;
        switchTextValue = 'Show All';
      });
    }
  }

  ///
  String dropdownValue = 'Fare: Low to High';
  Widget dropDownFilterList(List<SearchResponseModel> responseList) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Sort by",
            style: TextStyle(fontSize: 18),
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.keyboard_arrow_down_sharp),
            elevation: 16,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 18),
            underline: Container(
              height: 2,
              // color: Colors.green,
              color: myTertiaryColor,
            ),
            isExpanded: true,
            onChanged: (String? newValue) {
              setState(
                () {
                  dropdownValue = newValue!;
                  if (newValue == 'Fare: Low to High') {
                    responseList.sort((a, b) => (a.fare).compareTo(b.fare));
                  } else if (newValue == 'Avl Seats: High to Low') {
                    responseList.sort((a, b) =>
                        (a.availableSeats).compareTo(b.availableSeats));
                  } else if (newValue == 'Duration: Low to High') {
                    ///TODO-> add absed on duration
                    responseList.sort((a, b) => (DateTimeRange(
                            start: a.departure, end: a.arrival)
                        .duration
                        .compareTo(
                            DateTimeRange(start: b.departure, end: b.arrival)
                                .duration)));
                  }
                },
              );
            },
            items: <String>[
              'Fare: Low to High',
              'Avl Seats: High to Low',
              'Duration: Low to High',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ))
      ],
    );
  }

  /// Body Widget sepertator
  Widget bodyWig(List<SearchResponseModel> responseList,
      Map<String, List<SearchResponseModel>> map) {
    if (responseList.isEmpty) {
      return const Center(
        child: Text(
          "No Result Found",
          style: TextStyle(
            fontSize: 25,
            color: Colors.grey,
          ),
        ),
      );
    } else {
      return Column(
        children: [
          ///Dropdown sory by
          (isSwitched) ? dropDownFilterList(responseList) : const Text(""),

          ///Children Widgets for list lown
          Expanded(
            child: (isSwitched)

                ///if switch is onn -> All list with ffilter criteria
                ? BqrAllType(responseList: responseList, ftd: widget.ftd)

                /// if switch is off -> all list under agency dropdown
                : BqrAgencyType(
                    responseListmap: map,
                  ),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ///response list from backend call

    ///Convert Response list to map
    Map<String, List<SearchResponseModel>> map = HashMap();
    for (SearchResponseModel r in widget.responseList) {
      String agency = r.agencyName;
      map.putIfAbsent(agency, () => []);
      map[agency]?.add(r);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Results", style: TextStyle(fontSize: 25)),
        centerTitle: true,
        toolbarHeight: 70, // default is 56

        ///toggle button
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.scale(
                    scale: 1.2,
                    child: Column(
                      children: [
                        Switch(
                          onChanged: toggleSwitch,
                          value: isSwitched,
                          activeColor: Colors.white,
                          activeTrackColor: Colors.grey.shade300,
                          inactiveThumbColor: Colors.grey.shade400,
                          inactiveTrackColor: Colors.grey.shade300,
                        ),
                        Text(
                          switchTextValue,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
      body: bodyWig(widget.responseList, map),
    );
  }
}
