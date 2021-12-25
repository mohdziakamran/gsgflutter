import 'dart:convert';

import 'package:date_time_format/src/date_time_extension_methods.dart';
import 'package:gsgflutter/config/myconfig.dart';
import 'package:gsgflutter/src/model/search_request_model.dart';
import 'package:gsgflutter/src/model/search_response_model.dart';
import 'package:gsgflutter/src/model/signup_request_model.dart';
import 'package:gsgflutter/src/model/tid_response_model.dart';
import 'package:gsgflutter/src/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiBackend {
  ///* here we are supposed to make API GET calls to get the city lists
  static getSuggestionsApiCall() async {
    List<String> resList = [];
    try {
      var uri = Uri.parse(ALLBUSSTOPURL);
      var response = await http.get(uri);
      resList = List<String>.from(jsonDecode(response.body));
    } catch (e) {
      print(e);
    }
    return resList;
  }

  /// * here we are supposed to make API calls to get the Search query results
  static Future<List<SearchResponseModel>> BookingQuerySearchCall(
      SearchRequestModel ftd) async {
    List<SearchResponseModel> ls = [];
    try {
      var uri = Uri.parse(BOOKINGQUERYURL);
      var response = await http.post(
        uri,
        body: ftd.toJson(),
      );
      var l = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      for (var each in l) {
        ls.add(SearchResponseModel.fromJson(each));
      }
    } catch (e) {
      print(e); ////////////////////
    }
    return ls;
  }

  /// API call for the current serts Avl
  static Future<int> getCurrentAvlSeats(SearchResponseModel sm) async {
    int result = 0;
    try {
      var uri = Uri.parse(CURRSEATSAVLURL);
      var response = await http.post(
        uri,
        body: {
          'busNumber': sm.busNumber,
          'date': sm.dateOfJourney.format('Y-m-j'),
          'source': sm.source,
          'destination': sm.destination
        },
      );
      result = int.parse(jsonDecode(response.body)['AvlSeats'] as String);
      // print('####$result');
    } catch (e) {
      print(e);
    }
    return result;
  }

  ///===========================================================
  ///                   ***Pref Methods start***
  ///

  ///save user to shared prefrence
  ///@param json decode map
  static saveUserToSharedPref(Map<String, dynamic> jsonDecodedResponse) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    String user = jsonEncode(User.fromJson(jsonDecodedResponse));
    sharedUser.setString('user', user);
  }

  ///get user from shared prefrence
  ///@param [json decode map]
  static Future<User> getUserFromSharedPref() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = jsonDecode(sharedUser.getString('user')!);
    User user = User.fromJson(userMap);
    return user;
  }

  ///check is Logedin from shared prefrence
  ///@param
  static Future<bool> isLogedin() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    return sharedUser.containsKey('user');
  }

  ///check is Logedin from shared prefrence
  ///@param
  static Future<bool> clearUserFromSharedPref() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    return sharedUser.remove('user');
  }

  ///                   ***end***
  ///--------------------------------------------------
  ///

  ///Send Api Post request to Login user
  static Future<void> sendLoginRequest(String email, String password) async {
    var uri = Uri.parse(LOGINURL);
    var response = await http.post(
      uri,
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      /**save the user model to shared prefrences */
      ApiBackend.saveUserToSharedPref(jsonDecode(response.body));
    } else {
      String message =
          'statuscode: ${response.statusCode} \nResponse-body: ${response.body}';
      /**consoele output the error */
      print(message);
      throw Exception(message);
    }
  }

  ///API call for signup http request post
  static Future<void> creatAccountRequest(SignUpRequestModel req) async {
    var uri = Uri.parse(SIGNUPURL);
    var response = await http.post(
      uri,
      body: req.toJson(),
    );
    if (response.statusCode == 200) {
      /**Do nothing */
    } else {
      String message =
          'statuscode: ${response.statusCode} \nResponse-body: ${response.body}';
      /**consoele output the error */
      print(message);
      throw Exception(message);
    }
  }

  ///Api call for Reset Password Request http post request
  static Future<void> forgotPasswordRequest(String email) async {
    var uri = Uri.parse(RESETPASSURL);
    var response = await http.post(
      uri,
      body: {'email': email},
    );
    if (response.statusCode == 200) {
      /**Do nothing */
    } else {
      String message =
          'statuscode: ${response.statusCode} \nResponse-body: ${response.body}';
      /**consoele output the error */
      print(message);
      throw Exception(message);
    }
  }

  static Future<TidQueryResponseModel> sendTidQueryRequest(String tid) async {
    var uri = Uri.parse(TIDQUERYURL);
    var response = await http.post(
      uri,
      body: {'tid': tid},
    );
    if (response.statusCode == 200) {
      /**Do creat response object and return */
      TidQueryResponseModel responseModel =
          TidQueryResponseModel.fromJson(json.decode(response.body));
      return responseModel;
    } else {
      String message =
          'statuscode: ${response.statusCode} \nResponse-body: ${response.body}';
      /**consoele output the error */
      print(message);
      throw Exception(message);
    }
  }
}
