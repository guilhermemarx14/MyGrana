import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_card.dart';
import 'package:flutter_app/model/profile.dart';
import 'package:flutter_app/model/transacao.dart';
import 'package:flutter_app/screens/statements_filter_screen.dart';
import 'package:flutter_app/util/Database2.dart';

class DeleteDialog extends StatelessWidget {
  DeleteDialog({this.transacao});

  final Transacao transacao;
  Profile p;
  @override
  Widget build(BuildContext context) {
    DBProvider2.db.getProfile().then((profile) => p = profile);

    return AlertDialog(
      backgroundColor: Colors.blue.shade200,
      title: Center(
        child: Text(
          'Deseja deletar essa transação?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.blue.shade700,
          ),
        ),
      ),
      content: Container(
        child: Row(
          children: <Widget>[
            MyCard(
              height: 60.0,
              width: MediaQuery.of(context).size.width / 3.7,
              color: Colors.blue.shade700,
              onTap: () {
                Navigator.pop(context);
              },
              cardChild: Center(
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            MyCard(
              height: 60.0,
              width: MediaQuery.of(context).size.width / 3.7,
              color: Colors.blue.shade700,
              onTap: () {
                //print('${transacao.id}');
                DBProvider2.db.deleteTransacao(transacao, p);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StatementsFilterScreen()),
                );
              },
              cardChild: Center(
                child: Text(
                  'Confirmar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
    );
  }
}
