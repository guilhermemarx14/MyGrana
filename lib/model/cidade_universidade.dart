import 'dart:convert';

import 'package:flutter_app/database/Database1.dart';

CidadeUniversidade cidadeUniversidadeFromJson(String str) {
  final jsonData = json.decode(str);
  return CidadeUniversidade.fromMap(jsonData);
}

String cidadeUniversidadeToJson(CidadeUniversidade data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

//CIDADE E UNIVERSIDADE FORAM ABSTRAÍDOS COMO
//A MESMA CLASSE POR POSSUÍREM EXATAMENTE OS MESMOS ATRIBUTOS
class CidadeUniversidade implements Comparable {
  String nome;
  int id;
  int estado;

  CidadeUniversidade({this.id, this.nome, this.estado});

  factory CidadeUniversidade.fromMap(Map<String, dynamic> json) =>
      new CidadeUniversidade(
        estado: json["estado"],
        id: json["id"],
        nome: json["nome"],
      );

  static Future<List> getCidadesList(int idEstado) async {
    return await DBProvider.db.getCidadesList(idEstado);
  }

  static getUniversidadesList(int idEstado) async {
    return await DBProvider.db.getUniversidadesList(idEstado);
  }

  static getCidadeById(int id) async {
    return await DBProvider.db.getCidade(id);
  }

  static getUniversidadeById(int id) async {
    return await DBProvider.db.getUniversidade(id);
  }

  static getCidadeCount() {
    return DBProvider.db.getCidadeCount();
  }

  Map<String, dynamic> toMap() => {
        "estado": estado,
        "id": id,
        "nome": nome,
      };

  @override
  String toString() {
    return "Id: $id Nome: $nome estado: $estado";
  }

  @override
  int compareTo(other) {
    return this.nome.compareTo(other.name);
  }
}
