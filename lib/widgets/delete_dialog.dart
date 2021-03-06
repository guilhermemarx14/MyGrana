import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/my_card.dart';
import 'package:flutter_app/model/profile.dart';
import 'package:flutter_app/model/transaction.dart';
import 'package:flutter_app/view/statements_filter_screen.dart';
import 'package:flutter_app/util/constants.dart';

class DeleteDialog extends StatelessWidget {
  DeleteDialog({this.transacao});

  final Transaction transacao;

  @override
  Widget build(BuildContext context) {
    Profile p;
    Profile.getProfile().then((profile) => p = profile);
    //print(transacao);
    return AlertDialog(
      backgroundColor: kBackground,
      title: Center(
        child: Text(
          'Deseja deletar essa transação?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      content: Container(
        child: Row(
          children: <Widget>[
            MyCard(
              height: 60.0,
              width: MediaQuery.of(context).size.width / 3.7,
              color: kButton,
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
              color: kButton,
              onTap: () {
                //print('${transacao.id}');
                Transaction.deleteTransaction(transacao, p);
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
