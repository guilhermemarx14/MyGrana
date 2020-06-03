import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/back_button.dart' as back;
import 'package:flutter_app/widgets/continue_button.dart';
import 'package:flutter_app/model/cidade_universidade.dart';
import 'package:flutter_app/model/profile.dart';
import 'package:flutter_app/view/home_screen.dart';
import 'package:flutter_app/database/Database2.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class UniversityScreen extends StatefulWidget {
  const UniversityScreen({Key key, this.profile}) : super(key: key);

  final Profile profile;
  @override
  _UniversityScreen createState() => _UniversityScreen();
}

class _UniversityScreen extends State<UniversityScreen> {
  List<String> _nomesUniversidades = ['Universidade:'];
  List<CidadeUniversidade> _universidades = [];
  String _selectedUniversidade = 'Universidade:';

  String showUniversity(String name) {
    double sizeScreen = MediaQuery.of(context).size.width;
    int stringSize = sizeScreen ~/ 10.35;
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
    for (int i = 0; i < _universidades.length; i++)
      if (_universidades[i].nome.startsWith(universidade))
        return _universidades[i].id;

    return -1;
  }

  @override
  Widget build(BuildContext context) {
    CidadeUniversidade.getUniversidadesList(widget.profile.estado).then((list) {
      _nomesUniversidades = ['Universidade:'];
      _universidades = [];
      list.forEach((value) {
        setState(() {
          _universidades.add(value);
          _nomesUniversidades.add(showUniversity(value.nome));
        });
      });
    });

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
                    'Selecione sua universidade',
                    style: kFormStyle,
                  ),
                  Container(
                    margin: EdgeInsets.all(25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        DropdownButton<String>(
                          value: _selectedUniversidade,
                          iconEnabledColor: kWhite,
                          underline: Container(
                            height: 2,
                            width: double.infinity,
                            color: kWhite,
                          ),
                          style: kFormStyle.copyWith(fontSize: 15),
                          items: _nomesUniversidades.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                          onChanged: (String newSelected) {
                            setState(() {
                              _selectedUniversidade = newSelected;
                              widget.profile.universidade =
                                  idSelectedUniversidade(_selectedUniversidade);
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
                    if (_selectedUniversidade.compareTo('Universidade:') == 0)
                      Toast.show(
                          'Você deve escolher uma universidade!', context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    else {
                      widget.profile.hash = generateHash(widget.profile);
                      DBProvider2.db.createProfile(widget.profile);
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('first_time', false); //cadastro concluído
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (r) => false);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
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
