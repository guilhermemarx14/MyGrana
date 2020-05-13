import 'package:flutter/material.dart';
import 'package:flutter_app/components/continue_button.dart';
import 'package:flutter_app/components/list_item.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/util/constants.dart';

class StatementsScreen extends StatefulWidget {
  StatementsScreen({this.categoria, this.mes, this.ano});
  final String categoria;
  final String mes;
  final String ano;
  @override
  _StatementsScreenState createState() => _StatementsScreenState();
}

class _StatementsScreenState extends State<StatementsScreen> {
  @override
  Widget build(BuildContext context) {
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
          'Extratos',
          style: TextStyle(fontWeight: FontWeight.bold),
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
