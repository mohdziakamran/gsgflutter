import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyLib {
  ///flutter toast
  static myToast(String string) {
    return Fluttertoast.showToast(
        msg: string,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  ///redirect to new material page
  static myNewPage(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }
}
