import 'package:flutter/material.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListItem extends StatelessWidget {
  ListItem(
      {@required this.date, @required this.category, @required this.value});

  final String date;
  final String category;
  final String value;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //todo: abrir dialog editar
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
                  date,
                  style: kStatementsStyle,
                ),
                Text(
                  category,
                  style: kStatementsStyle,
                ),
                Text(
                  value,
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
