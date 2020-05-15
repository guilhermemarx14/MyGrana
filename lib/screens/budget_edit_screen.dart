import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/budget_button.dart';
import 'package:flutter_app/components/my_edit_card.dart';
import 'package:flutter_app/util/Database2.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'home_screen.dart';

class BudgetEditScreen extends StatefulWidget {
  const BudgetEditScreen({Key key}) : super(key: key);

  @override
  _BudgetEditScreenState createState() => _BudgetEditScreenState();
}

class _BudgetEditScreenState extends State<BudgetEditScreen> {
  List<int> orcamento;
  double totalGanhos = 0;
  double totalGastos = 0;
  initState() {
//todo:erro de index fantasma
    orcamento = [];
    DBProvider2.db.getOrcamento().then((result) {
      print(result);
      setState(() {
        orcamento = result.getBudget();
        print(orcamento);
        totalGanhos = (orcamento[kSalario] + orcamento[kPensao]).toDouble();
        orcamento.forEach((element) {
          totalGastos -= element;
        });
        totalGastos += totalGanhos;
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    String titulo = 'Planejar Orçamento';

    return WillPopScope(
      onWillPop: () => Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => HomeScreen()), (r) => false),
      child: Scaffold(
          backgroundColor: Colors.blue.shade100,
          appBar: AppBar(
            title: Text(
              titulo,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            child: BudgetEditCards(
              screenSize: screenSize,
              orcamento: orcamento,
              buttonAction: () => print(orcamento),
            ),
          )),
    );
  }
}

class BudgetEditCards extends StatefulWidget {
  const BudgetEditCards({
    Key key,
    @required this.screenSize,
    @required this.orcamento,
    @required this.buttonAction,
  }) : super(key: key);

  final double screenSize;
  final List<int> orcamento;
  final Function buttonAction;

  @override
  _BudgetEditCardsState createState() => _BudgetEditCardsState();
}

class _BudgetEditCardsState extends State<BudgetEditCards> {
  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [];
    var valorController = [];

    for (int i = 0; i < kTotalCategorias; i++) {
      //print('$i ${orcamento[i]}');
      valorController.add(MoneyMaskedTextController(
          decimalSeparator: ',',
          thousandSeparator: '.',
          initialValue: (widget.orcamento[i] / 100).toDouble(),
          leftSymbol: 'R\$ '));
      cards.add(MyEditCard(
        screenSize: widget.screenSize,
        text: kListaCategorias[i],
        valor: widget.orcamento[i] / 100,
        controller: valorController[i],
        onChange: (value) {
          setState(() {
            //print(valorController[i].numberValue);
            valorController[i].updateValue(valorController[i].numberValue);
            int valorInt = (valorController[i].numberValue * 100).toInt();
            if (i == kSalario || i == kPensao)
              widget.orcamento[i] = valorInt;
            else
              widget.orcamento[i] = -valorInt;
          });
        },
      ));
    }

    cards.add(
      BudgetButton(
        screenSize: widget.screenSize,
        text: 'Salvar',
        /*onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => BudgetScreen())),*/
        onTap: widget.buttonAction,
      ),
    );

    return Column(
      children: cards,
    );
  }
}
