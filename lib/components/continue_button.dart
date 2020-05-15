import 'package:flutter/material.dart';
import 'package:flutter_app/util/constants.dart';

class ContinueButton extends StatelessWidget {
  ContinueButton(
      {@required this.text,
      @required this.width,
      @required this.height,
      @required this.onPressed});

  final String text;
  final double width;
  final double height;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Align(
        alignment: FractionalOffset.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SizedBox(
            width: width,
            height: height,
            child: FlatButton(
                onPressed: onPressed,
                textColor: kWhite,
                color: Colors.blue.shade900,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
