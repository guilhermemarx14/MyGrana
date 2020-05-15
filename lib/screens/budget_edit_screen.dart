import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/budget_button.dart';
import 'package:flutter_app/components/my_edit_card.dart';
import 'package:flutter_app/model/orcamento.dart';
import 'package:flutter_app/util/Database2.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'budget_screen.dart';
import 'home_screen.dart';

double totalGanhos = 0;
double totalGastos = 0;

class BudgetEditScreen extends StatefulWidget {
  const BudgetEditScreen({Key key}) : super(key: key);

  @override
  _BudgetEditScreenState createState() => _BudgetEditScreenState();
}

class _BudgetEditScreenState extends State<BudgetEditScreen> {
  List<int> orcamento;

  initState() {
//todo:erro de index fantasma
    orcamento = [];
    totalGanhos = 0;
    totalGastos = 0;
    DBProvider2.db.getOrcamento().then((result) {
      //print(result);
      setState(() {
        orcamento = result.getBudget();
        //print(orcamento);
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
            child: Column(
              children: <Widget>[
                PlanejadosEReais(
                  screenSize: screenSize,
                  titulo: 'Total',
                  totalGanhos: totalGanhos / 100,
                  totalGastos: totalGastos / 100,
                ),
                BudgetEditCards(
                  screenSize: screenSize,
                  orcamento: orcamento,
                  buttonAction: () {
                    DBProvider2.db.updateOrcamento(fromBudget(orcamento));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BudgetScreen()));
                  },
                  notifyParent: refresh,
                ),
              ],
            ),
          )),
    );
  }

  refresh(double ganhos, double gastos) {
    setState(() {
      totalGanhos = ganhos;
      totalGastos = gastos;
      print(ganhos.toString() + ' ' + gastos.toString());
    });
  }
}

class BudgetEditCards extends StatefulWidget {
  const BudgetEditCards(
      {Key key,
      @required this.screenSize,
      @required this.orcamento,
      @required this.buttonAction,
      @required this.notifyParent})
      : super(key: key);

  final double screenSize;
  final List<int> orcamento;
  final Function buttonAction;
  final Function notifyParent;
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
        category: i,
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
            totalGanhos = 0;
            totalGastos = 0;
            totalGanhos =
                ((widget.orcamento[kSalario] + widget.orcamento[kPensao]))
                    .toDouble();
            widget.orcamento.forEach((element) {
              totalGastos -= element;
            });
            totalGastos += totalGanhos;
            widget.notifyParent(totalGanhos, totalGastos);
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
