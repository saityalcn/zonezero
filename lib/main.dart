import 'package:flutter/material.dart';
import 'package:zonezero/screens/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF4F4F4),
        primarySwatch: Colors.blue,
        fontFamily: 'Quicksand'
      ),
      home: HomeScreen()
    );
  }
}

