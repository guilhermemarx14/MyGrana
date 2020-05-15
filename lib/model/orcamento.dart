import 'dart:convert';

import 'package:flutter_app/util/constants.dart';

Orcamento ProfileFromJson(String str) {
  final jsonData = json.decode(str);
  return Orcamento.fromMap(jsonData);
}

Orcamento fromBudget(List<int> budget) {
  var retorno = Orcamento();
  retorno.alimentacao = budget[0];
  retorno.investimento = budget[1];
  retorno.lazer = budget[2];
  retorno.moradia = budget[3];
  retorno.pensao = budget[4];
  retorno.salario = budget[5];
  retorno.saude = budget[6];
  retorno.transporte = budget[7];
  retorno.universidade = budget[8];
  retorno.vestimenta = budget[9];

  return retorno;
}

String OrcamentoToJson(Orcamento data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Orcamento {
  int alimentacao;
  int investimento;
  int lazer;
  int moradia;
  int pensao;
  int salario;
  int saude;
  int transporte;
  int universidade;
  int vestimenta;

  Orcamento(
      {this.alimentacao,
      this.investimento,
      this.lazer,
      this.moradia,
      this.pensao,
      this.salario,
      this.saude,
      this.transporte,
      this.universidade,
      this.vestimenta});

  factory Orcamento.fromMap(Map<String, dynamic> json) => Orcamento(
        alimentacao: json["$kAlimentacao"],
        investimento: json["$kInvestimento"],
        lazer: json["$kLazer"],
        moradia: json["$kMoradia"],
        pensao: json["$kPensao"],
        salario: json["$kSalario"],
        saude: json["$kSaude"],
        transporte: json["$kTransporte"],
        universidade: json["$kUniversidade"],
        vestimenta: json["$kVestimenta"],
      );

  Map<String, dynamic> toMap() => {
        "$kAlimentacao": alimentacao,
        "$kInvestimento": investimento,
        "$kLazer": lazer,
        "$kMoradia": moradia,
        "$kPensao": pensao,
        "$kSalario": salario,
        "$kSaude": saude,
        "$kTransporte": transporte,
        "$kUniversidade": universidade,
        "$kVestimenta": vestimenta,
      };

  @override
  String toString() {
    return "$kAlimentacao: $alimentacao "
        "$kInvestimento: $investimento "
        "$kLazer: $lazer "
        "$kMoradia: $moradia "
        "$kPensao: $pensao "
        "$kSalario: $salario "
        "$kSaude: $saude "
        "$kTransporte: $transporte "
        "$kUniversidade: $universidade "
        "$kVestimenta: $vestimenta ";
  }

  List<int> getBudget() {
    List<int> budget = [];
    budget.add(alimentacao);
    budget.add(investimento);
    budget.add(lazer);
    budget.add(moradia);
    budget.add(pensao);
    budget.add(salario);
    budget.add(saude);
    budget.add(transporte);
    budget.add(universidade);
    budget.add(vestimenta);

    return budget;
  }
}
