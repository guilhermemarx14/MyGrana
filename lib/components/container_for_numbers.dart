import 'package:flutter/material.dart';

class ContainerForNumbers extends StatelessWidget {
  ContainerForNumbers({
    @required this.width,
    @required this.height,
    @required this.child,
  });

  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: child,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white.withOpacity(0.2),
      ),
    );
  }
}
