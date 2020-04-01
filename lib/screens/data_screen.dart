import 'package:flutter/material.dart';
import 'package:flutter_app/components/back_button.dart' as back;
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_app/components/continue_button.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/model/estado.dart';

class DataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String nome;
    final myController = TextEditingController();
    return Scaffold(
      backgroundColor: kBlue,
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
                    cursorWidth: 2.0,
                    cursorColor: kWhite,
                    maxLines: 1,
                    decoration: InputDecoration(border: InputBorder.none),
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
                  nome = myController.text; //todo: verificações do nome
                  Navigator.of(context).pushNamed("/statescreen");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StateScreen extends StatefulWidget {
  const StateScreen({Key key}) : super(key: key);

  @override
  _StateScreen createState() => _StateScreen();
}

class _StateScreen extends State<StateScreen> {
  List<String> nomesEstados = ['Estado :'];
  String selected = 'Estado :';
  @override
  Widget build(BuildContext context) {
    Estado.getEstadosList().then((list) {
      nomesEstados = ['Estado :'];
      list.forEach((value) {
        setState(() {
          nomesEstados.add(value.toString());
        });
      });
    });

    return Scaffold(
      backgroundColor: kBlue,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'Estado e Cidade em que vai estudar',
                style: kFormStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      DropdownButton<String>(
                        value: selected,
                        iconEnabledColor: kWhite,
                        underline: Container(
                          height: 2,
                          width: double.infinity,
                          color: kWhite,
                        ),
                        style: kFormStyle,
                        items: nomesEstados.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                            ),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            selected = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      DropdownButton<String>(
                        value: 'Goiânia',
                        iconEnabledColor: kWhite,
                        underline: Container(
                          height: 2,
                          width: double.infinity,
                          color: kWhite,
                        ),
                        style: kFormStyle,
                        items: <String>[
                          'Goiânia',
                          'São Paulo',
                          'Belo Horizonte',
                          'Rio de Janeiro'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                            ),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              back.BackButton(
                text: 'Voltar',
                width: 150.0,
                height: 50.0,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ContinueButton(
                text: 'Continuar',
                width: 150.0,
                height: 50.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UniversityScreen()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UniversityScreen extends StatelessWidget {
  static var listaUniversidades;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlue,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Selecione sua universidade',
                  style: kFormStyle,
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      DropdownButton<String>(
                        value: 'Universidade Federal de Ouro Preto',
                        iconEnabledColor: kWhite,
                        underline: Container(
                          height: 2,
                          width: double.infinity,
                          color: kWhite,
                        ),
                        style: kFormStyle.copyWith(fontSize: 18),
                        items: <String>[
                          'Universidade Federal de Ouro Preto',
                          'Universidade Federal de Minas Gerais',
                          'Universidade Federal do Rio Grande do Sul'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                            ),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              back.BackButton(
                text: 'Voltar',
                width: 150.0,
                height: 50.0,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ContinueButton(
                text: 'Continuar',
                width: 150.0,
                height: 50.0,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (r) => false);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
