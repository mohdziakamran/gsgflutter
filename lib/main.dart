import 'package:flutter/material.dart';
import 'package:gsgflutter/src/home/home_screen/my_home_screen.dart';
import 'package:gsgflutter/src/utility/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // debugPaintSizeEnabled = true;
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: generateMaterialColorFromColor(Colors.teal.shade900),
      ),
      home: const MyHomePage(),
      // home: LogInScreen(),
    );
  }
}
