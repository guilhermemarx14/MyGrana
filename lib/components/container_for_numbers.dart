import 'package:flutter/material.dart';

class ContainerForNumbers extends StatelessWidget {
  ContainerForNumbers({
    this.margin,
    @required this.width,
    @required this.height,
    @required this.child,
  });
  final EdgeInsets margin;
  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: Center(child: child),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white.withOpacity(0.2),
      ),
    );
  }
}
