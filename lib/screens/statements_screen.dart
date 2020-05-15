import 'package:flutter/material.dart';
import 'package:flutter_app/components/list_item.dart';
import 'package:flutter_app/util/Database2.dart';
import 'package:flutter_app/util/constants.dart';

class StatementsScreen extends StatefulWidget {
  StatementsScreen({this.categoria, this.mes, this.ano, this.onTap, this.type});
  final String categoria;
  final String mes;
  final String ano;
  final Function onTap;
  final int type;
  @override
  _StatementsScreenState createState() => _StatementsScreenState();
}

class _StatementsScreenState extends State<StatementsScreen> {
  var transacoes = [];
  var total = 0.0;
  @override
  void initState() {
    DBProvider2.db
        .consultaTransacao(widget.categoria, widget.mes, widget.ano)
        .then((list) {
      setState(() {
        transacoes = list;
        transacoes.forEach((value) => total += value.value);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var wid;
    if (transacoes.isNotEmpty)
      wid = ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: transacoes.length,
        itemBuilder: (BuildContext context, int index) {
          return ListItem(transacao: transacoes[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: kWhite,
        ),
      );
    else
      wid = Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Nenhum resultado para\na busca selecionada.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: kStatementsStyle.copyWith(fontSize: 30.0),
                ),
              ],
            ),
          ),
        ),
      );

    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      body: wid,
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
