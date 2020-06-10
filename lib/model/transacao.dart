import 'dart:convert';

Transacao transacaoFromJson(String str) {
  final jsonData = json.decode(str);
  return Transacao.fromMap(jsonData);
}

String transacaoToJson(Transacao data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Transacao {
  int category;
  String date;
  String description;
  int id;
  bool paid;
  int value;

  Transacao(
      {this.category,
      this.date,
      this.description,
      this.id,
      this.paid,
      this.value});

  factory Transacao.fromMap(Map<String, dynamic> json) => Transacao(
        category: json["category"],
        date: json["date"],
        description: json["description"],
        id: json["id"],
        paid: json["paid"] == 0 ? false : true,
        value: json["value"],
      );

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
