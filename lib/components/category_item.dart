import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/container_for_numbers.dart';
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
    double percent = planejado == 0 || real > planejado ? 1 : real / planejado;

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
    bool isGanho = false;
    if (kListaCategorias.indexOf(category) == kSalario ||
        kListaCategorias.indexOf(category) == kPensao ||
        kListaCategorias.indexOf(category) == kBolsaAuxilio) isGanho = true;
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kBackground,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 6,
            offset: Offset(0, 0),
          ),
        ],
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
                    progressColor:
                        percent >= 1 && !isGanho ? Colors.red : Colors.green,
                  ),
                  SizedBox(
                    height: 10,
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
                ContainerForNumbers(
                  width: 150,
                  height: 40,
                  child: Text(
                    'R\$ ${maskedReal.output.nonSymbol}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: real >= planejado && !isGanho
                            ? Colors.red
                            : Colors.green),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Text(
                    'R\$ ${maskedPlanejado.output.nonSymbol}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
