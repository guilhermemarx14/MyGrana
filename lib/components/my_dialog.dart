import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/model/profile.dart';
import 'package:flutter_app/model/transacao.dart';
import 'package:flutter_app/util/Database2.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:toast/toast.dart';

import 'my_calendar.dart';

class MyDialog extends StatefulWidget {
  MyDialog(
      {@required this.p,
      @required this.context,
      @required this.title,
      @required this.category,
      @required this.value});

  final String title;
  final String value;
  final int category;
  final BuildContext context;
  final Profile p;

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
  var valueCategoria;
  var descricao;
  Transacao transacao;
  String userHash;

  _MyDialogState() {
    transacao = Transacao();
    DBProvider2.db.getTransacaoId().then((id) => transacao.id = id);
    transacao.date = DateTime.now().toString().split(' ')[0];
    transacao.paid = checkedValue;
    transacao.descricao = '';
  }
  @override
  Widget build(BuildContext context) {
    valueCategoria = valueCategoria == null ? widget.category : valueCategoria;
    transacao.category = valueCategoria;

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
        height: 400,
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
                    value: kListaCategorias[valueCategoria],
                    iconEnabledColor: kBlack,
                    underline: Container(
                      height: 2,
                      width: double.infinity,
                      color: kBlack,
                    ),
                    style: kFormStyle.copyWith(fontSize: 18, color: kBlack),
                    items: kListaCategorias.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                        ),
                      );
                    }).toList(),
                    onChanged: (String newSelected) {
                      setState(() {
                        valueCategoria = newSelected;
                        transacao.category =
                            kListaCategorias.indexOf(newSelected);
                      });
                    },
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
                  onChanged: (value) {
                    setState(() {
                      descricao = value;
                      transacao.descricao = value;
                    });
                  },
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
                      valorInt = (valorController.numberValue * 100).toInt();
                      transacao.value = valorInt;
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
                        transacao.paid = value;
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
                      transacao.value = transacao.value ?? 0;
                      if (transacao.value != 0) {
                        DBProvider2.db.updateTransacaoId();
                        DBProvider2.db.createTransacao(transacao);
                        DBProvider2.db.saveTransacao(transacao, widget.p);
                        DBProvider2.db.printTransacoesList();
                        Navigator.pop(context);
                      } else
                        Toast.show('Você precisa digitar um valor!', context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
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

  void onDayPressed(DateTime date, List<Event> events) {
    this.setState(() {
      selectedDate = date;
      transacao.date = date.toString().split(" ")[0];
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
