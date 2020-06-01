import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/home_item.dart';
import 'package:flutter_app/components/my_card.dart';
import 'package:flutter_app/components/my_dialog.dart';
import 'package:flutter_app/model/profile.dart';
import 'package:flutter_app/screens/budget_screen.dart';
import 'package:flutter_app/screens/statements_filter_screen.dart';
import 'package:flutter_app/util/Database1.dart';
import 'package:flutter_app/util/Database2.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'budget_details_screen.dart';
import 'informations_screen.dart';

double total = 0;
double totalNaoPago = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Profile p;

  changeSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('first_time', false);
  }

  initState() {
    DBProvider2.db.getProfile().then((Profile value) => p = value);
    DBProvider2.db.totalAcumulado().then((value) {
      if (value != total)
        setState(() {
          total = value;
        });
    });
    DBProvider2.db.totalNaoPago().then((value) {
      if (value != totalNaoPago)
        setState(() {
          totalNaoPago = value;
        });
    });
    changeSharedPreferences();
    DBProvider.db.drop();

    super.initState();
  }

  double screenSize = 0;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Xopete2.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButtonHome(),
          body: Column(
            children: <Widget>[
              AppBarHome(),
              TotalELancamentos(screenSize: screenSize),
              SizedBox(height: 100.0),
              FirstLineOptions(screenSize: screenSize),
              SecondLineOptions(screenSize: screenSize),
            ],
          ),
        ),
      ),
    );
  }
}

class FloatingActionButtonHome extends StatefulWidget {
  const FloatingActionButtonHome({
    Key key,
  }) : super(key: key);

  @override
  _FloatingActionButtonHomeState createState() =>
      _FloatingActionButtonHomeState();
}

class _FloatingActionButtonHomeState extends State<FloatingActionButtonHome> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return MyDialog(
              context: context,
              category: kSalario,
              value: '',
              title: 'Nova Transação',
            );
          },
        );
        ;
      },
      child: Icon(FontAwesomeIcons.plus),
      backgroundColor: Color(0xFFf0b239),
    );
  }
}

class AppBarHome extends StatelessWidget {
  const AppBarHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Image.asset(
        'assets/XopeteNome.png',
        fit: BoxFit.contain,
        height: 70,
      ),
    );
  }
}

class TotalELancamentos extends StatefulWidget {
  TotalELancamentos({Key key, this.screenSize}) : super(key: key);
  double screenSize;

  @override
  _TotalELancamentosState createState() => _TotalELancamentosState();
}

class _TotalELancamentosState extends State<TotalELancamentos> {
  @override
  Widget build(BuildContext context) {
    var maskedMeuDinheiro = FlutterMoneyFormatter(
      amount: total,
      settings: MoneyFormatterSettings(
          thousandSeparator: '.', decimalSeparator: ',', fractionDigits: 2),
    );

    var maskedNaoPagos = FlutterMoneyFormatter(
      amount: totalNaoPago,
      settings: MoneyFormatterSettings(
          thousandSeparator: '.', decimalSeparator: ',', fractionDigits: 2),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        MyCard(
          width: widget.screenSize / 2.5,
          height: 60.0,
          color: Colors.white,
          cardChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                total >= 0
                    ? 'R\$ ${maskedMeuDinheiro.output.nonSymbol}'
                    : 'R\$ ${maskedMeuDinheiro.output.nonSymbol}',
                style: TextStyle(
                  fontSize: 20.0,
                  color: total >= 0 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Meu dinheiro',
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
          color: Colors.white,
          cardChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                totalNaoPago >= 0
                    ? 'R\$ ${maskedNaoPagos.output.nonSymbol}'
                    : 'R\$ ${maskedNaoPagos.output.nonSymbol}',
                style: TextStyle(
                  fontSize: 20.0,
                  color: totalNaoPago >= 0 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Lançamentos não-pagos',
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

class FirstLineOptions extends StatefulWidget {
  const FirstLineOptions({
    Key key,
    @required this.screenSize,
  }) : super(key: key);

  final double screenSize;

  @override
  _FirstLineOptionsState createState() => _FirstLineOptionsState();
}

class _FirstLineOptionsState extends State<FirstLineOptions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        HomeItem(
          height: widget.screenSize / 4,
          width: widget.screenSize / 4,
          icon: FontAwesomeIcons.searchDollar,
          title: 'Gastos e Rendas',
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BudgetDetailsScreen(TRANSACOES))),
        ),
        HomeItem(
            height: widget.screenSize / 4,
            width: widget.screenSize / 4,
            icon: FontAwesomeIcons.clipboardList,
            title: 'Planejamento',
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BudgetDetailsScreen(ORCAMENTO)))),
        /* HomeItem(
          height: widget.screenSize / 4,
          width: widget.screenSize / 4,
          icon: FontAwesomeIcons.mapMarkedAlt,
          title: 'Localização',
          onPressed: () {
            () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BudgetDetailsScreen(ORCAMENTO)));
          },
        ),*/
      ],
    );
  }
}

class SecondLineOptions extends StatefulWidget {
  const SecondLineOptions({
    Key key,
    @required this.screenSize,
  }) : super(key: key);

  final double screenSize;

  @override
  _SecondLineOptionsState createState() => _SecondLineOptionsState();
}

class _SecondLineOptionsState extends State<SecondLineOptions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        HomeItem(
          height: widget.screenSize / 4,
          width: widget.screenSize / 4,
          icon: FontAwesomeIcons.coins,
          title: 'Extratos',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StatementsFilterScreen()),
            );
          },
        ),
        HomeItem(
          height: widget.screenSize / 4,
          width: widget.screenSize / 4,
          icon: FontAwesomeIcons.tasks,
          title: 'Orçamento',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BudgetScreen()),
            );
          },
        ),
        HomeItem(
          height: widget.screenSize / 4,
          width: widget.screenSize / 4,
          icon: FontAwesomeIcons.infoCircle,
          title: 'Informações',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InformationScreen()),
            );
          },
        ),
      ],
    );
  }
}
