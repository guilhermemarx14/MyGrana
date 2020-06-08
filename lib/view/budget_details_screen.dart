import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/budget_button.dart';
import 'package:flutter_app/widgets/container_for_numbers.dart';
import 'package:flutter_app/widgets/my_card.dart';
import 'package:flutter_app/model/transacao.dart';
import 'package:flutter_app/view/statements_screen.dart';
import 'package:flutter_app/database/Database2.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import 'budget_edit_screen.dart';
import 'budget_screen.dart';
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
    totalGastos = 0;
    totalGanhos = 0;
    orcamento = [];
    transacoes = [];
    if (widget.type == ORCAMENTO)
      DBProvider2.db.getOrcamento().then((result) {
        //print(result);
        setState(() {
          orcamento = result.getBudget();
          //print(orcamento);
          totalGanhos = (orcamento[kSalario] +
                  orcamento[kPensao] +
                  orcamento[kBolsaAuxilio])
              .toDouble();
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
            if (element.category == kSalario ||
                element.category == kPensao ||
                element.category == kBolsaAuxilio)
              totalGanhos += element.value;
            else
              totalGastos -= element.value;
          });
        });
      });

    super.initState();
  }

  Widget build(BuildContext context) {
    if (orcamento.isEmpty) setState(() {});
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
        backgroundColor: kBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 35.0, 0.0),
              child: Text(
                titulo,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              PlanejadosEReais(
                screenSize: screenSize,
                titulo: widget.type == ORCAMENTO
                    ? 'Orçamento: '
                    : 'Gastos e Rendas mensais:',
                totalGanhos: totalGanhos / 100,
                totalGastos: totalGastos / 100,
              ),
              BudgetCards(
                  screenSize: screenSize,
                  type: widget.type,
                  orcamento: orcamento,
                  transacoes: transacoes),
            ],
          ),
        ),
      ),
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
    this.onTap,
  }) : super(key: key);
  final int type;
  final double screenSize;
  final List<int> orcamento;
  final List<Transacao> transacoes;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    var maskedText = [];

    List<Widget> cards = [];
    if (type == TRANSACOES) {
      if (orcamento.isNotEmpty) orcamento.removeLast();
      for (int i = 0; i < kTotalCategorias; i++) orcamento.add(0);
      for (int i = 0; i < transacoes.length; i++)
        orcamento[transacoes[i].category] += transacoes[i].value;
    }
    for (int i = 0; i < kTotalCategorias; i++) {
      String valorCategoria;
      //print('$i ${orcamento[i]}');
      try {
        maskedText.add(FlutterMoneyFormatter(
          amount: orcamento[i] / 100,
          settings: MoneyFormatterSettings(
              thousandSeparator: '.', decimalSeparator: ',', fractionDigits: 2),
        ));
        valorCategoria = 'R\$ ' + maskedText[i].output.nonSymbol;
      } catch (Exception) {
        valorCategoria =
            'R\$ ' + (0.0).toStringAsFixed(2).replaceAll('.', '\,');
      }
      cards.add(
        MyCard(
          onTap: type == ORCAMENTO
              ? () {}
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StatementsScreen(
                              categoria: kListaCategorias[i],
                              mes: DateTime.now().month.toString(),
                              ano: DateTime.now().year.toString(),
                            )),
                  );
                },
          width: screenSize,
          height: 70.0,
          color: kBackground,
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
                ContainerForNumbers(
                  width: 160,
                  height: 40,
                  child: Text(
                    valorCategoria,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: (i == kSalario ||
                                i == kPensao ||
                                i == kBolsaAuxilio)
                            ? Colors.green
                            : Colors.red),
                  ),
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
          color: kButton,
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
