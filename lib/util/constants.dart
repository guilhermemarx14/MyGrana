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
const String ALIMENTACAO = 'Alimentação';
const String LAZER = 'Lazer';
const String VESTIMENTA = 'Vestimenta';
const String SAUDE = 'Saude';
const String TRANSPORTE = 'Transporte';
const String INVESTIMENTO = 'Investimento';
const String UNIVERSIDADE = 'Universidade';
const String TODOS = 'Todos';

const int kAlimentacao = 0;
const int kInvestimento = 1;
const int kLazer = 2;
const int kMoradia = 3;
const int kPensao = 4;
const int kSalario = 5;
const int kSaude = 6;
const int kTransporte = 7;
const int kUniversidade = 8;
const int kVestimenta = 9;
const int kTotalCategorias = 10;
const List<String> kListaCategorias = [
  'Alimentação',
  'Investimento',
  'Lazer',
  'Moradia',
  'Pensão',
  'Salário',
  'Saúde',
  'Transporte',
  'Universidade',
  'Vestimenta',
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
