import 'package:flutter/material.dart';
import 'package:flutter_app/components/budget_button.dart';
import 'package:flutter_app/components/my_card.dart';
import 'package:flutter_app/util/Database2.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import 'categories_screen.dart';
import 'home_screen.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({Key key}) : super(key: key);

  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  double totalGanhosPlanejados = 0;
  double totalGastosPlanejados = 0;
  double totalGanhosReais = 0;
  double totalGastosReais = 0;

  initState() {
    super.initState();
    DBProvider2.db.getOrcamento().then((orcamento) {
      //print(orcamento);
      setState(() {
        List<int> budget = orcamento.getBudget();
        totalGanhosPlanejados = (budget[kSalario] + budget[kPensao]).toDouble();
        budget.forEach((element) {
          totalGastosPlanejados -= element;
        });
        totalGastosPlanejados += totalGanhosPlanejados;
      });
    });

    DBProvider2.db
        .consultaTransacao(TODOS, DateTime.now().month.toString(),
            DateTime.now().year.toString())
        .then((list) {
      //print(list);
      setState(() {
        list.forEach((element) {
          //print(element);
          if (element.category == kSalario || element.category == kPensao)
            totalGanhosReais += element.value;
          else
            totalGastosReais -= element.value;
        });
      });
    });
  }

  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => HomeScreen()), (r) => false),
      child: Scaffold(
        backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          title: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 35.0, 0.0),
              child: Text(
                'Orçamento ${kMeses[DateTime.now().month]}/${DateTime.now().year.toString()}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                PlanejadosEReais(
                  screenSize: screenSize,
                  titulo: 'Planejado: ',
                  totalGanhos: totalGanhosPlanejados / 100,
                  totalGastos: totalGastosPlanejados / 100,
                ),
                PlanejadosEReais(
                  screenSize: screenSize,
                  titulo: 'Real: ',
                  totalGanhos: totalGanhosReais / 100,
                  totalGastos: totalGastosReais / 100,
                ),
              ],
            ),
            BudgetButton(
              screenSize: MediaQuery.of(context).size.width,
              text: 'Ver por Categoria',
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CategoriesScreen())),
            ),
          ],
        ),
      ),
    );
  }
}

class PlanejadosEReais extends StatelessWidget {
  const PlanejadosEReais({
    Key key,
    @required this.titulo,
    @required this.screenSize,
    @required this.totalGanhos,
    @required this.totalGastos,
  }) : super(key: key);

  final String titulo;
  final double screenSize;
  final double totalGanhos;
  final double totalGastos;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Text(
            titulo,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Total(
            screenSize: screenSize,
            totalGanhos: totalGanhos,
            totalGastos: totalGastos,
          ),
        ],
      ),
    );
  }
}

class Total extends StatefulWidget {
  Total({Key key, this.screenSize, this.totalGanhos, this.totalGastos})
      : super(key: key);
  double screenSize;
  double totalGastos;
  double totalGanhos;
  @override
  _TotalState createState() => _TotalState();
}

class _TotalState extends State<Total> {
  @override
  Widget build(BuildContext context) {
    var maskedTotalGanhos = FlutterMoneyFormatter(
      amount: widget.totalGanhos,
      settings: MoneyFormatterSettings(
          thousandSeparator: '.', decimalSeparator: ',', fractionDigits: 2),
    );

    var maskedTotalGastos = FlutterMoneyFormatter(
      amount: widget.totalGastos,
      settings: MoneyFormatterSettings(
          thousandSeparator: '.', decimalSeparator: ',', fractionDigits: 2),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        MyCard(
          width: widget.screenSize / 2.5,
          height: 60.0,
          color: Colors.blue.shade200,
          cardChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'R\$ '
                '${maskedTotalGanhos.output.nonSymbol}',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Total de ganhos',
                style: TextStyle(
                  fontSize: 10.0,
                  color: kBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        MyCard(
          width: widget.screenSize / 2.5,
          height: 60.0,
          color: Colors.blue.shade200,
          cardChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'R\$ '
                '${maskedTotalGastos.output.nonSymbol}',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Total de gastos',
                style: TextStyle(
                  fontSize: 10.0,
                  color: kBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
