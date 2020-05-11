import 'package:flutter/material.dart';
import 'package:flutter_app/components/home_card.dart';
import 'package:flutter_app/components/my_dialog.dart';
import 'package:flutter_app/model/profile.dart';
import 'package:flutter_app/screens/orcamentoScreen.dart';
import 'package:flutter_app/util/Database1.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'statements_screen.dart';

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
    return Scaffold(
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
        ));
  }
}
