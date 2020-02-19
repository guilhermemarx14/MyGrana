import 'package:flutter_app/util/constants.dart';

class Orcamento {
  static Orcamento _instance;

  List<double> orcamentoAtual;
  List<double> orcamentoServidor;

  factory Orcamento(
      {List<double> orcamentoAtual, List<double> orcamentoServidor}) {
    //todo: receber orcamento atual e do servidor do bd
    orcamentoAtual ??= orcamentoServidor;
    _instance ??= Orcamento._constructor(orcamentoAtual, orcamentoServidor);
    return _instance;
  }

  Orcamento._constructor(this.orcamentoAtual, this.orcamentoServidor);
}
