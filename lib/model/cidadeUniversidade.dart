import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/util/Database.dart';
import 'package:sqflite/sqflite.dart';

CidadeUniversidade cidadeUniversidadeFromJson(String str) {
  final jsonData = json.decode(str);
  return CidadeUniversidade.fromMap(jsonData);
}

String cidadeUniversidadeToJson(CidadeUniversidade data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

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

  static getCidadeList(int idEstado) {
    return DBProvider.db.getEstadosList();
  }

  static getUniversidadeList(int idEstado) {
    return DBProvider.db.getEstadosList();
  }

  static getCidadeById(int id) {
    return DBProvider.db.getCidade(id);
  }

  static getUniversidadeById(int estadoId) {
    return DBProvider.db.getEstado(estadoId);
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
    return this.nome.compareTo(other.nome);
  }
}