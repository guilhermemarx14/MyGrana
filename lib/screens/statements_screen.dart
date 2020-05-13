import 'package:flutter/material.dart';
import 'package:flutter_app/components/list_item.dart';
import 'package:flutter_app/util/Database2.dart';
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
  bool finishedConsulta = false;
  var transacoes = [];
  @override
  Widget build(BuildContext context) {
    print('${widget.categoria}, ${widget.mes}, ${widget.ano}');
    if (!finishedConsulta)
      DBProvider2.db
          .consultaTransacao(widget.categoria, widget.mes, widget.ano)
          .then((list) {
        setState(() {
          transacoes = list;
          finishedConsulta = true;
        });
      });
    print(transacoes);
    return Scaffold(
      backgroundColor: kBlue,
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: transacoes.length,
        itemBuilder: (BuildContext context, int index) {
          return ListItem(
            category: transacoes[index].category,
            value: '${transacoes[index].value}',
            title: transacoes[index] == ''
                ? kListaCategorias.indexOf(transacoes[index].category)
                : transacoes[index].descricao,
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
  }
}
