import 'package:firebase_database/firebase_database.dart';

class Transacao {
  String category;
  String date;
  String descricao;
  int id;
  bool paid;
  int value;

  Transacao(
      {this.category,
      this.date,
      this.descricao,
      this.id,
      this.paid,
      this.value});

  Transacao.fromSnapshot(DataSnapshot snapshot)
      : category = snapshot.value["category"],
        date = snapshot.value["date"],
        descricao = snapshot.value["descricao"],
        id = snapshot.value["id"],
        paid = snapshot.value["paid"],
        value = snapshot.value["value"];

  toJson() {
    return {
      "category": category,
      "date": date,
      "descricao": descricao,
      "id": id,
      "paid": paid,
      "value": value,
    };
  }
}
