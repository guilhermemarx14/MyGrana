import 'package:flutter/material.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_app/components/continue_button.dart';

class StatementsScreen extends StatelessWidget {
  StatementsScreen({@required this.type});

  final int type;
  static const int kChoose = 1;
  static const int kShow = 2;
  final List<String> date = <String>['12/02', '15/02', '20/02'];
  final List<String> category = <String>['Alimentação', 'Moradia', 'Pensão'];
  final List<String> values = <String>['R\$ 17.50', 'R\$ 18.30', 'R\$ 250.00'];

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
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: category.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              child: Center(
                //Text('Entry ${entries[index]}')
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(date[index]),
                      Text(category[index]),
                      Text(values[index])
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
        appBar: AppBar(
          title: Text(
            'Extrato',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
  }
}
