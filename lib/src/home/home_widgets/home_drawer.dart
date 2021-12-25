import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsgflutter/src/login_signup_reset/screens/login.dart';
import 'package:gsgflutter/src/model/user_model.dart';
import 'package:gsgflutter/src/utility/backend/api_backend.dart';
import 'package:gsgflutter/src/utility/my_lib.dart';
import 'package:gsgflutter/src/utility/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDrawer extends StatefulWidget {
  HomeDrawer({Key? key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  // initstate() {
  //   // MyLib.myWaitingWidget(context);
  //   checkLogedin();
  //   // Navigator.pop(context);
  // }
  bool islogedin = false;
  String uname = "";
  String uemail = "";
  @override
  void initState() {
    super.initState();
    checkLogedin();
  }

//check is logedin

  ///
  Future<void> checkLogedin() async {
    print("************");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      islogedin = prefs.containsKey('user');
      if (islogedin) {
        Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
        User user = User.fromJson(userMap);
        uname = user.name;
        uemail = user.email;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: myTertiaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: drawerBodyWig(),
      ),
    );
  }

  ///List of widget for drawer body
  List<Widget> drawerBodyWig() {
    List<Widget> ls = [];
    //added Header
    ls.add(DrawerHeader(
      decoration: BoxDecoration(
        color: mySecondaryColor,
      ),
      child: drawerHeaderWig(),
    )
        // SizedBox(
        //   height: 150,
        //   child: DrawerHeader(
        //     decoration: BoxDecoration(
        //       color: mySecondaryColor,
        //     ),
        //     child: drawerHeaderWig(),
        //   ),
        // ),
        //     UserAccountsDrawerHeader(
        //   // currentAccountPicture: Icon(
        //   //   Icons.person_pin,
        //   //   size: 70,
        //   //   color: myPrimaryColor,
        //   // ),
        //   accountName: Text(uname),
        //   accountEmail: Text(uemail),
        // )
        );
    /**add my tickets in body list if logedin*/
    if (islogedin) {
      ls.addAll([
        ///My Profile tiles
        mytiles(
          CupertinoIcons.profile_circled,
          'My Profile',
          () {
            ///do somthing
            Navigator.pop(context);
          },
        ),

        ///My Tickets tiles
        mytiles(
          CupertinoIcons.tickets,
          'My Tickets',
          () {
            ///do somthing
            Navigator.pop(context);
          },
        ),

        ///setting
        mytiles(
          Icons.settings,
          'Settings',
          () {
            ///do somthing
            Navigator.pop(context);
          },
        ),
      ]);
    }

    /** add widget for not logedin */
    ls.addAll([
      ///share Us
      mytiles(
        Icons.share,
        'Share Us',
        () {
          ///do somthing
          Navigator.pop(context);
        },
      ),
      mytiles(
        Icons.bug_report,
        'Report Bug',
        () {
          ///do somthing
          Navigator.pop(context);
        },
      ),
      Divider(),
      mytiles(
        Icons.info_outline,
        'About Us',
        () {
          ///do somthing
          Navigator.pop(context);
        },
      ),
    ]);
    /**Logout button */
    if (islogedin) {
      ls.add(
        mytiles(
          Icons.logout,
          'Logout',
          () {
            ///do somthing
            Navigator.pop(context);
            setState(() {
              ApiBackend.clearUserFromSharedPref();
              MyLib.myToast("Logout Sucessful");
            });
          },
        ),
      );
    }

    return ls;
  }

  ///Drawer Header widget
  Widget drawerHeaderWig() {
    if (islogedin) {
      var textStyle = const TextStyle(
        fontSize: 20,
      );
      return TextButton(
          onPressed: () {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.ideographic,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.person_pin,
                size: 70,
                color: myPrimaryColor,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      uname,
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      uemail,
                      style: textStyle,
                    ),
                  ],
                ),
              )
            ],
          ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          Icons.person_pin,
          size: 70,
          color: myPrimaryColor,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
                    context, MaterialPageRoute(builder: (_) => LogInScreen()))
                .then((_) => setState(() {
                      checkLogedin();
                    }));
          },
          child: const Text(
            "Log In ?",
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  ListTile mytiles(IconData icon, String text, void Function() func) {
    return ListTile(
      iconColor: Colors.white,
      leading: Icon(icon),
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      onTap: func,
    );
  }
}
