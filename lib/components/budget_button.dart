import 'package:flutter/material.dart';

import 'my_card.dart';

class BudgetButton extends StatelessWidget {
  const BudgetButton({
    Key key,
    this.color,
    @required this.screenSize,
    @required this.text,
    @required this.onTap,
  }) : super(key: key);

  final Color color;
  final double screenSize;
  final String text;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MyCard(
        color: color,
        height: 70.0,
        width: screenSize,
        cardChild: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
