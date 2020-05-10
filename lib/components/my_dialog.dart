import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'my_calendar.dart';

class MyDialog extends StatefulWidget {
  MyDialog(
      {@required this.context,
      @required this.title,
      @required this.category,
      @required this.value});

  final String title;
  final String category;
  final String value;
  final BuildContext context;

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  MyCalendar calendar;
  final descricaoController = TextEditingController();
  String valorString = '';
  int valorInt;
  var valorController = new MoneyMaskedTextController(
      decimalSeparator: ',',
      thousandSeparator: '.',
      initialValue: 0,
      leftSymbol: 'R\$ ');
  var checkedValue = false;
  var currentDate;
  var selectedDate;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue.shade100,
      title: Center(
        child: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.blue,
          ),
        ),
      ),
      content: Container(
        height: 300,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Categoria:',
                      style: TextStyle(
                        color: kBlack,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DropdownButton<String>(
                    value: widget.category,
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
              Text(
                'Data:',
                style: TextStyle(
                  color: kBlack,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              MyCalendar(selectDate: onDayPressed),
              SizedBox(
                height: 5,
              ),
              Text(
                'Descrição:',
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
                  controller: descricaoController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(20),
                  ],
                  cursorColor: Colors.black,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                    color: kBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
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
                  controller: valorController,
                  cursorWidth: 2.0,
                  cursorColor: Colors.black,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                    color: kBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (value) {
                    setState(() {
                      valorController.updateValue(valorController.numberValue);

                      print(selectedDate);
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Pago:',
                    style: TextStyle(
                      color: kBlack,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Checkbox(
                    value: checkedValue,
                    onChanged: (bool value) {
                      setState(() {
                        checkedValue = value;
                      });
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    child:
                        Text('Cancelar', style: TextStyle(color: Colors.blue)),
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
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
    );
  }

  DateTime onDayPressed(DateTime date, List<Event> events) {
    this.setState(() {
      selectedDate = date;
      print(selectedDate.toString());
    });
  }
/*  String formatValor(String value) {
    valorString = value.split(' ')[1];
    valorString = valorString.split(',')[0] + valorString.split(',')[1];
    valorInt = int.parse(valorString.replaceAll('.', ''));
    print(valorInt.toString());
    int valorDecimal = (valorInt % 100);
    if (valorString.length < 6)
      return ('R\$ ' +
          (valorInt ~/ 100).toString() +
          ',' +
          valorDecimal.toString());

    valorInt = valorInt ~/ 100;
    String retorno = '';

    do {
      retorno = "." + (valorInt % (1000)).toString() + retorno;
      valorInt = valorInt ~/ (1000);
    } while (valorInt >= 1000);

    retorno = valorInt.toString() + retorno + ',' + valorDecimal.toString();

    return 'R\$ ' + retorno;
  }*/
}
