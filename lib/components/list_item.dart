import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_dialog.dart';
import 'package:flutter_app/model/transacao.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                    Text(
                      'R\$ ${(transacao.value / 100).toStringAsFixed(2).replaceAll('.', '\,')}',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: transacao.value > 0 ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
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
