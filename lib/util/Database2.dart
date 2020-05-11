import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/model/profile.dart';
import 'package:flutter_app/model/transacao.dart';
import 'package:flutter_app/util/bd2_scripts.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

/*
BANCO DE DADOS LOCAL: tabela 'profile' guarda as informacoes do usuario: Nome, Hash, Estado, Municipio e Universidade
                      tabela 'transaction' guarda as informacoes de uma transacao: Categoria, Data, Descricao, Id, se foi paga e o valor (em int)
                      Como só há um usuario no programa, nao e' necessaria a chave estrangeira pra linkar uma transacao a um profile

REALTIME DATABASE: por ser um banco de dados NOSQL, sua organizacao e' bem diferente
                   o primeiro child trata-se do estado (int)
                   o segundo child trata-se da cidade (int)
                   o terceiro child trata-se da universidade (int)
                   o quarto child trata-se da plataforma (String) 'ios' ou 'android'
                   o quinto child e' quem separa os usuarios, dessa determinada plataforma, universidade, cidade e estado, usando a hash do usuario'
                   o ultimo child e' o id da transacao e, por fim, os dados da transacao
                   dessa forma, os estados ja estao preparados pro processamento, assim como as cidades, assim como as universidades, todas separadas pra facilitar o processamento dos dados
 */

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

  //CONSULTAS DE PROFILE
  createProfile(Profile p) async {
    final db = await database;

    //CRIA A ENTRADA NO BANCO DE DADOS
    await db.execute(
        "INSERT INTO `profile` (`nome`,`estado`,`cidade`,`universidade`,`hash`,`plataforma`) VALUES ('${p.nome}'"
        ",'${p.estado}','${p.cidade}','${p.universidade}','${p.hash}','${p.plataforma}');");
  }

  Future<List<Profile>> getProfilesList() async {
    final db = await database;
    List<Profile> profiles = [];
    List<Map> res = await db.rawQuery('Select * from profile');
    for (int i = 0; i < res.length; i++) profiles.add(Profile.fromMap(res[i]));
    return profiles;
  }

  //CONSULTAS DE TRANSACAO
  getTransacaoId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id');
    id = id ?? 1;
    return id;
  }

  updateTransacaoId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id');
    id = id ?? 1;
    prefs.setInt('id', id + 1);
  }

  createTransacao(Transacao t) async {
    final db = await database;
    //CRIA A ENTRADA NO BANCO DE DADOS
    await db.execute(
        "INSERT INTO `transaction` (`category`,`date`,`descricao`,`paid`,`value`) VALUES ('${t.category}'"
        ",'${t.date}','${t.descricao}','${t.paid ? 1 : 0}','${t.value}');");
  }

  saveTransacao(Transacao t, Profile p) {
    final FirebaseDatabase _database = FirebaseDatabase.instance;

    _database
        .reference()
        .child('${p.estado}')
        .child('${p.cidade}')
        .child('${p.universidade}')
        .child('${p.plataforma}')
        .child(p.hash)
        .child("${t.id}")
        .child("Data")
        .set(t.date);
    _database
        .reference()
        .child('${p.estado}')
        .child('${p.cidade}')
        .child('${p.universidade}')
        .child('${p.plataforma}')
        .child(p.hash)
        .child("${t.id}")
        .child("Descricao")
        .set(t.descricao);
    _database
        .reference()
        .child('${p.estado}')
        .child('${p.cidade}')
        .child('${p.universidade}')
        .child('${p.plataforma}')
        .child(p.hash)
        .child("${t.id}")
        .child("Pago")
        .set(t.paid ? 1 : 0);
    _database
        .reference()
        .child('${p.estado}')
        .child('${p.cidade}')
        .child('${p.universidade}')
        .child('${p.plataforma}')
        .child(p.hash)
        .child("${t.id}")
        .child("Valor")
        .set(t.value);
    _database
        .reference()
        .child('${p.estado}')
        .child('${p.cidade}')
        .child('${p.universidade}')
        .child('${p.plataforma}')
        .child(p.hash)
        .child("${t.id}")
        .child("Categoria")
        .set(t.category);
  }

  printTransacoesList() async {
    final db = await database;
    List<Map> res = await db.rawQuery('Select * from `transaction`');
    for (int i = 0; i < res.length; i++) print(Transacao.fromMap(res[i]));
  }
}
