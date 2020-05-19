import 'package:flutter/material.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ListCategory extends StatelessWidget {
  ListCategory(
      {@required this.category, @required this.planejado, @required this.real});

  final int category;
  final int planejado;
  final int real;
  @override
  Widget build(BuildContext context) {
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '${kListaCategorias[category]}',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.0),
        ),
        Row(
          children: <Widget>[
            Text(
              'R\$ ${maskedPlanejado.output.nonSymbol}',
              style: TextStyle(
                  color: (category == kSalario || category == kPensao)
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                FontAwesomeIcons.arrowRight,
                color: Colors.white,
                size: 20.0,
              ),
            ),
            Container(
              width: 90,
              child: Text(
                'R\$ ${maskedReal.output.nonSymbol}',
                style: TextStyle(
                    color: (category == kSalario || category == kPensao)
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
              ),
            )
          ],
        )
      ],
    );
  }
}
