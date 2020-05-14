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
    if (!finishedConsulta)
      DBProvider2.db
          .consultaTransacao(widget.categoria, widget.mes, widget.ano)
          .then((list) {
        setState(() {
          transacoes = list;
          finishedConsulta = true;
        });
      });

    var total = 0.0;
    transacoes.forEach((value) => total += value.value);
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: transacoes.length,
        itemBuilder: (BuildContext context, int index) {
          return ListItem(transacao: transacoes[index]);
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
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70.0,
          color: Colors.blue.shade900,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Total: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
              Text(
                'R\$ ${(total / 100).toStringAsFixed(2).replaceAll('.', '\,')}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: total >= 0 ? Colors.green : Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
