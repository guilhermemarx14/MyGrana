import 'package:flutter/material.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_app/components/home_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Extratos'),
                          Icon(Icons.arrow_right),
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed: () {},
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
                return AlertDialog(
                  backgroundColor: Colors.blue.shade100,
                  title: Text("Alert Dialog title"),
                  content: Text("Alert Dialog body"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  actions: <Widget>[
                    // usually buttons at the bottom of the dialog
                    new FlatButton(
                      child: new Text("Close"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
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
                title: 'Salário',
                text: 'R\$100/200',
                maxValue: 200.0,
                value: 100,
                color: Colors.green.shade100,
              ),
              HomeCard(
                title: 'Pensão',
                text: 'R\$100/200',
                maxValue: 200.0,
                value: 100,
                color: Colors.green.shade100,
              ),
              HomeCard(
                title: 'Moradia',
                text: 'R\$200/200',
                maxValue: 200.0,
                value: 200,
                color: Colors.red.shade100,
              ),
              HomeCard(
                title: 'Alimentação',
                text: 'R\$100/200',
                maxValue: 200.0,
                value: 100,
                color: Colors.blue.shade100,
              ),
              HomeCard(
                title: 'Saúde',
                text: 'R\$100/200',
                maxValue: 200.0,
                value: 100,
                color: Colors.blue.shade100,
              ),
              HomeCard(
                title: 'Lazer',
                text: 'R\$100/200',
                maxValue: 200.0,
                value: 100,
                color: Colors.blue.shade100,
              ),
              HomeCard(
                title: 'Vestimenta',
                text: 'R\$100/200',
                maxValue: 200.0,
                value: 100,
                color: Colors.blue.shade100,
              ),
              HomeCard(
                title: 'Transporte',
                text: 'R\$100/200',
                maxValue: 200.0,
                value: 100,
                color: Colors.blue.shade100,
              ),
              HomeCard(
                title: 'Investimentos',
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
