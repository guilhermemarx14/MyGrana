import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  MyCard(
      {@required this.color,
      this.cardChild,
      this.width,
      this.height,
      this.onTap});

  final double width;
  final double height;
  final Color color;
  final Widget cardChild;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        child: cardChild,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 6,
              offset: Offset(0, 0),
            ),
          ],
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
