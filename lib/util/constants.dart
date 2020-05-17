import 'package:flutter/material.dart';

const Color kBlue = Colors.blue;
const Color kWhite = Colors.white;
const Color kBlack = Color(0xFF444444);

const TextStyle kFormStyle = TextStyle(fontSize: 30.0, color: kWhite);
const TextStyle kFormStyle2 =
    TextStyle(fontSize: 25.0, color: kWhite, fontWeight: FontWeight.bold);
const TextStyle kTitleStyle =
    TextStyle(fontSize: 35.0, color: kWhite, fontWeight: FontWeight.bold);
const TextStyle kStatementsStyle =
    TextStyle(fontSize: 18.0, color: kWhite, fontWeight: FontWeight.bold);

const String SALARIO = 'Salário';
const String PENSAO = 'Pensão';
const String MORADIA = 'Moradia';
const String HIGIENE = 'Higiene';
const String ALIMENTACAO = 'Alimentação';
const String LAZER = 'Lazer';
const String VESTIMENTA = 'Vestimenta';
const String SAUDE = 'Saude';
const String TRANSPORTE = 'Transporte';
const String INVESTIMENTO = 'Investimento';
const String UNIVERSIDADE = 'Universidade';
const String TODOS = 'Todos';

const int kAlimentacao = 0;
const int kHigiene = 1;
const int kInvestimento = 2;
const int kLazer = 3;
const int kMoradia = 4;
const int kPensao = 5;
const int kSalario = 6;
const int kSaude = 7;
const int kTransporte = 8;
const int kUniversidade = 9;
const int kVestimenta = 10;
const int kOutros = 11;
const int kTotalCategorias = 12;
const List<String> kListaCategorias = [
  'Alimentação',
  'Higiene',
  'Investimento',
  'Lazer',
  'Moradia',
  'Pensão',
  'Salário',
  'Saúde',
  'Transporte',
  'Universidade',
  'Vestimenta',
  'Outros',
];

const List<String> kMeses = [
  '',
  'Janeiro',
  'Fevereiro',
  'Março',
  'Abril',
  'Maio',
  'Junho',
  'Julho',
  'Agosto',
  'Setembro',
  'Outubro',
  'Novembro',
  'Dezembro',
];

const List<String> kAnos = [
  '2020',
  '2021',
  '2022',
  '2023',
];

//CONSTANTES PARA TELA DE ORÇAMENTOS
const int ORCAMENTO = 1;
const int TRANSACOES = 2;
