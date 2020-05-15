import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/util/constants.dart';

class InformationScreen extends StatefulWidget {
  InformationScreen();
  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  String version;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    version = '1.0.0';
    var style = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    double margin = 30.0;

    return WillPopScope(
      onWillPop: () => Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => HomeScreen()), (r) => false),
      child: Scaffold(
        backgroundColor: kBlue,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Desenvolvedor: ',
                        style: style,
                      ),
                      Text(
                        'Guilherme Marx',
                        style: style,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: margin,
                  ),
                  Text(
                    'Trabalho de conclusão do curso de Engenharia de Computação pela Universidade Federal de Ouro Preto (2020).',
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    style: style,
                  ),
                  SizedBox(
                    height: margin,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Orientador: ',
                        style: style,
                      ),
                      Text(
                        'Alexandre Magno de Souza',
                        style: style,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Coorientador: ',
                        style: style,
                      ),
                      Text(
                        'Euler Horta Marinho',
                        style: style,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: margin,
                  ),
                  Text(
                    'Versão: $version',
                    textAlign: TextAlign.center,
                    style: style,
                  ),
                ],
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(
            'Sobre o app',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
