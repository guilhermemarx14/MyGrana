import 'package:flutter/material.dart';

class HomeItem extends StatelessWidget {
  HomeItem({this.width, this.height, this.title, this.icon, this.onPressed});

  final double width;
  final double height;
  final String title;
  final IconData icon;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
              size: 50.0,
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ],
        ),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.blue.shade700,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
