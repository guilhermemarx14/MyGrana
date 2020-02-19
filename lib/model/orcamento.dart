class Orcamento {
  static Orcamento _instance;

  List<double> orcamentoAtual;
  List<double> orcamentoServidor;

  factory Orcamento(
      {List<double> orcamentoAtual, List<double> orcamentoServidor}) {
    orcamentoAtual ??=orcamentoServidor;
    _instance ??= Orcamento._constructor(orcamentoAtual, orcamentoServidor);
    return _instance;
  }

  Orcamento._constructor(this.orcamentoAtual, this.orcamentoServidor);
}
