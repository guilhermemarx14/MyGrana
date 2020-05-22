import 'package:flutter/material.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key key,
    @required this.category,
    @required this.real,
    @required this.planejado,
  }) : super(key: key);

  final String category;
  final double real;
  final double planejado;

  @override
  Widget build(BuildContext context) {
    double percent = planejado == 0 ? 0 : real / planejado;

    var maskedPlanejado = FlutterMoneyFormatter(
      amount: planejado / 100,
      settings: MoneyFormatterSettings(
          thousandSeparator: '.', decimalSeparator: ',', fractionDigits: 2),
    );
    var maskedReal = FlutterMoneyFormatter(
      amount: real / 100,
      settings: MoneyFormatterSettings(
          thousandSeparator: '.', decimalSeparator: ',', fractionDigits: 2),
    );

    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kButton.withOpacity(0.5),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    category,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width / 1.5,
                    lineHeight: 20.0,
                    percent: percent <= 1 ? percent : 1,
                    progressColor: percent >= 1 ? Colors.red : Colors.green,
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 8,
                0, MediaQuery.of(context).size.width / 8, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'R\$ ${maskedReal.output.nonSymbol}',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Text(
                  'R\$ ${maskedPlanejado.output.nonSymbol}',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
