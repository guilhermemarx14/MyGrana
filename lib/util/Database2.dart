import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/model/profile.dart';
import 'package:flutter_app/model/transacao.dart';
import 'package:flutter_app/util/bd2_scripts.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      await db.execute(createTableTransaction);
    });
  }

  //CONSULTAS DE ESTADOS
  createProfile(Profile p) async {
    final db = await database;

    //CRIA A ENTRADA NO BANCO DE DADOS
    await db.execute(
        "INSERT INTO `profile` (`nome`,`estado`,`cidade`,`universidade`,`hash`,`plataforma`) VALUES ('${p.nome}'"
        ",'${p.estado}','${p.cidade}','${p.universidade}','${p.hash}','${p.plataforma}');");
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
    _database
        .reference()
        .child(p.hash)
        .child("Profile")
        .child("Plataforma")
        .set(p.plataforma);
  }

  getTransacaoId() async {
    //todo:utilizar shared preferences pra guardar os ids
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id');
    id = id ?? 1;
    prefs.setInt('id', id + 1);
    return id;
    /*final db = await database;

    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT MAX(id) FROM `transaction`') ?? 0);*/
  }

  createTransacao(Transacao t) async {
    final db = await database;
    //CRIA A ENTRADA NO BANCO DE DADOS
    await db.execute(
        "INSERT INTO `transaction` (`category`,`date`,`descricao`,`paid`,`value`) VALUES ('${t.category}'"
        ",'${t.date}','${t.descricao}','${t.paid ? 1 : 0}','${t.value}');");
  }

  saveTransacao(Transacao t, String hash) {
    final FirebaseDatabase _database = FirebaseDatabase.instance;

    _database
        .reference()
        .child(hash)
        .child("Transaction")
        .child("${t.id}")
        .child("Categoria")
        .set(t.category);
    _database
        .reference()
        .child(hash)
        .child("Transaction")
        .child("${t.id}")
        .child("Data")
        .set(t.date);
    _database
        .reference()
        .child(hash)
        .child("Transaction")
        .child("${t.id}")
        .child("Descricao")
        .set(t.descricao);
    _database
        .reference()
        .child(hash)
        .child("Transaction")
        .child("${t.id}")
        .child("Pago")
        .set(t.paid ? 1 : 0);
    _database
        .reference()
        .child(hash)
        .child("Transaction")
        .child("${t.id}")
        .child("Valor")
        .set(t.value);
  }

  Future<String> getProfileHash() async {
    final db = await database;
    List<Profile> estados = [];
    List<Map> res = await db.rawQuery('Select * from profile');
    for (int i = 0; i < res.length; i++) estados.add(Profile.fromMap(res[i]));

    return estados.first.hash;
  }

  Future<List<Profile>> getProfilesList() async {
    final db = await database;
    List<Profile> estados = [];
    List<Map> res = await db.rawQuery('Select * from profile');
    for (int i = 0; i < res.length; i++) estados.add(Profile.fromMap(res[i]));
    return estados;
  }

  printProfilesList() async {
    final db = await database;
    List<Map> res = await db.rawQuery('Select * from profile');
    for (int i = 0; i < res.length; i++) print(Profile.fromMap(res[i]));
  }

  printTransacoesList() async {
    final db = await database;
    List<Map> res = await db.rawQuery('Select * from `transaction`');
    for (int i = 0; i < res.length; i++) print(Transacao.fromMap(res[i]));
  }
}
