import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/components/back_button.dart' as back;
import 'package:flutter_app/components/continue_button.dart';
import 'package:flutter_app/model/cidadeUniversidade.dart';
import 'package:flutter_app/model/estado.dart';
import 'package:flutter_app/model/profile.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/util/Database2.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

Profile profile;

class DataScreen extends StatelessWidget {
  //todo: símbolo de carregando
  //todo: bug nome sumindo
  DataScreen() {
    profile = Profile();
    profile.plataforma = Platform.isIOS ? 'ios' : 'android';
  }

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
                    profile.nome = nome;
                    Navigator.of(context).pushNamed("/statescreen");
                  } else
                    Toast.show('Você precisa digitar um nome!', context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
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
  List<String> nomesEstados = ['Estado: '];
  List<Estado> estados = [];
  String selectedEstado = 'Estado: ';
  List<String> nomesCidades = ['Cidade: '];
  List<CidadeUniversidade> cidades = [];
  String selectedCidade = 'Cidade: ';

  int idSelectedEstado(String selected) {
    for (int i = 0; i < estados.length; i++)
      if (estados[i].nome.compareTo(selected) == 0) return estados[i].id;
  }

  String showCidade(String name) {
    double sizeScreen = MediaQuery.of(context).size.width;
    int stringSize = (sizeScreen / 12).toInt();
    return name.length > stringSize - 1
        ? name.substring(0, stringSize - 4) + "..."
        : name;
  }

  int idSelectedCidade(String selectedCidade) {
    String cidade;
    if (selectedCidade.endsWith('...'))
      cidade = selectedCidade.substring(0, selectedCidade.length - 3);
    else
      cidade = selectedCidade;
    for (int i = 0; i < cidades.length; i++)
      if (cidades[i].nome.startsWith(cidade)) return cidades[i].id;
  }

  @override
  Widget build(BuildContext context) {
    Estado.getEstadosList().then((list) {
      nomesEstados = ['Estado: '];
      estados = [];
      list.forEach((value) {
        setState(() {
          estados.add(value);
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
                        isExpanded: false,
                        value: selectedEstado,
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
                            selectedEstado = newValue;
                            profile.estado = idSelectedEstado(selectedEstado);
                            nomesCidades = ['Cidade: '];
                            selectedCidade = 'Cidade: ';
                            cidades = [];
                            CidadeUniversidade.getCidadesList(profile.estado)
                                .then((list) {
                              list.forEach((value) {
                                cidades.add(value);
                                nomesCidades.add(showCidade(value.nome));
                              });
                            });
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
                        value: selectedCidade,
                        isExpanded: false,
                        iconEnabledColor: kWhite,
                        underline: Container(
                          height: 2,
                          width: double.infinity,
                          color: kWhite,
                        ),
                        style: TextStyle(
                            fontSize: 20.0,
                            color: kWhite,
                            fontWeight: FontWeight.bold),
                        items: nomesCidades.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                            ),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            selectedCidade = newValue;
                            profile.cidade = idSelectedCidade(selectedCidade);
                          });
                        },
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
                  if (selectedEstado.compareTo('Estado: ') == 0 ||
                      selectedCidade.compareTo('Cidade: ') == 0)
                    Toast.show(
                        "Você deve selecionar um estado e uma cidade!", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  else {
                    profile.cidade = idSelectedCidade(selectedCidade);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => UniversityScreen(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UniversityScreen extends StatefulWidget {
  const UniversityScreen({Key key}) : super(key: key);

  @override
  _UniversityScreen createState() => _UniversityScreen();
}

class _UniversityScreen extends State<UniversityScreen> {
  int estadoId;
  List<String> nomesUniversidades = ['Universidade:'];
  List<CidadeUniversidade> universidades = [];
  String selectedUniversidade = 'Universidade:';
  String showUniversity(String name) {
    double sizeScreen = MediaQuery.of(context).size.width;
    int stringSize = (sizeScreen / 10.35).toInt();
    return name.length > stringSize - 1
        ? name.substring(0, stringSize - 4) + "..."
        : name;
  }

  int idSelectedUniversidade(String selectedUniversidade) {
    String universidade;
    if (selectedUniversidade.endsWith('...'))
      universidade =
          selectedUniversidade.substring(0, selectedUniversidade.length - 3);
    else
      universidade = selectedUniversidade;
    for (int i = 0; i < universidades.length; i++)
      if (universidades[i].nome.startsWith(universidade))
        return universidades[i].id;
  }

  @override
  Widget build(BuildContext context) {
    CidadeUniversidade.getUniversidadesList(profile.estado).then((list) {
      nomesUniversidades = ['Universidade:'];
      universidades = [];
      list.forEach((value) {
        setState(() {
          universidades.add(value);
          nomesUniversidades.add(showUniversity(value.nome));
        });
      });
    });

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
                        value: selectedUniversidade,
                        iconEnabledColor: kWhite,
                        underline: Container(
                          height: 2,
                          width: double.infinity,
                          color: kWhite,
                        ),
                        style: kFormStyle.copyWith(fontSize: 15),
                        items: nomesUniversidades.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                            ),
                          );
                        }).toList(),
                        onChanged: (String newSelected) {
                          setState(() {
                            selectedUniversidade = newSelected;
                            profile.universidade =
                                idSelectedUniversidade(selectedUniversidade);
                          });
                        },
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
                onPressed: () async {
                  if (selectedUniversidade.compareTo('Universidade:') == 0)
                    Toast.show('Você deve escolher uma universidade!', context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  else {
                    profile.hash = generateHash(profile);
                    DBProvider2.db
                        .createProfile(profile)
                        .then(DBProvider2.db.saveProfile(profile));
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('first_time', false); //cadastro concluído
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen(p: profile)),
                        (r) => false);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  String generateHash(Profile p) {
    //GERA A KEY DO USUÁRIO
    int number;
    var random = Random();
    number = random.nextInt(1000);

    //GERA A HASH DO USUÁRIO
    var key = utf8.encode('$number');
    var bytes = utf8.encode(p.nome.toString());
    var hmacSha256 = new Hmac(sha256, key); // HMAC-SHA256
    return hmacSha256.convert(bytes).toString();
  }
}
