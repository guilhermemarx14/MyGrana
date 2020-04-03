import 'dart:io';

import 'package:flutter_app/model/cidadeUniversidade.dart';
import 'package:flutter_app/model/estado.dart';
import 'package:flutter_app/util/bd1_scripts.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  //SINGLETON DO BANCO DE DADOS
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

//INIT DO BANCO DE DADOS
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, "MyGranaDB.db");

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      //USO DO TRANSACTION PRA EVITAR DEADLOCK
      await db.transaction((txn) async {
        await db.execute(createTableEstado);
        await db.execute(createTableCidade);
        await db.execute(createTableUniversidade);

        for (int i = 1; i < insertEstados.length; i++) {
          String sql = insertEstados[0] + " " + insertEstados[i];
          await db.execute(sql);
        }
        for (int i = 1; i < insertCidades.length; i++)
          await db.execute(insertCidades[0] + " " + insertCidades[i]);
        for (int i = 1; i < insertUniversidades.length; i++)
          await db
              .execute(insertUniversidades[0] + " " + insertUniversidades[i]);
      });
    });
  }

  //CONSULTAS DE ESTADOS
  Future<List<Estado>> getEstadosList() async {
    final db = await database;
    List<Estado> estados = [];
    List<Map> res = await db.rawQuery('Select id,nome from estado');
    for (int i = 0; i < res.length; i++) estados.add(Estado.fromMap(res[i]));
    return estados;
  }

  Future<Estado> getEstado(int id) async {
    final db = await database;
    List<Map> res = await db.query("estado", where: "id = ?", whereArgs: [id]);
    return Estado.fromMap(res.first);
  }

  //CONSULTAS DE CIDADES

  Future<CidadeUniversidade> getCidade(int id) async {
    final db = await database;
    List<Map> res =
        await db.rawQuery('SELECT id,nome,estado FROM cidade WHERE id=$id;');
    return res.isNotEmpty ? CidadeUniversidade.fromMap(res.first) : Null;
  }

  Future<int> getCidadeCount() async {
    final db = await database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(id) FROM cidade'));
  }

  Future<List<CidadeUniversidade>> getCidadesList(int estadoId) async {
    final db = await database;
    List<CidadeUniversidade> cidades = [];
    List<Map> res =
        await db.rawQuery('SELECT * FROM cidade WHERE estado=$estadoId');
    for (int i = 0; i < res.length; i++)
      cidades.add(CidadeUniversidade.fromMap(res[i]));
    return cidades;
  }

  //CONSULTAS DE UNIVERSIDADE

  Future<CidadeUniversidade> getUniversidade(int id) async {
    final db = await database;
    List<Map> res = await db
        .rawQuery('SELECT id,nome,estado FROM universidade WHERE id=$id;');
    return res.isNotEmpty ? CidadeUniversidade.fromMap(res.first) : Null;
  }

  Future<List<CidadeUniversidade>> getUniversidadesList(int estadoId) async {
    final db = await database;
    List<CidadeUniversidade> universidades = [];
    List<Map> res =
        await db.rawQuery('SELECT * FROM universidade WHERE estado=$estadoId');
    for (int i = 0; i < res.length; i++)
      universidades.add(CidadeUniversidade.fromMap(res[i]));
    return universidades;
  }
}
