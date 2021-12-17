import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gsgflutter/backend/search_request_model.dart';
import 'package:gsgflutter/backend/search_response_model.dart';
import 'package:intl/intl.dart';

class ApiBackend {
  static final List<String> states = [
    'ANDAMAN AND NICOBAR ISLANDS',
    'ANDHRA PRADESH',
    'ARUNACHAL PRADESH',
    'ASSAM',
    'BIHAR',
    'CHATTISGARH',
    'CHANDIGARH',
    'DAMAN AND DIU',
    'DELHI',
    'DADRA AND NAGAR HAVELI',
    'GOA',
    'GUJARAT',
    'HIMACHAL PRADESH',
    'HARYANA',
    'JAMMU AND KASHMIR',
    'JHARKHAND',
    'KERALA',
    'KARNATAKA',
    'LAKSHADWEEP',
    'MEGHALAYA',
    'MAHARASHTRA',
    'MANIPUR',
    'MADHYA PRADESH',
    'MIZORAM',
    'NAGALAND',
    'ORISSA',
    'PUNJAB',
    'PONDICHERRY',
    'RAJASTHAN',
    'SIKKIM',
    'TAMIL NADU',
    'TRIPURA',
    'UTTARAKHAND',
    'UTTAR PRADESH',
    'WEST BENGAL',
    'TELANGANA',
    'LADAKH'
  ];
  // ignore: slash_for_doc_comments
  /**
   * here we are supposed to make API GET calls to get the city lists
   */
  static List<String> getSuggestions(String query) {
    List<String> matches = [];
    matches.addAll(states);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  // ignore: slash_for_doc_comments
  /** 
   * here we are supposed to make API calls to get the Search query results
   */
  static List<SearchResponseModel> BookingQuerySearchCall(
      SearchRequestModel ftd) {
    /**
         * Do the HTTP POST call
         */

    List<SearchResponseModel> ls = [];
    for (int i = 0; i < 15; i++) {
      ls.add(SearchResponseModel(
          ftd.from,
          ftd.to,
          DateUtils.dateOnly(DateTime.now()).toString(),
          "Bus-No.1234",
          "BUS NAME",
          "Agency Name",
          "10",
          DateFormat.Hm().format(DateTime.now()).toString(),
          DateFormat.Hm().format(DateTime.now()).toString(),
          "100"));
    }
    return ls;
  }

  /// API call for the current serts Avl
  static int getCurrentAvlSeats(SearchResponseModel sm) {
    return 54;
  }
}
