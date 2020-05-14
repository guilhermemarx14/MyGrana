import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/home_item.dart';
import 'package:flutter_app/components/my_card.dart';
import 'package:flutter_app/components/my_dialog.dart';
import 'package:flutter_app/model/profile.dart';
import 'package:flutter_app/screens/statements_filter_screen.dart';
import 'package:flutter_app/util/Database1.dart';
import 'package:flutter_app/util/Database2.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

double total = 0;
double totalNaoPago = 0;

class HomeScreen extends StatefulWidget {
  HomeScreen({this.p});
  Profile p;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  changeSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('first_time', false);
  }

  initState() {
    DBProvider2.db.getProfile().then((profile) {
      setState(() {
        widget.p = profile;
      });
    });

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
    super.initState();
  }

  double screenSize = 0;
  @override
  Widget build(BuildContext context) {
    changeSharedPreferences();
    DBProvider.db.drop();
    screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      floatingActionButton: FloatingActionButtonHome(p: widget.p),
      body: Column(
        children: <Widget>[
          AppBarHome(),
          TotalELancamentos(screenSize: screenSize),
          SizedBox(height: 100.0),
          FirstLineOptions(screenSize: screenSize),
          SecondLineOptions(screenSize: screenSize),
        ],
      ),
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
          icon: FontAwesomeIcons.infoCircle,
          title: 'Informações',
          onPressed: () {},
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
          icon: FontAwesomeIcons.clipboardList,
          title: 'Orçamento',
          onPressed: () {},
        ),
        HomeItem(
          height: widget.screenSize / 4,
          width: widget.screenSize / 4,
          icon: FontAwesomeIcons.mapMarkedAlt,
          title: 'Localização',
          onPressed: () {},
        ),
      ],
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
                total >= 0
                    ? 'R\$ ${total.toStringAsFixed(2)}'
                    : '- R\$ ${(-total).toStringAsFixed(2)}',
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
          color: Colors.blue.shade200,
          cardChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                totalNaoPago >= 0
                    ? 'R\$ ${totalNaoPago.toStringAsFixed(2).replaceFirst('\,', '.')}'
                    : '- R\$ ${(-totalNaoPago).toStringAsFixed(2).replaceFirst('\,', '.')}',
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

class AppBarHome extends StatelessWidget {
  const AppBarHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 20.0,
      centerTitle: true,
      backgroundColor: Colors.blue.shade500,
      title: Text(
        'MyGrana',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
      ),
    );
  }
}

class FloatingActionButtonHome extends StatefulWidget {
  const FloatingActionButtonHome({
    Key key,
    @required this.p,
  }) : super(key: key);

  final Profile p;

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
      backgroundColor: Colors.blue.shade700,
    );
  }
}
