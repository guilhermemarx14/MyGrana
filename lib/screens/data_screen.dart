import 'package:flutter/material.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_app/components/rounded_button.dart';

class DataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlue,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Nome',
                  style: kFormStyle,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 3.0, color: kWhite),
                    ),
                  ),
                  child: TextField(
                    cursorWidth: 2.0,
                    cursorColor: kWhite,
                    maxLines: 1,
                    decoration: InputDecoration(border: InputBorder.none),
                    style: kFormStyle,
                  ),
                ),
              ],
            ),
          ),
          ContinueButton(
            text: 'Continuar',
            width: 150.0,
            height: 50.0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StateScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class StateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlue,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'Estado e Cidade em que vai estudar',
                style: kFormStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    DropdownButton<String>(
                      value: 'Goias',
                      iconEnabledColor: kWhite,
                      underline: Container(
                        height: 2,
                        width: double.infinity,
                        color: kWhite,
                      ),
                      style: kFormStyle,
                      items: <String>['Goias', 'Sao Paulo', 'BH', 'RJ']
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    DropdownButton<String>(
                      value: 'Rio',
                      iconEnabledColor: kWhite,
                      underline: Container(
                        height: 2,
                        width: double.infinity,
                        color: kWhite,
                      ),
                      style: kFormStyle,
                      items: <String>['Goiania', 'Sampa', 'Belo Hori', 'Rio']
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
              ],
            ),
          ),
          ContinueButton(
            text: 'Continuar',
            width: 150.0,
            height: 50.0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StateScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
