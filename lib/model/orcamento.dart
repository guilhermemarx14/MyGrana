import 'dart:convert';

import 'package:flutter_app/util/constants.dart';

Orcamento ProfileFromJson(String str) {
  final jsonData = json.decode(str);
  return Orcamento.fromMap(jsonData);
}

Orcamento fromBudget(List<int> budget) {
  var retorno = Orcamento();
  retorno.alimentacao = budget[0];
  retorno.higiene = budget[1];
  retorno.investimento = budget[2];
  retorno.lazer = budget[3];
  retorno.moradia = budget[4];
  retorno.pensao = budget[5];
  retorno.salario = budget[6];
  retorno.saude = budget[7];
  retorno.transporte = budget[8];
  retorno.universidade = budget[9];
  retorno.vestimenta = budget[10];
  retorno.outros = budget[11];
  return retorno;
}

String OrcamentoToJson(Orcamento data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Orcamento {
  int alimentacao;
  int higiene;
  int investimento;
  int lazer;
  int moradia;
  int pensao;
  int salario;
  int saude;
  int transporte;
  int universidade;
  int vestimenta;
  int outros;

  Orcamento({
    this.alimentacao,
    this.higiene,
    this.investimento,
    this.lazer,
    this.moradia,
    this.pensao,
    this.salario,
    this.saude,
    this.transporte,
    this.universidade,
    this.vestimenta,
    this.outros,
  });

  factory Orcamento.fromMap(Map<String, dynamic> json) => Orcamento(
        alimentacao: json["$kAlimentacao"],
        higiene: json["$kHigiene"],
        investimento: json["$kInvestimento"],
        lazer: json["$kLazer"],
        moradia: json["$kMoradia"],
        pensao: json["$kPensao"],
        salario: json["$kSalario"],
        saude: json["$kSaude"],
        transporte: json["$kTransporte"],
        universidade: json["$kUniversidade"],
        vestimenta: json["$kVestimenta"],
        outros: json["$kOutros"],
      );

  Map<String, dynamic> toMap() => {
        "$kAlimentacao": alimentacao,
        "$kHigiene": higiene,
        "$kInvestimento": investimento,
        "$kLazer": lazer,
        "$kMoradia": moradia,
        "$kPensao": pensao,
        "$kSalario": salario,
        "$kSaude": saude,
        "$kTransporte": transporte,
        "$kUniversidade": universidade,
        "$kVestimenta": vestimenta,
        "$kOutros": outros,
      };

  @override
  String toString() {
    return "$kAlimentacao: $alimentacao "
        "$kHigiene: $higiene "
        "$kInvestimento: $investimento "
        "$kLazer: $lazer "
        "$kMoradia: $moradia "
        "$kPensao: $pensao "
        "$kSalario: $salario "
        "$kSaude: $saude "
        "$kTransporte: $transporte "
        "$kUniversidade: $universidade "
        "$kVestimenta: $vestimenta "
        "$kOutros: $outros ";
  }

  List<int> getBudget() {
    List<int> budget = [];
    budget.add(alimentacao);
    budget.add(higiene);
    budget.add(investimento);
    budget.add(lazer);
    budget.add(moradia);
    budget.add(pensao);
    budget.add(salario);
    budget.add(saude);
    budget.add(transporte);
    budget.add(universidade);
    budget.add(vestimenta);
    budget.add(outros);

    return budget;
  }
}
