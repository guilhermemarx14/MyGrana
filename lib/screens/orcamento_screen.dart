import 'package:flutter/material.dart';

class OrcamentoScreen extends StatefulWidget {
  const OrcamentoScreen({Key key}) : super(key: key);

  @override
  _OrcamentoScreenState createState() => _OrcamentoScreenState();
}

class _OrcamentoScreenState extends State<OrcamentoScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlatButton(
        child: Text('Teste'),
        onPressed: () {
          setState(() {});
        },
      ),
    );
  }
}
