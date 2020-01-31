import 'package:flutter/material.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_app/components/my_card.dart';

class HomeCard extends StatelessWidget {
  HomeCard(
      {@required this.title,
      @required this.text,
      @required this.maxValue,
      @required this.value,
      @required this.color});

  final String title;
  final String text;
  final double maxValue;
  final double value;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return MyCard(
      color: color,
      cardChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: kBlack,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            text,
            style: TextStyle(fontSize: 25.0),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 30.0,
              thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: 0.0,
              ),
            ),
            child: Slider(
              value: value > maxValue ? maxValue : value,
              min: 0,
              max: maxValue,
            ),
          ),
        ],
      ),
    );
  }
}
