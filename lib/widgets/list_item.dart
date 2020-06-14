import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/container_for_numbers.dart';
import 'package:flutter_app/widgets/my_dialog.dart';
import 'package:flutter_app/model/transaction.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import 'delete_dialog.dart';

// ignore: must_be_immutable
class ListItem extends StatelessWidget {
  ListItem({@required this.transacao});

  final Transaction transacao;
  String title;
  @override
  Widget build(BuildContext context) {
    title = transacao.description.trim().length == 0
        ? kListaCategorias[transacao.category]
        : transacao.description + ' - ' + kListaCategorias[transacao.category];
    if (title.length > 20) title = title.substring(0, 19) + '...';

    var maskedValue = FlutterMoneyFormatter(
      amount: transacao.value / 100,
      settings: MoneyFormatterSettings(
          thousandSeparator: '.', decimalSeparator: ',', fractionDigits: 2),
    );
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return MyEditDialog(
                transacao: transacao,
              );
            },
          );
        },
        onLongPress: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                //print('call: ' + transacao.toString());
                return DeleteDialog(
                  transacao: transacao,
                );
              });
        },
        child: Column(
          children: <Widget>[
            Text(
              kListaCategorias[transacao.category],
              style: kStatementsStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      transacao.description,
                      style: kStatementsStyle.copyWith(fontSize: 15),
                    ),
                    Text(
                      formatDate(transacao.date),
                      style: kStatementsStyle.copyWith(fontSize: 15),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.7,
                  height: 60,
                ),
                ContainerForNumbers(
                  height: 60,
                  width: 120,
                  child: Text(
                    'R\$ ${maskedValue.output.nonSymbol}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: (transacao.category == kSalario ||
                              transacao.category == kPensao ||
                              transacao.category == kBolsaAuxilio)
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }

  formatDate(String date) {
    var ano = date.split('-')[0];
    var mes = date.split('-')[1];
    var dia = date.split('-')[2];
    if (dia.length > 2) dia += '0';
    return ('$dia/$mes/${ano.substring(2, 4)}');
  }
}
