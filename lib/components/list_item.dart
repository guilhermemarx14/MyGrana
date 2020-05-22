import 'package:flutter/material.dart';
import 'package:flutter_app/components/container_for_numbers.dart';
import 'package:flutter_app/components/my_dialog.dart';
import 'package:flutter_app/model/transacao.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'delete_dialog.dart';

// ignore: must_be_immutable
class ListItem extends StatelessWidget {
  ListItem({@required this.transacao});

  final Transacao transacao;
  String title;
  @override
  Widget build(BuildContext context) {
    title = transacao.descricao.trim().length == 0
        ? kListaCategorias[transacao.category]
        : transacao.descricao + ' - ' + kListaCategorias[transacao.category];
    if (title.length > 20) title = title.substring(0, 19) + '...';

    var maskedValue = FlutterMoneyFormatter(
      amount: transacao.value / 100,
      settings: MoneyFormatterSettings(
          thousandSeparator: '.', decimalSeparator: ',', fractionDigits: 2),
    );
    return GestureDetector(
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
      child: Container(
        height: 50,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: kStatementsStyle,
                ),
                Row(
                  children: <Widget>[
                    ContainerForNumbers(
                      width: 150,
                      height: 40,
                      child: Text(
                        'R\$ ${maskedValue.output.nonSymbol}',
                        style: TextStyle(
                          fontSize: 20.0,
                          color:
                              transacao.value > 0 ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      transacao.paid
                          ? FontAwesomeIcons.checkSquare
                          : FontAwesomeIcons.times,
                      size: 20.0,
                      color: Colors.white,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
