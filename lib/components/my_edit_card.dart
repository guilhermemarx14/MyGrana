import 'package:flutter/material.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'my_card.dart';

class MyEditCard extends StatefulWidget {
  const MyEditCard({
    Key key,
    @required this.category,
    @required this.screenSize,
    @required this.text,
    @required this.valor,
    @required this.controller,
    @required this.onChange,
  }) : super(key: key);

  final double screenSize;
  final String text;
  final double valor;
  final MoneyMaskedTextController controller;
  final Function onChange;
  final int category;
  @override
  _MyEditCardState createState() => _MyEditCardState();
}

class _MyEditCardState extends State<MyEditCard> {
  @override
  Widget build(BuildContext context) {
    return MyCard(
      color: Colors.blue.shade200,
      height: 100.0,
      width: widget.screenSize,
      cardChild: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              widget.text,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 2.0,
                    color: (widget.category == kSalario ||
                            widget.category == kPensao)
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
              child: TextField(
                controller: widget.controller,
                cursorWidth: 2.0,
                cursorColor:
                    (widget.category == kSalario || widget.category == kPensao)
                        ? Colors.green
                        : Colors.red,
                textAlign: TextAlign.center,
                maxLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: (widget.category == kSalario ||
                          widget.category == kPensao)
                      ? Colors.green
                      : Colors.red,
                  fontSize: 20,
                ),
                onChanged: widget.onChange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
