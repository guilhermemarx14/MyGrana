import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/model/profile.dart';
import 'package:flutter_app/model/transacao.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/screens/statements_filter_screen.dart';
import 'package:flutter_app/util/Database2.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:toast/toast.dart';

import 'my_calendar.dart';

class MyDialog extends StatefulWidget {
  //todo: mudar cor do valor monetario pra verde ou vermelho dependendo da categoria escolhida
  MyDialog(
      {@required this.context,
      @required this.title,
      @required this.category,
      @required this.value});

  final String title;
  final String value;
  final int category;
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
  int valueCategoria;
  var descricao;
  Transacao transacao;
  String userHash;

  Profile p;
  _MyDialogState() {
    DBProvider2.db.getProfile().then((user) => p = user);
    transacao = Transacao();
    DBProvider2.db.getTransacaoId().then((id) => transacao.id = id);
    transacao.date = DateTime.now().toString().split(' ')[0];

    transacao.paid = checkedValue;
    transacao.descricao = '';
    transacao.value = 0;
  }
  @override
  Widget build(BuildContext context) {
    valueCategoria = valueCategoria == null ? widget.category : valueCategoria;
    transacao.category = valueCategoria;

    return AlertDialog(
      backgroundColor: Colors.blue.shade200,
      title: Center(
        child: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.blue.shade700,
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
                        color: Colors.blue.shade700,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  DropdownButton<String>(
                    value: kListaCategorias[valueCategoria],
                    iconEnabledColor: Colors.blue.shade500,
                    underline: Container(
                      height: 2,
                      width: double.infinity,
                      color: Colors.blue.shade500,
                    ),
                    style: kFormStyle.copyWith(
                        fontSize: 18, color: Colors.blue.shade500),
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
                        valueCategoria = kListaCategorias.indexOf(newSelected);
                        transacao.category =
                            kListaCategorias.indexOf(newSelected);
                        if (transacao != Null) {
                          if (transacao.category == kSalario ||
                              transacao.category == kPensao)
                            transacao.value = transacao.value > 0
                                ? transacao.value
                                : -transacao.value;
                          else
                            transacao.value = transacao.value < 0
                                ? transacao.value
                                : -transacao.value;
                        }
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Data:',
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontSize: 20,
                ),
              ),
              MyCalendar(selectDate: onDayPressed),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Descrição:',
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontSize: 20,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2.0, color: Colors.blue.shade500),
                  ),
                ),
                child: TextField(
                  cursorWidth: 2.0,
                  controller: descricaoController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(20),
                  ],
                  cursorColor: Colors.blue.shade500,
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
                    color: Colors.blue.shade500,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Valor:',
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontSize: 20,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2.0, color: Colors.blue.shade500),
                  ),
                ),
                child: TextField(
                  controller: valorController,
                  cursorWidth: 2.0,
                  cursorColor: Colors.blue.shade500,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                    color: Colors.blue.shade500,
                    fontSize: 20,
                  ),
                  onChanged: (value) {
                    setState(() {
                      valorController.updateValue(valorController.numberValue);
                      valorInt = (valorController.numberValue * 100).toInt();
                      if (transacao.category == kSalario ||
                          transacao.category == kPensao)
                        transacao.value = valorInt;
                      else
                        transacao.value = -valorInt;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Pago:',
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 20,
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
                        DBProvider2.db.saveTransacao(transacao, p);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(p: p)),
                            (r) => false);
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
}

class MyEditDialog extends StatefulWidget {
  MyEditDialog({@required this.transacao});

  Transacao transacao;

  @override
  _MyEditDialogState createState() => _MyEditDialogState();
}

class _MyEditDialogState extends State<MyEditDialog> {
  int _valorInt;
  var _checkedValue = false;
  var _currentDate;
  var _selectedDate;
  int _valueCategoria;
  var _descricao;
  Profile _p;
  var _descricaoController;
  var _valorController;
  @override
  void initState() {
    super.initState();
    _descricaoController =
        TextEditingController(text: widget.transacao.descricao);
    _valorController = new MoneyMaskedTextController(
        decimalSeparator: ',',
        thousandSeparator: '.',
        initialValue: widget.transacao.value / 100,
        leftSymbol: 'R\$ ');
    _valorInt = widget.transacao.value;
    _checkedValue = widget.transacao.paid;
    _currentDate = DateTime.now();
    _selectedDate = DateTime.parse(
        widget.transacao.date + ' ' + _currentDate.toString().split(' ')[1]);
    _valueCategoria = widget.transacao.category;
    _descricao = widget.transacao.descricao;
    DBProvider2.db.getProfile().then((user) => _p = user);
  }
  //checar sinal do valor apos a edicao no firebase

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue.shade200,
      title: Center(
        child: Text(
          'Editar transação',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.blue.shade700,
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
                        color: Colors.blue.shade700,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  DropdownButton<String>(
                    value: kListaCategorias[_valueCategoria],
                    iconEnabledColor: Colors.blue.shade500,
                    underline: Container(
                      height: 2,
                      width: double.infinity,
                      color: Colors.blue.shade500,
                    ),
                    style: kFormStyle.copyWith(
                        fontSize: 18, color: Colors.blue.shade500),
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
                        _valueCategoria = kListaCategorias.indexOf(newSelected);
                        widget.transacao.category =
                            kListaCategorias.indexOf(newSelected);
                        // ignore: unrelated_type_equality_checks
                        if (widget.transacao != Null) {
                          if (widget.transacao.category == kSalario ||
                              widget.transacao.category == kPensao)
                            widget.transacao.value = widget.transacao.value > 0
                                ? widget.transacao.value
                                : -widget.transacao.value;
                          else
                            widget.transacao.value = widget.transacao.value < 0
                                ? widget.transacao.value
                                : -widget.transacao.value;
                        }
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Data:',
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontSize: 20,
                ),
              ),
              MyCalendar(myDate: _selectedDate, selectDate: onDayPressed),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Descrição:',
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontSize: 20,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2.0, color: Colors.blue.shade500),
                  ),
                ),
                child: TextField(
                  cursorWidth: 2.0,
                  controller: _descricaoController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(20),
                  ],
                  cursorColor: Colors.blue.shade500,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  onChanged: (value) {
                    setState(() {
                      _descricao = value;
                      widget.transacao.descricao = value;
                    });
                  },
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                    color: Colors.blue.shade500,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Valor:',
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontSize: 20,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2.0, color: Colors.blue.shade500),
                  ),
                ),
                child: TextField(
                  controller: _valorController,
                  cursorWidth: 2.0,
                  cursorColor: Colors.blue.shade500,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                    color: Colors.blue.shade500,
                    fontSize: 20,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _valorController
                          .updateValue(_valorController.numberValue);
                      _valorInt = (_valorController.numberValue * 100).toInt();
                      if (widget.transacao.category == kSalario ||
                          widget.transacao.category == kPensao)
                        widget.transacao.value = _valorInt;
                      else
                        widget.transacao.value = -_valorInt;
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
                      color: Colors.blue.shade700,
                      fontSize: 20,
                    ),
                  ),
                  Checkbox(
                    value: _checkedValue,
                    onChanged: (bool value) {
                      setState(() {
                        _checkedValue = value;
                        widget.transacao.paid = value;
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
                      widget.transacao.value = widget.transacao.value ?? 0;
                      if (widget.transacao.value != 0) {
                        DBProvider2.db.updateTransacao(widget.transacao);
                        DBProvider2.db.saveTransacao(widget.transacao, _p);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    StatementsFilterScreen()));
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
      _selectedDate = date;
      widget.transacao.date = date.toString().split(" ")[0];
    });
  }
}
