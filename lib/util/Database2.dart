import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
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

  String generateHash(Profile p) {
    //GERA A KEY DO USUÁRIO
    int number;
    var random = Random();
    number = random.nextInt(1000);

    //GERA A HASH DO USUÁRIO
    var key = utf8.encode('$number');
    var bytes = utf8.encode(p.nome);
    var hmacSha256 = new Hmac(sha256, key); // HMAC-SHA256
    return hmacSha256.convert(bytes).toString();
  }

  //CONSULTAS DE ESTADOS
  createProfile(Profile p) async {
    final db = await database;

    //CRIA A ENTRADA NO BANCO DE DADOS
    await db.rawQuery(
        "INSERT INTO `profile` (`nome`,`estado`,`cidade`,`universidade`,`hash`) VALUES ('${p.nome}'"
        ",'${p.estado}','${p.cidade}','${p.universidade}','${p.hash}');");
  }

  saveProfile(Profile p) {
    final FirebaseDatabase _database = FirebaseDatabase.instance;

    _database
        .reference()
        .child(p.hash)
        .child("Profile")
        .child("Estado")
        .set(p.estado);
    _database
        .reference()
        .child(p.hash)
        .child("Profile")
        .child("Cidade")
        .set(p.cidade);
    _database
        .reference()
        .child(p.hash)
        .child("Profile")
        .child("Universidade")
        .set(p.universidade);
  }
}
