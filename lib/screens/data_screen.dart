import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/components/continue_button.dart';
import 'package:flutter_app/model/profile.dart';
import 'package:flutter_app/screens/origin_screen.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:toast/toast.dart';
import 'state_screen.dart';



class DataScreen extends StatelessWidget {

final Profile _profile = Profile();

  DataScreen() {
    _profile.plataforma = Platform.isIOS ? 'ios' : 'android';
  }

  @override
  Widget build(BuildContext context) {
    String nome;
    final myController = TextEditingController();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Xopete2.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Nome',
                    style: kFormStyle,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 3.0, color: kWhite),
                      ),
                    ),
                    child: TextField(
                      controller: myController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(20),
                      ],
                      cursorWidth: 2.0,
                      cursorColor: kWhite,
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: kFormStyle,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                ContinueButton(
                  text: 'Continuar',
                  width: 150.0,
                  height: 50.0,
                  onPressed: () {
                    nome = myController.text;
                    if (nome.length != 0) {
                      _profile.nome = nome;
                      Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OriginScreen(profile: _profile)),
                );
                    } else
                      Toast.show('Você precisa digitar um nome!', context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



