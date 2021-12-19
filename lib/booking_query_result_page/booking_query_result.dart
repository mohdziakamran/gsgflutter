import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gsgflutter/backend/api_backend.dart';
import 'package:gsgflutter/backend/search_response_model.dart';
import 'package:gsgflutter/booking_query_result_page/bqr_all_type.dart';
import 'package:gsgflutter/config/global_properties.dart';
import 'package:gsgflutter/backend/search_request_model.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:gsgflutter/homepage/wig_in_dif.dart';
import 'package:gsgflutter/mylib/my_lib.dart';
import 'package:gsgflutter/passenger_details/passenger_details_page.dart';

import 'bqr_agency_type.dart';

class BookingQueryResultPage extends StatefulWidget {
  SearchRequestModel ftd;
  TextEditingController originTAController;
  TextEditingController destTAController;
  BookingQueryResultPage(
      {Key? key,
      required this.ftd,
      required this.originTAController,
      required this.destTAController})
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
              color: Colors.green,
            ),
            isExpanded: true,
            onChanged: (String? newValue) {
              setState(
                () {
                  dropdownValue = newValue!;
                  if (newValue == 'Fare: Low to High') {
                    responseList.sort((a, b) =>
                        int.parse(a.fare).compareTo(int.parse(b.fare)));
                  } else if (newValue == 'Avl Seats: High to Low') {
                    responseList.sort((a, b) => int.parse(a.availableSeats)
                        .compareTo(int.parse(b.availableSeats)));
                  } else if (newValue == 'Duration: Low to High') {
                    ///TODO-> add absed on duration
                    // responseList.sort((a, b) => int.parse(a.availableSeats)
                    //     .compareTo(int.parse(b.availableSeats)));
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
                ? BqrAllType(
                    ftd: widget.ftd,
                    responseList: responseList,
                  )

                /// if switch is off -> all list under agency dropdown
                : BqrAgencyType(
                    responseListmap: map,
                    ftd: widget.ftd,
                  ),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ///response list from backend call
    var responseList = ApiBackend.BookingQuerySearchCall(widget.ftd);

    ///Convert Response list to map
    Map<String, List<SearchResponseModel>> map = HashMap();
    for (SearchResponseModel r in responseList) {
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
      body: bodyWig(responseList, map),
    );
  }
}
