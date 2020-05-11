import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_dialog.dart';
import 'package:flutter_app/util/constants.dart';

class ListItem extends StatelessWidget {
  ListItem(
      {@required this.category, @required this.value, @required this.title});

  final int category;
  final String value;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return MyDialog(
              context: context,
              category: category,
              value: value == null ? '' : value,
              title: title,
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
                  kListaCategorias[category],
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
