import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  MyCard({@required this.color, this.cardChild, this.width, this.height});

  final double width;
  final double height;
  final Color color;
  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: cardChild,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 5,
            offset: Offset(2, 4),
          ),
        ],
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
