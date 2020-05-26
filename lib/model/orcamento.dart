import 'dart:convert';

import 'package:flutter_app/util/constants.dart';

Orcamento OrcamentoFromJson(String str) {
  final jsonData = json.decode(str);
  return Orcamento.fromMap(jsonData);
}

Orcamento fromBudget(List<int> budget) {
  var retorno = Orcamento();
  retorno.alimentacao = budget[0];
  retorno.bolsaAuxilio = budget[1];
  retorno.higiene = budget[2];
  retorno.investimento = budget[3];
  retorno.lazer = budget[4];
  retorno.moradia = budget[5];
  retorno.pensao = budget[6];
  retorno.salario = budget[7];
  retorno.saude = budget[8];
  retorno.transporte = budget[9];
  retorno.universidade = budget[10];
  retorno.vestimenta = budget[11];
  retorno.outros = budget[12];
  return retorno;
}

String OrcamentoToJson(Orcamento data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Orcamento {
  int alimentacao;
  int bolsaAuxilio;
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
    this.bolsaAuxilio,
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
        bolsaAuxilio: json["$kBolsaAuxilio"],
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
        "$kBolsaAuxilio": bolsaAuxilio,
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
        "$kBolsaAuxilio: $bolsaAuxilio "
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
    budget.add(bolsaAuxilio);
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
