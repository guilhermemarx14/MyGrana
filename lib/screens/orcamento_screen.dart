import 'package:flutter/material.dart';
import 'package:flutter_app/model/orcamento.dart';
import 'package:flutter_app/util/constants.dart';

class OrcamentoScreen extends StatefulWidget {
  const OrcamentoScreen({Key key}) : super(key: key);

  @override
  _OrcamentoScreenState createState() => _OrcamentoScreenState();
}

class _OrcamentoScreenState extends State<OrcamentoScreen> {
  @override
  _OrcamentoScreenState() {
    singleton = Orcamento();
    orcamentoAtual = singleton.orcamentoAtual;
    totalOrcamento = 0;
    int count;
    for (count = 0; count < kTotalCategorias; count++)
      totalOrcamento = orcamentoAtual[count];
  }

  Orcamento singleton;
  double totalOrcamento;
  List<double> orcamentoAtual;

  Widget build(BuildContext context) {
    return Scaffold(
      body: FlatButton(
        child: Text('Teste'),
        onPressed: () {
          setState(() {
            print(orcamentoAtual);
          });
        },
      ),
    );
  }
}
