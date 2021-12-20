import 'package:flutter/material.dart';
import 'package:gsgflutter/config/global_properties.dart';
import 'package:gsgflutter/homepage/booking_query_tab.dart';
import 'package:gsgflutter/homepage/home_drawer.dart';
import 'package:gsgflutter/homepage/tid_query_tab.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "BOOKING",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "TID Query",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          title: const Text(GlobalProperties.myTitle),
        ),
        drawer: HomeDrawer(),
        body: const TabBarView(children: [
          BookingQueryTab(),
          TidQueryTab(),
        ]),
      ),
    );
  }
}
