import 'dart:convert';

import 'package:flutter_app/util/Database1.dart';

Estado EstadoFromJson(String str) {
  final jsonData = json.decode(str);
  return Estado.fromMap(jsonData);
}

String EstadoToJson(Estado data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Estado implements Comparable {
  static List<Estado> listaEstados = [];
  static Estado estadoById;
  String nome;
  int id;

  Estado({this.id, this.nome});

  factory Estado.fromMap(Map<String, dynamic> json) => new Estado(
        id: json["id"],
        nome: json["nome"],
      );

  static getEstadosList() {
    return DBProvider.db.getEstadosList();
  }

  static getEstadoById(int estadoId) {
    return DBProvider.db.getEstado(estadoId);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "nome": nome,
      };

  @override
  String toString() {
    return "$nome";
  }

  @override
  int compareTo(other) {
    return this.nome.compareTo(other.nome);
  }
}
