import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_card.dart';
import 'package:flutter_app/components/my_dialog.dart';
import 'package:flutter_app/model/profile.dart';
import 'package:flutter_app/util/Database1.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  Widget build(BuildContext context) {
    DBProvider.db.drop();
    changeSharedPreferences();
    double screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      floatingActionButton: FloatingActionButtonHome(widget: widget),
      body: Column(
        children: <Widget>[
          AppBarHome(),
          TotalELancamentos(screenSize: screenSize),
        ],
      ),
    );
    /*return Scaffold(
        backgroundColor: kWhite,
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                accountName: Text(
                  'UserName',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Meu dinheiro',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      Text(
                        'R\$ 350',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.blue.shade100,
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StatementsScreen(type: 1)),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Extratos'),
                          Icon(Icons.arrow_right),
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrcamentoScreen()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Orçamentos'),
                          Icon(Icons.arrow_right),
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Média da sua localidade'),
                          Icon(Icons.arrow_right),
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Sobre o App'),
                          Icon(Icons.arrow_right),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return MyDialog(
                  p: widget.p,
                  context: context,
                  category: kSalario,
                  value: '',
                  title: 'Nova Transação',
                );
              },
            );
          },
          child: Icon(FontAwesomeIcons.plus),
          backgroundColor: Colors.red,
        ),
        appBar: AppBar(
          title: Text(
            'MyGrana',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: PreferredSize(
            child: Text(
              'Fev/2020',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            preferredSize: null,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              HomeCard(
                title: 'Total',
                text: 'R\$700/1400',
                maxValue: 1400.0,
                value: 700,
                color: Colors.blue.shade100,
              ),
              HomeCard(
                title: kListaCategorias[kSalario],
                text: 'R\$100/200',
                maxValue: 200.0,
                value: 100,
                color: Colors.green.shade100,
              ),
              HomeCard(
                title: kListaCategorias[kPensao],
                text: 'R\$100/200',
                maxValue: 200.0,
                value: 100,
                color: Colors.green.shade100,
              ),
              HomeCard(
                title: kListaCategorias[kMoradia],
                text: 'R\$200/200',
                maxValue: 200.0,
                value: 200,
                color: Colors.red.shade100,
              ),
              HomeCard(
                title: kListaCategorias[kAlimentacao],
                text: 'R\$100/200',
                maxValue: 200.0,
                value: 100,
                color: Colors.blue.shade100,
              ),
              HomeCard(
                title: kListaCategorias[kLazer],
                text: 'R\$100/200',
                maxValue: 200.0,
                value: 100,
                color: Colors.blue.shade100,
              ),
              HomeCard(
                title: kListaCategorias[kVestimenta],
                text: 'R\$100/200',
                maxValue: 200.0,
                value: 100,
                color: Colors.blue.shade100,
              ),
              HomeCard(
                title: kListaCategorias[kSaude],
                text: 'R\$100/200',
                maxValue: 200.0,
                value: 100,
                color: Colors.blue.shade100,
              ),
              HomeCard(
                title: kListaCategorias[kTransporte],
                text: 'R\$100/200',
                maxValue: 200.0,
                value: 100,
                color: Colors.blue.shade100,
              ),
              HomeCard(
                title: kListaCategorias[kInvestimento],
                text: 'R\$100/200',
                maxValue: 200.0,
                value: 100,
                color: Colors.blue.shade100,
              ),
            ],
          ),
        ));*/
  }
}

class TotalELancamentos extends StatelessWidget {
  const TotalELancamentos({
    Key key,
    @required this.screenSize,
  }) : super(key: key);

  final double screenSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        MyCard(
          width: screenSize / 2.5,
          height: 60.0,
          color: Colors.blue.shade200,
          cardChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'R\$ 200',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Total acumulado',
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
          width: screenSize / 2.5,
          height: 60.0,
          color: Colors.blue.shade200,
          cardChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '- R\$ 200',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Lançamentos futuros',
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
      title: Text(
        'MyGrana',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
      ),
    );
  }
}

class FloatingActionButtonHome extends StatelessWidget {
  const FloatingActionButtonHome({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final HomeScreen widget;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return MyDialog(
              p: widget.p,
              context: context,
              category: kSalario,
              value: '',
              title: 'Nova Transação',
            );
          },
        );
      },
      child: Icon(FontAwesomeIcons.plus),
      backgroundColor: Colors.red,
    );
  }
}
