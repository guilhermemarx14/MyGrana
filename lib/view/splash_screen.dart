import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/profile.dart';
import 'package:flutter_app/view/home_screen.dart';
import 'package:flutter_app/view/welcome_screen.dart';
import 'package:flutter_app/database/Database1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    DBProvider.db.initDB();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time');

    var _duration = new Duration(seconds: 3);

    if (firstTime != null && !firstTime) {
      return new Timer(_duration, navigationPageHome);
    } else {
      // First time

      return new Timer(_duration, navigationPageWel);
    }
  }

  double total;
  @override
  void initState() {
    super.initState();
    startTime();
  }

  void navigationPageHome() {
    Profile.getProfile().then((user) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => HomeScreen()), (r) => false);
    });
  }

  void navigationPageWel() {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()), (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/Xopete.png',
      fit: BoxFit.fill,
    );
  }
}
