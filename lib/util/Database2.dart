import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_app/model/profile.dart';
import 'package:flutter_app/util/bd2_scripts.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider2 {
  //SINGLETON DO BANCO DE DADOS
  DBProvider2._();
  static final DBProvider2 db = DBProvider2._();

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

    String path = join(documentsDirectory.path, "MyGranaDB2.db");

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      //USO DO TRANSACTION PRA EVITAR DEADLOCK
      await db.transaction((txn) async {
        await db.execute(createTableProfile);
      });
    });
  }

  //CONSULTAS DE ESTADOS
  createProfile(String nome) async {
    final db = await database;

    //GERA A KEY DO USUÁRIO
    int number;
    var random = Random();
    number = random.nextInt(1000);

    //GERA A HASH DO USUÁRIO
    var key = utf8.encode('$number');
    var bytes = utf8.encode(nome);
    var hmacSha256 = new Hmac(sha256, key); // HMAC-SHA256
    String hash = hmacSha256.convert(bytes).toString();

    //CRIA A ENTRADA NO BANCO DE DADOS
    await db
        .rawQuery(
            "INSERT INTO `profile` (`id`,`key`,`nome`,`estado`,`cidade`,`universidade`,`hash`) VALUES (0,$number,'$nome',0,0,0,'$hash');")
        .then((_) async {
      List<Map> res = await db.rawQuery('SELECT * FROM profile WHERE id=0;');
      print(Profile.fromMap(res.first).toString());
    });
  }
}
