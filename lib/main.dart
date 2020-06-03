import 'package:flutter/material.dart';
import 'package:flutter_app/view/splash_screen.dart';
import 'package:flutter_app/util/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {//todo transicoes
    return MaterialApp(
      theme: ThemeData(
        primaryColor: kBlue,
        secondaryHeaderColor: Colors.blue.shade900,
        canvasColor: kBackground,
      ),
      home: SplashScreen(),
      
    );
  }
}

