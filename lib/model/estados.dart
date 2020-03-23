import 'dart:convert';

import 'package:flutter_app/util/Database.dart';

Estado EstadoFromJson(String str) {
  final jsonData = json.decode(str);
  return Estado.fromMap(jsonData);
}

String EstadoToJson(Estado data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Estado {
  String name;
  int id;

  Estado({this.id, this.name});

  factory Estado.fromMap(Map<String, dynamic> json) => new Estado(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
