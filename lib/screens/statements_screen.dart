import 'package:flutter/material.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_app/components/continue_button.dart';

class StatementsScreen extends StatelessWidget {
  StatementsScreen({@required this.type});

  final int type;
  static const int kChoose = 1;
  static const int kShow = 2;
  @override
  Widget build(BuildContext context) {
    if (type == kChoose)
      return Scaffold(
        backgroundColor: kBlue,
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  'Selecione os filtros desejados:',
                  style: kFormStyle2,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Categoria:',
                          style: kFormStyle2,
                        ),
                        DropdownButton<String>(
                          value: 'Salário',
                          iconEnabledColor: kWhite,
                          underline: Container(
                            height: 2,
                            width: double.infinity,
                            color: kWhite,
                          ),
                          style: kFormStyle2,
                          items: <String>[
                            'Salário',
                            'Pensão',
                            'Alimentação',
                            'Vestimenta'
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
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Mês:',
                          style: kFormStyle2,
                        ),
                        DropdownButton<String>(
                          value: 'Janeiro',
                          iconEnabledColor: kWhite,
                          underline: Container(
                            height: 2,
                            width: double.infinity,
                            color: kWhite,
                          ),
                          style: kFormStyle2,
                          items: <String>[
                            'Janeiro',
                            'Fevereiro',
                            'Março',
                            'Abril'
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
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Ano:',
                          style: kFormStyle2,
                        ),
                        DropdownButton<String>(
                          value: '2020',
                          iconEnabledColor: kWhite,
                          underline: Container(
                            height: 2,
                            width: double.infinity,
                            color: kWhite,
                          ),
                          style: kFormStyle2,
                          items: <String>['2020', '2019', '2018']
                              .map((String value) {
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
            ContinueButton(
              text: 'Continuar',
              width: 150.0,
              height: 50.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StatementsScreen(
                            type: 2,
                          )),
                );
              },
            ),
          ],
        ),
        appBar: AppBar(
          title: Text(
            'Extratos',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
    else
      return Scaffold(
        backgroundColor: kBlue,
        body: Column(),
        appBar: AppBar(
          title: Text(
            'Extrato',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
  }
}
