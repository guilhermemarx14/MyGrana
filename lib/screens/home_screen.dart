import 'package:flutter/material.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_app/components/my_card.dart';
import 'package:flutter_app/components/home_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
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
