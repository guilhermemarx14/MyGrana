import 'package:flutter/material.dart';
import 'package:flutter_app/components/continue_button.dart';
import 'package:flutter_app/util/Database2.dart';
import 'package:flutter_app/util/constants.dart';

import 'data_screen.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var res = [];
    DBProvider2.db.getProfilesList().then((item) => res.add(item));
    if (res.isNotEmpty)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    return Scaffold(
      backgroundColor: kBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                'Para iniciar precisaremos de alguns dados pessoais.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kWhite,
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ContinueButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DataScreen()),
              );
            },
            text: 'Continuar',
            width: 150.0,
            height: 50,
          ),
        ],
      ),
    );
  }
}
