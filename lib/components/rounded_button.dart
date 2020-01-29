import 'package:flutter/material.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                color: kYellow,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Icon(
                      FontAwesomeIcons.arrowRight,
                      size: 20.0,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  BackButton(
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
                color: kYellow,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Icon(
                      FontAwesomeIcons.arrowRight,
                      size: 20.0,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
