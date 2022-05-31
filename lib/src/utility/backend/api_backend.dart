import 'dart:convert';
import 'dart:io';

import 'package:date_time_format/src/date_time_extension_methods.dart';
import 'package:gsgflutter/MyException.dart';
import 'package:gsgflutter/config/myconfig.dart';
import 'package:gsgflutter/src/model/search_request_model.dart';
import 'package:gsgflutter/src/model/search_response_model.dart';
import 'package:gsgflutter/src/model/signup_request_model.dart';
import 'package:gsgflutter/src/model/tid_response_model.dart';
import 'package:gsgflutter/src/model/user_model.dart';
import 'package:gsgflutter/src/utility/my_lib.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiBackend {
  static Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  ///* here we are supposed to make API GET calls to get the city lists
  static getSuggestionsApiCall() async {
    if (!(await hasNetwork())) {
      MyLib.myToast("No Internet");
    }
    List<String> resList = [];
    var uri = Uri.parse(ALLBUSSTOPURL);
    var response;
    try {
      response = await http.get(uri);
    } catch (e) {
      throw UnknownException();
    }
    if (response.statusCode == 200) {
      /**save the user model to shared prefrences */
      resList = List<String>.from(jsonDecode(response.body));
      return resList;
    } else {
      throw Exception(json.decode(response.body)['detail']);
    }
  }

  /// * here we are supposed to make API calls to get the Search query results
  static Future<List<SearchResponseModel>> bookingQuerySearchCall(
      SearchRequestModel ftd) async {
    if (!(await hasNetwork())) {
      throw NoInternetException();
    }
    List<SearchResponseModel> ls = [];
    try {
      var uri = Uri.parse(BOOKINGQUERYURL);
      var response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json'
        },
        body: json.encode(ftd.toJson()),
      );
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["result"];
      for (var each in data) {
        ls.add(SearchResponseModel.fromJson(each));
      }
    } catch (e) {
      throw UnknownException();
    }
    return ls;
  }

  /// API call for the current serts Avl
  static Future<int> getCurrentAvlSeats(SearchResponseModel sm) async {
    if (!(await hasNetwork())) {
      throw NoInternetException();
    }

    http.Response response;
    try {
      var uri = Uri.parse(CURRSEATSAVLURL);
      response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json'
        },
        body: json.encode({
          'bus_id': sm.id,
          'date': sm.dateOfJourney.format('Ymd'),
          'source': sm.source,
          'destination': sm.destination
        }),
      );
    } catch (e) {
      // print(e);
      throw UnknownException();
    }
    if (response.statusCode == 200) {
      int result = jsonDecode(response.body)['avl_seats'];
      return result;
    } else {
      throw Exception(json.decode(response.body)['detail']);
    }
  }

  ///====================================================================================
  ///                   ***USER SHARED Pref Methods start***
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
    if (!(await hasNetwork())) {
      throw NoInternetException();
    }
    var uri = Uri.parse(LOGINURL);
    var response;
    try {
      response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'accept': 'application/json'
          },
          body: json.encode({
            'email': email,
            'password': password,
          }));
    } catch (e) {
      throw UnknownException();
    }
    if (response.statusCode == 200) {
      /**save the user model to shared prefrences */
      ApiBackend.saveUserToSharedPref(jsonDecode(response.body));
    } else {
      // String message =
      //     'statuscode: ${response.statusCode} \nResponse-body: ${response.body}';
      // /**consoele output the error */
      // print(message);
      throw Exception(json.decode(response.body)['detail']);
    }
  }

  ///API call for signup http request post
  static Future<String> creatAccountRequest(SignUpRequestModel req) async {
    if (!(await hasNetwork())) {
      throw NoInternetException();
    }
    var uri = Uri.parse(SIGNUPURL);
    var response;
    try {
      response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'accept': 'application/json'
          },
          body: json.encode(req.toJson()));
    } catch (e) {
      throw UnknownException();
    }
    if (response.statusCode == 200) {
      /**Do nothing */
      return json.decode(response.body);
    } else {
      // String message =
      //     'statuscode: ${response.statusCode} \nResponse-body: ${response.body}';
      // /**consoele output the error */
      // print(message);
      throw Exception(json.decode(response.body)['detail']);
    }
  }

  ///Api call for Reset Password Request http post request
  static Future<String> forgotPasswordRequest(String email) async {
    if (!(await hasNetwork())) {
      throw NoInternetException();
    }
    var uri = Uri.parse(RESETPASSURL);
    var response;
    try {
      response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'accept': 'application/json'
          },
          body: json.encode({'email': email}));
    } catch (e) {
      throw UnknownException();
    }
    if (response.statusCode == 200) {
      /**Do nothing */
      return json.decode(response.body);
    } else {
      // String message =
      //     'statuscode: ${response.statusCode} \nResponse-body: ${response.body}';
      // /**consoele output the error */
      // print(message);
      throw Exception(json.decode(response.body)['detail']);
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
