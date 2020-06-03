import 'package:flutter/material.dart';

class HomeItem extends StatefulWidget {
  HomeItem({this.width, this.height, this.title, this.icon, this.onPressed});

  final double width;
  final double height;
  final String title;
  final IconData icon;
  final Function onPressed;

  @override
  _HomeItemState createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isTapped = !isTapped;
        });
        widget.onPressed();
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              widget.icon,
              color: Colors.white,
              size: 50.0,
            ),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ],
        ),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 5,
              offset: Offset(2, 4),
            ),
          ],
          color: Color.fromRGBO(56, 49, 38, 100),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
