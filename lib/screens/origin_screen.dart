import 'package:flutter/material.dart';
import 'package:flutter_app/components/back_button.dart' as back;
import 'package:flutter_app/components/continue_button.dart';
import 'package:flutter_app/model/cidade_universidade.dart';
import 'package:flutter_app/model/estado.dart';
import 'package:flutter_app/model/profile.dart';
import 'package:flutter_app/screens/state_screen.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:toast/toast.dart';

import 'university_screen.dart';

class OriginScreen extends StatefulWidget {
  const OriginScreen({Key key, this.profile}) : super(key: key);

  final Profile profile;
  @override
  _OriginScreen createState() => _OriginScreen();
}

class _OriginScreen extends State<OriginScreen> {
  List<String> _nomesEstados = ['Estado: '];
  List<Estado> estados = [];
  String selectedEstado = 'Estado: ';
  List<String> nomesCidades = ['Cidade: '];
  List<CidadeUniversidade> cidades = [];
  String selectedCidade = 'Cidade: ';

  int idSelectedEstado(String selected) {
    for (int i = 0; i < estados.length; i++)
      if (estados[i].nome.compareTo(selected) == 0) return estados[i].id;
    return -1;
  }

  String showCidade(String name) {
    double sizeScreen = MediaQuery.of(context).size.width;
    int stringSize = sizeScreen ~/ 12;
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

    return -1;
  }

  @override
  Widget build(BuildContext context) {
    Estado.getEstadosList().then((list) {
      _nomesEstados = ['Estado: '];
      estados = [];
      list.forEach((value) {
        setState(() {
          estados.add(value);
          _nomesEstados.add(value.toString());
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
              flex: 1,
              child: Center(
                child: Text(
                  'Estado e Cidade de origem',
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
                          items: _nomesEstados.map((String value) {
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
                              widget.profile.originEstado =
                                  idSelectedEstado(selectedEstado);
                              nomesCidades = ['Cidade: '];
                              selectedCidade = 'Cidade: ';
                              cidades = [];
                              CidadeUniversidade.getCidadesList(
                                      widget.profile.originEstado)
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
                          ),
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
                              widget.profile.originCidade =
                                  idSelectedCidade(selectedCidade);
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
                      Toast.show("Você deve selecionar um estado e uma cidade!",
                          context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    else {
                      widget.profile.cidade = idSelectedCidade(selectedCidade);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => StateScreen(
                            profile: widget.profile,
                          ),
                        ),
                      );
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
}
