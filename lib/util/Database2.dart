import 'dart:io';

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

    return await openDatabase(path, version: 1, onOpen: (db) {
      db.execute(createTableProfile);
    }, onCreate: (Database db, int version) async {
      await db.execute(createTableProfile);
    });
  }

  //CONSULTAS DE ESTADOS
  createProfile(Profile p) async {
    final db = await database;

    //CRIA A ENTRADA NO BANCO DE DADOS
    await db.execute(
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

  Future<List<Profile>> getProfilesList() async {
    final db = await database;
    List<Profile> estados = [];
    List<Map> res = await db.rawQuery('Select * from profile');
    for (int i = 0; i < res.length; i++) estados.add(Profile.fromMap(res[i]));
    return estados;
  }

  Future<int> getProfileCount() async {
    final db = await database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(nome) FROM profile'));
  }
}
