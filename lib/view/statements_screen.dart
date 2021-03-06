import 'package:flutter/material.dart';
import 'package:flutter_app/model/transaction.dart';
import 'package:flutter_app/widgets/container_for_numbers.dart';
import 'package:flutter_app/widgets/list_item.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

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
    Transaction.queryTransaction(widget.categoria, widget.mes, widget.ano)
        .then((list) {
      if (list.isNotEmpty)
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
    var maskedTotal = FlutterMoneyFormatter(
      amount: total / 100,
      settings: MoneyFormatterSettings(
          thousandSeparator: '.', decimalSeparator: ',', fractionDigits: 2),
    );
    return Scaffold(
      backgroundColor: kBackground,
      body: wid,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 35.0, 0.0),
            child: Text(
              'Extrato',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70.0,
          color: kButton,
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
              ContainerForNumbers(
                width: 200,
                height: 40,
                child: Text(
                  'R\$ ${maskedTotal.output.nonSymbol}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: total >= 0 ? Colors.green : Colors.red,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
