import 'package:flutter/material.dart';
import 'package:flutter_app/components/continue_button.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/screens/statements_screen.dart';
import 'package:flutter_app/util/constants.dart';

class StatementsFilterScreen extends StatefulWidget {
  StatementsFilterScreen();
  @override
  _StatementsFilterScreenState createState() => _StatementsFilterScreenState();
}

class _StatementsFilterScreenState extends State<StatementsFilterScreen> {
  String selectedDropdownCategoria = ALIMENTACAO;
  String selectedDropdownMes = 'Janeiro';
  String selectedDropdownAno = '2020';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => HomeScreen()), (r) => false),
      child: Scaffold(
        backgroundColor: kBlue,
        body: Column(
          children: <Widget>[
            TitleWidget(),
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
                          value: selectedDropdownCategoria,
                          iconEnabledColor: kWhite,
                          underline: Container(
                            height: 1,
                            width: double.infinity,
                            color: kWhite,
                          ),
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                          ),
                          items:
                              (kListaCategorias + [TODOS]).map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                          onChanged: (newSelected) {
                            setState(() {
                              selectedDropdownCategoria = newSelected;
                            });
                          },
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
                          value: selectedDropdownMes,
                          iconEnabledColor: kWhite,
                          underline: Container(
                            height: 1,
                            width: double.infinity,
                            color: kWhite,
                          ),
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                          ),
                          items: (kMeses.sublist(1, 13) + [TODOS])
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                          onChanged: (newSelected) {
                            setState(() {
                              selectedDropdownMes = newSelected;
                            });
                          },
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
                          value: selectedDropdownAno,
                          iconEnabledColor: kWhite,
                          underline: Container(
                            height: 1,
                            width: double.infinity,
                            color: kWhite,
                          ),
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                          ),
                          items: (kAnos + [TODOS]).map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                          onChanged: (newSelected) {
                            setState(() {
                              selectedDropdownAno = newSelected;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ContinueButton(
              text: 'Continuar',
              width: 160.0,
              height: 50.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StatementsScreen(
                            categoria: selectedDropdownCategoria,
                            mes: selectedDropdownMes,
                            ano: selectedDropdownAno,
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
      ),
    );
    /*else
      return Scaffold(
        backgroundColor: kBlue,
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: category.length,
          itemBuilder: (BuildContext context, int index) {
            return ListItem(
              category: kListaCategorias.indexOf(category[index]),
              value: values[index],
              title: 'Editar Transação',
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            color: kWhite,
          ),
        ),
        appBar: AppBar(
          title: Text(
            'Extrato',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );*/
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Center(
        child: Text(
          'Selecione os filtros desejados:',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
