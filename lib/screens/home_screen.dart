import 'package:flutter/material.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:flutter_app/components/continue_button.dart';
import 'package:flutter_app/components/back_button.dart' as back;
import 'data_screen.dart';
import 'package:flutter_app/components/my_card.dart';

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
              MyCard(
                color: Colors.blue.shade100,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(
                        color: kBlack,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$700/1.400',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: Colors.green,
                        activeTrackColor: Colors.red,
                        trackHeight: 30.0,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 0.0,
                        ),
                      ),
                      child: Slider(
                        value: 300,
                        min: 0,
                        max: 1500,
                      ),
                    ),
                  ],
                ),
              ),
              MyCard(
                color: Colors.green.shade100,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Salário',
                      style: TextStyle(
                        color: kBlack,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$100/200',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: Colors.green,
                        activeTrackColor: Colors.red,
                        trackHeight: 30.0,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 0.0,
                        ),
                      ),
                      child: Slider(
                        value: 100,
                        min: 0,
                        max: 200,
                      ),
                    ),
                  ],
                ),
              ),
              MyCard(
                color: Colors.green.shade100,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Pensão',
                      style: TextStyle(
                        color: kBlack,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$100/200',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: Colors.green,
                        activeTrackColor: Colors.red,
                        trackHeight: 30.0,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 0.0,
                        ),
                      ),
                      child: Slider(
                        value: 100,
                        min: 0,
                        max: 200,
                      ),
                    ),
                  ],
                ),
              ),
              MyCard(
                color: Colors.red.shade100,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Moradia',
                      style: TextStyle(
                        color: kBlack,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$200/200',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: Colors.green,
                        activeTrackColor: Colors.red,
                        trackHeight: 30.0,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 0.0,
                        ),
                      ),
                      child: Slider(
                        value: 200,
                        min: 0,
                        max: 200,
                      ),
                    ),
                  ],
                ),
              ),
              MyCard(
                color: Colors.blue.shade100,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Alimentação',
                      style: TextStyle(
                        color: kBlack,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$100/200',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: Colors.green,
                        activeTrackColor: Colors.red,
                        trackHeight: 30.0,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 0.0,
                        ),
                      ),
                      child: Slider(
                        value: 100,
                        min: 0,
                        max: 200,
                      ),
                    ),
                  ],
                ),
              ),
              MyCard(
                color: Colors.blue.shade100,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Saúde',
                      style: TextStyle(
                        color: kBlack,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$100/200',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: Colors.green,
                        activeTrackColor: Colors.red,
                        trackHeight: 30.0,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 0.0,
                        ),
                      ),
                      child: Slider(
                        value: 100,
                        min: 0,
                        max: 200,
                      ),
                    ),
                  ],
                ),
              ),
              MyCard(
                color: Colors.blue.shade100,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Lazer',
                      style: TextStyle(
                        color: kBlack,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$100/200',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: Colors.green,
                        activeTrackColor: Colors.red,
                        trackHeight: 30.0,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 0.0,
                        ),
                      ),
                      child: Slider(
                        value: 100,
                        min: 0,
                        max: 200,
                      ),
                    ),
                  ],
                ),
              ),
              MyCard(
                color: Colors.blue.shade100,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Vestimenta',
                      style: TextStyle(
                        color: kBlack,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$100/200',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: Colors.green,
                        activeTrackColor: Colors.red,
                        trackHeight: 30.0,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 0.0,
                        ),
                      ),
                      child: Slider(
                        value: 100,
                        min: 0,
                        max: 200,
                      ),
                    ),
                  ],
                ),
              ),
              MyCard(
                color: Colors.blue.shade100,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Transporte',
                      style: TextStyle(
                        color: kBlack,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$100/200',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: Colors.green,
                        activeTrackColor: Colors.red,
                        trackHeight: 30.0,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 0.0,
                        ),
                      ),
                      child: Slider(
                        value: 100,
                        min: 0,
                        max: 200,
                      ),
                    ),
                  ],
                ),
              ),
              MyCard(
                color: Colors.blue.shade100,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Investimentos',
                      style: TextStyle(
                        color: kBlack,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$100/200',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        inactiveTrackColor: Colors.green,
                        activeTrackColor: Colors.red,
                        trackHeight: 30.0,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 0.0,
                        ),
                      ),
                      child: Slider(
                        value: 100,
                        min: 0,
                        max: 200,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
