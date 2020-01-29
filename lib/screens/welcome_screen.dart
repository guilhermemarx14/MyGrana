import 'package:flutter/material.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_app/components/continue_button.dart';
import 'package:flutter_app/components/back_button.dart' as back;
import 'data_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
