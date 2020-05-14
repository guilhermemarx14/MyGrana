import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_card.dart';
import 'package:flutter_app/util/Database2.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:toast/toast.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({Key key}) : super(key: key);

  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  List<int> budget;
  double totalGanhosPlanejados = 0;
  double totalGastosPlanejados = 0;
  double totalGanhosReais = 0;
  double totalGastosReais = 0;

  initState() {
    super.initState();
    DBProvider2.db.getOrcamento().then((orcamento) {
      print(orcamento);
      setState(() {
        budget = orcamento.getBudget();
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
      print(list);
      setState(() {
        list.forEach((element) {
          print(element);
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
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Text(
          'Orçamento ${kMeses[DateTime.now().month]}/${DateTime.now().year.toString()}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      /*bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            BudgetButton(
              screenSize: screenSize,
              text: 'Detalhes do orçamento planejado',
              onTap: () => Toast.show(
                'onTap',
                context,
              ),
            ),
            BudgetButton(
              screenSize: screenSize,
              text: 'Detalhes do orçamento real',
              onTap: () => Toast.show(
                'onTap',
                context,
              ),
            ),
          ],
        ),
      ),*/
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
                titulo: 'Reais: ',
                totalGanhos: totalGanhosReais / 100,
                totalGastos: totalGastosReais / 100,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              BudgetButton(
                screenSize: screenSize,
                text: 'Detalhes do orçamento planejado',
                onTap: () => Toast.show(
                  'onTap',
                  context,
                ),
              ),
              BudgetButton(
                screenSize: screenSize,
                text: 'Detalhes do orçamento real',
                onTap: () => Toast.show(
                  'onTap',
                  context,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BudgetButton extends StatelessWidget {
  const BudgetButton({
    Key key,
    @required this.screenSize,
    @required this.text,
    @required this.onTap,
  }) : super(key: key);

  final double screenSize;
  final String text;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MyCard(
        color: Colors.blue.shade700,
        height: 70.0,
        width: screenSize,
        cardChild: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
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
                '${widget.totalGanhos.toStringAsFixed(2).replaceAll('.', '\,')}',
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
                '${(widget.totalGastos).toStringAsFixed(2).replaceAll('.', '\,')}',
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
