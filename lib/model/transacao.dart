import 'dart:convert';

Transacao TransacaoFromJson(String str) {
  final jsonData = json.decode(str);
  return Transacao.fromMap(jsonData);
}

String TransacaoToJson(Transacao data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Transacao {
  int category;
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

  factory Transacao.fromMap(Map<String, dynamic> json) => Transacao(
        category: json["category"],
        date: json["date"],
        descricao: json["descricao"],
        id: json["id"],
        paid: json["paid"] == 0 ? false : true,
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "category": category,
        "date": date,
        "descricao": descricao,
        "id": id,
        "paid": paid ? 1 : 0,
        "value": value
      };

  @override
  String toString() {
    return "Id: $id, Categoria: $category, Data: $date, Descricao: $descricao, Paid: $paid, Value: $value";
  }
}
