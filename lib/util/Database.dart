import 'dart:io';
import 'package:flutter_app/model/estado.dart';
import 'package:flutter_app/screens/data_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/util/bd1_scripts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, "MyGranaDB.db");

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
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

  getCidade(int id) async {
    final db = await database;
    var res = await db.query("cidade", where: "id = ?", whereArgs: [id]);

    return res.isNotEmpty ? Estado.fromMap(res.first) : Null;
  }

  getUniversidade(int id) async {
    final db = await database;
    var res = await db.query("universidade", where: "id = ?", whereArgs: [id]);

    return res.isNotEmpty ? Estado.fromMap(res.first) : Null;
  }

  getCidadeCount() async {
    final db = await database;
    var res = await db.rawQuery("SELECT COUNT (id) FROM cidade;");

    return res.isNotEmpty ? Estado.fromMap(res.first) : Null;
  }

  getEstadoCount() async {
    final db = await database;
    var res = await db.rawQuery("SELECT COUNT (id) FROM estado;");
    return res;
  }
}
