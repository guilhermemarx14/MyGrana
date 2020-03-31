import 'dart:convert';

import 'package:flutter_app/util/Database.dart';
import 'package:sqflite/sqflite.dart';

Estado EstadoFromJson(String str) {
  final jsonData = json.decode(str);
  return Estado.fromMap(jsonData);
}

String EstadoToJson(Estado data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Estado {
  static List<Estado> listaEstados = [];

  String nome;
  int id;

  Estado({this.id, this.nome});

  factory Estado.fromMap(Map<String, dynamic> json) => new Estado(
        id: json["id"],
        nome: json["nome"],
      );

  static getEstadosList() {
    print(listaEstados);
/*
    return estadosList(DBProvider.db.getEstadosList());*/
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "nome": nome,
      };

  @override
  String toString() {
    return "Id: $id Nome: $nome";
  }
}
