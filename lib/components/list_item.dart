import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_dialog.dart';
import 'package:flutter_app/model/transacao.dart';
import 'package:flutter_app/util/constants.dart';

class ListItem extends StatelessWidget {
  ListItem({@required this.transacao});

  final Transacao transacao;
  @override
  Widget build(BuildContext context) {
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
                  kListaCategorias[transacao.category],
                  style: kStatementsStyle,
                ),
                Text(
                  '${transacao.value}',
                  style: kStatementsStyle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
