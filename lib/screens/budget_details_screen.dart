import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/budget_button.dart';
import 'package:flutter_app/components/my_card.dart';
import 'package:flutter_app/model/transacao.dart';
import 'package:flutter_app/util/Database2.dart';
import 'package:flutter_app/util/constants.dart';

import 'budget_edit_screen.dart';
import 'home_screen.dart';

class BudgetDetailsScreen extends StatefulWidget {
  const BudgetDetailsScreen(this.type, {Key key}) : super(key: key);

  final int type;
  @override
  _BudgetDetailsScreenState createState() => _BudgetDetailsScreenState();
}

class _BudgetDetailsScreenState extends State<BudgetDetailsScreen> {
  List<int> orcamento;
  List<Transacao> transacoes;
  double totalGanhos = 0;
  double totalGastos = 0;
  initState() {
    orcamento = [];
    transacoes = [];
//todo:erro de index fantasma
    if (widget.type == ORCAMENTO)
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
    else
      DBProvider2.db
          .consultaTransacao(TODOS, DateTime.now().month.toString(),
              DateTime.now().year.toString())
          .then((result) {
        result.forEach((transacao) => transacoes.add(transacao));
        //print(result);
        setState(() {
          transacoes.forEach((element) {
            //print(element);
            if (element.category == kSalario || element.category == kPensao)
              totalGanhos += element.value;
            else
              totalGastos -= element.value;
          });
        });
      });

    super.initState();
  }

  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    String titulo = widget.type == ORCAMENTO
        ? 'Orçamento Planejado para\n'
        : 'Gastos Realizados em\n';
    titulo +=
        '${kMeses[DateTime.now().month]}/${DateTime.now().year.toString()}';
    return WillPopScope(
      onWillPop: () => Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => HomeScreen()), (r) => false),
      child: Scaffold(
          backgroundColor: Colors.blue.shade100,
          appBar: AppBar(
            title: Text(
              titulo,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            child: BudgetCards(
                screenSize: screenSize,
                type: widget.type,
                orcamento: orcamento,
                transacoes: transacoes),
          )),
    );
  }
}

class BudgetCards extends StatelessWidget {
  const BudgetCards({
    Key key,
    @required this.screenSize,
    @required this.type,
    @required this.orcamento,
    @required this.transacoes,
  }) : super(key: key);
  final int type;
  final double screenSize;
  final List<int> orcamento;
  final List<Transacao> transacoes;

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [];
    if (type == TRANSACOES) {
      orcamento.removeLast();
      for (int i = 0; i < kTotalCategorias; i++) orcamento.add(0);
      for (int i = 0; i < transacoes.length; i++)
        orcamento[transacoes[i].category] += transacoes[i].value;
    }
    for (int i = 0; i < kTotalCategorias; i++) {
      //print('$i ${orcamento[i]}');
      cards.add(
        MyCard(
          width: screenSize,
          height: 70.0,
          color: Colors.blue.shade200,
          cardChild: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  kListaCategorias[i],
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'R\$ ' +
                      (orcamento[i] / 100)
                          .toStringAsFixed(2)
                          .replaceAll('.', '\,'),
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: (i == kSalario || i == kPensao)
                          ? Colors.green
                          : Colors.red),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (type == ORCAMENTO)
      cards.add(
        BudgetButton(
          screenSize: screenSize,
          text: 'Editar orçamento',
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => BudgetEditScreen())),
        ),
      );

    return Column(
      children: cards,
    );
  }
}