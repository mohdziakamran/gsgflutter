import 'package:flutter/material.dart';

import 'package:gsgflutter/theme.dart';
import 'homepage/my_home_page.dart';

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
