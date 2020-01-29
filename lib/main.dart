import 'package:flutter/material.dart';
import 'package:flutter_app/screens/welcome_screen.dart';
import 'package:flutter_app/util/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: kBlue,
        secondaryHeaderColor: kYellow,
        canvasColor: Colors.blueGrey,
      ),
      home: WelcomeScreen(),
    );
  }
}
