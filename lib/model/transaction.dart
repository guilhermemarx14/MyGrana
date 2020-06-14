import 'dart:convert';

import 'package:flutter_app/database/Database2.dart';
import 'package:flutter_app/model/profile.dart';

Transaction transactionFromJson(String str) {
  final jsonData = json.decode(str);
  return Transaction.fromMap(jsonData);
}

String transactionToJson(Transaction data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Transaction {
  int category;
  String date;
  String description;
  int id;
  bool paid;
  int value;

  Transaction(
      {this.category,
      this.date,
      this.description,
      this.id,
      this.paid,
      this.value});

  factory Transaction.fromMap(Map<String, dynamic> json) => Transaction(
        category: json["category"],
        date: json["date"],
        description: json["description"],
        id: json["id"],
        paid: json["paid"] == 0 ? false : true,
        value: json["value"],
      );

  static getTransactionId() {
    return DBProvider2.db.getTransacaoId();
  }

  static paidTotal() {
    return DBProvider2.db.totalAcumulado();
  }

  static unpaidTotal() {
    return DBProvider2.db.totalNaoPago();
  }

  static updateTransaction(Transaction t) async {
    await DBProvider2.db.updateTransacao(t);
  }

  static saveTransaction(Transaction t, Profile p) async {
    await DBProvider2.db.saveTransacao(t, p);
  }

  static createTransaction(Transaction t) async {
    await DBProvider2.db.createTransacao(t);
  }

  static queryTransaction(String category, String mes, String ano) {
    return DBProvider2.db.consultaTransacao(category, mes, ano);
  }

  static deleteTransaction(Transaction t, Profile p) async {
    await DBProvider2.db.deleteTransacao(t, p);
  }

  Map<String, dynamic> toMap() => {
        "category": category,
        "date": date,
        "description": description,
        "id": id,
        "paid": paid ? 1 : 0,
        "value": value
      };

  @override
  String toString() {
    return "Id: $id, Categoria: $category, Data: $date, Descricao: $description, Paid: $paid, Value: $value\n";
  }
}
