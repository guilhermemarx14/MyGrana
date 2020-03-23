import 'dart:io';

import 'package:flutter_app/model/estados.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/util/consultas.dart';
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
      await db.execute(kCreateTableEstados);
      await db.execute(kInsertEstados);
    });
  }

  getEstado(int id) async {
    final db = await database;
    var res = await db.query("estado", where: "id = ?", whereArgs: [id]);
    print(res);
    return res.isNotEmpty ? Estado.fromMap(res.first) : Null;
  }
}
