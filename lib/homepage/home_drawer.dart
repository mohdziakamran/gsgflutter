import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gsgflutter/theme.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: myTertiaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 150,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: mySecondaryColor,
              ),
              child: drawerHeaderWig(),
            ),
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
          mytiles(
            Icons.settings,
            'Settings',
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
        ],
      ),
    );
  }

  Widget drawerHeaderWig() {
    return Row(
      children: [
        Icon(
          Icons.person_pin,
          size: 70,
          color: myPrimaryColor,
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "Log In \nor\nSign Up?",
            style: TextStyle(fontSize: 20, color: myPrimaryColor),
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
