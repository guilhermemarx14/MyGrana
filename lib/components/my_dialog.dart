import 'package:flutter/material.dart';
import 'package:flutter_app/util/constants.dart';

import 'my_calendar.dart';

class MyDialog extends StatelessWidget {
  MyDialog(
      {@required this.context,
      @required this.title,
      @required this.category,
      @required this.value});

  final String title;
  final String category;
  final String value;
  final BuildContext context;
  MyCalendar calendar;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue.shade100,
      title: Center(
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.blue,
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Categoria:',
                style: TextStyle(
                  color: kBlack,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton<String>(
                value: category,
                iconEnabledColor: kBlack,
                underline: Container(
                  height: 2,
                  width: double.infinity,
                  color: kBlack,
                ),
                style: kFormStyle.copyWith(fontSize: 18, color: kBlack),
                items: <String>['Salário', 'Moradia', 'Alimentação']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Data:',
                style: TextStyle(
                  color: kBlack,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              MyCalendar(title: 'test'),
              GestureDetector(
                child: Icon(Icons.calendar_today),
                onTap: () {},
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'Valor:',
            style: TextStyle(
              color: kBlack,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 3.0, color: kBlack),
              ),
            ),
            child: TextField(
              cursorWidth: 2.0,
              cursorColor: kWhite,
              textAlign: TextAlign.center,
              maxLines: 1,
              controller: TextEditingController(text: value),
              decoration: InputDecoration(border: InputBorder.none),
              style: TextStyle(
                color: kBlack,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                child: Text('Cancelar', style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text(
                  'Confirmar',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
    );
  }
}
