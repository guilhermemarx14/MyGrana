import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/model/orcamento.dart';
import 'package:flutter_app/model/profile.dart';
import 'package:flutter_app/model/transaction.dart' as T;
import 'package:flutter_app/util/bd2_scripts.dart';
import 'package:flutter_app/util/constants.dart';
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
      await db.execute(createTableBudget);
      await db.execute(inicialBudget);
    });
  }

  //CONSULTAS DE PROFILE
  createProfile(Profile p) async {
    final db = await database;

    //CRIA A ENTRADA NO BANCO DE DADOS
    await db.execute(
        "INSERT INTO `profile` (`name`,`origin_city`,`origin_state`,`university_state`,`university_city`,`university`,`hash`,`platform`) VALUES ('${p.name}'"
        ",'${p.originCity}','${p.originState}','${p.universityState}','${p.universityCity}','${p.university}','${p.hash}','${p.platform}');");
  }

  Future<Profile> getProfile() async {
    final db = await database;
    Profile profile;
    List<Map> res = await db.rawQuery('Select * from profile');
    profile = Profile.fromMap(res[0]);
    return profile;
  }

  //CONSULTAS DE TRANSACAO
  getTransacaoId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id');
    id = id ?? 1;
    prefs.setInt('id', id + 1);
    return id;
  }

  createTransacao(T.Transaction t) async {
    final db = await database;
    //CRIA A ENTRADA NO BANCO DE DADOS
    await db.execute(
        "INSERT INTO `transaction` (`id`,`category`,`date`,`description`,`paid`,`value`) VALUES ('${t.id}','${t.category}'"
        ",'${t.date}','${t.description}','${t.paid ? 1 : 0}','${t.value}');");
  }

  updateTransacao(T.Transaction t) async {
    final db = await database;
    //ATUALIZA A ENTRADA NO BANCO DE DADOS
    await db.execute(
        "UPDATE `transaction` SET `category`='${t.category}',`date`='${t.date}',`description`='${t.description}',`paid`='${t.paid ? 1 : 0}',`value`='${t.value}' WHERE id= '${t.id}';");
  }

  saveTransacao(T.Transaction t, Profile p) {
    var _database = FirebaseDatabase.instance
        .reference()
        .child('TCC')
        .child('${p.universityState}')
        .child('${p.universityCity}')
        .child('${p.university}')
        .child(p.hash)
        .child('profile');
    //profile do usuário
    _database.child("origin_state").set('${p.originState}');
    _database.child("origin_city").set('${p.originCity}');
    _database.child("platform").set('${p.platform}');

    _database = FirebaseDatabase.instance
        .reference()
        .child('TCC')
        .child('${p.universityState}')
        .child('${p.universityCity}')
        .child('${p.university}')
        .child(p.hash)
        .child('transactions')
        .child('${t.date.split('-')[0] + '-' + t.date.split('-')[1]}')
        .child("${t.id}");
    _database.child("value").set('${t.value}');
    _database.child("category").set('${t.category}');
  }

  printTransacoesList() async {
    final db = await database;
    List<Map> res =
        await db.rawQuery('Select * from `transaction` order by date asc');
    for (int i = 0; i < res.length; i++) print(T.Transaction.fromMap(res[i]));
  }

  totalAcumulado() async {
    final db = await database;
    int total = 0;
    total = Sqflite.firstIntValue(await db.rawQuery(
            "Select SUM(value) from `transaction` where paid = '1'")) ??
        0;
    return total / 100;
  }

  totalNaoPago() async {
    final db = await database;
    int total = 0;
    total = Sqflite.firstIntValue(await db.rawQuery(
            "Select SUM(value) from `transaction` where paid = '0'")) ??
        0;
    return total / 100;
  }

  consultaTransacao(String categoria, String mes, String ano) async {
    final db = await database;
    var result = [];
    var res;
    bool flag = false;
    String consulta = "Select * from `transaction`";
    if (categoria == TODOS && mes == TODOS && ano == TODOS) {
      consulta += 'order by date;';

      res = await db.rawQuery(consulta);

      for (int i = 0; i < res.length; i++)
        result.add(T.Transaction.fromMap(res[i]));
      return result;
    }
    consulta += " WHERE ";
    int myMes;
    try {
      myMes = int.parse(mes);
    } catch (Exception) {
      myMes = 0;
    }
    String mesConsulta = '$myMes';
    if (mesConsulta.length == 1) mesConsulta = '0' + mesConsulta;

    if (categoria != TODOS) {
      consulta += "category = '${kListaCategorias.indexOf(categoria)}'";
      flag = true;
    }

    if (mes != TODOS) {
      if (flag) consulta += "AND ";
      consulta += "date LIKE '%-$mesConsulta-%'";
      flag = true;
    }

    if (ano != TODOS) {
      if (flag) consulta += "AND ";
      consulta += "date LIKE '%$ano%'";
    }
    consulta += 'order by date;';
    //print(consulta);
    res = await db.rawQuery(consulta);

    for (int i = 0; i < res.length; i++)
      result.add(T.Transaction.fromMap(res[i]));
    //print(result);
    //print(result);
    return result;
  }

  deleteTransacao(T.Transaction t, Profile p) async {
    final db = await database;

    await db.rawQuery('Delete from `transaction` where id=${t.id};');

    final FirebaseDatabase _database = FirebaseDatabase.instance;
    _database
        .reference()
        .child('TCC')
        .child('${p.universityState}')
        .child('${p.universityCity}')
        .child('${p.university}')
        .child(p.hash)
        .child('transactions')
        .child('${t.date.split('-')[0] + '-' + t.date.split('-')[1]}')
        .child('${t.id}')
        .remove();
  }

  //CONSULTAS PARA BUDGET
  getOrcamento() async {
    final db = await database;
    List<Map> res = await db.rawQuery('Select * from budget where id=1');

    //print('consulta $orcamento');
    return Orcamento.fromMap(res.first);
  }

  createOrcamento(Orcamento p) async {
    final db = await database;

    //CRIA A ENTRADA NO BANCO DE DADOS
    await db.execute(
        "INSERT INTO `budget` (`id`,`$kAlimentacao`,`$kBolsaAuxilio`,`$kHigiene`,`$kInvestimento`,`$kLazer`,`$kMoradia`,`$kPensao`,`$kSalario`,`$kSaude`,`$kTransporte`,`$kUniversidade`,`$kVestimenta``$kOutros`,) VALUES ('1','${p.alimentacao},'${p.bolsaAuxilio}'"
        ",'${p.higiene}','${p.investimento}','${p.lazer}','${p.moradia}','${p.pensao}','${p.salario}','${p.saude}','${p.transporte}','${p.universidade}','${p.vestimenta}','${p.outros}');");
  }

  updateOrcamento(Orcamento o) async {
    final db = await database;
    //ATUALIZA A ENTRADA NO BANCO DE DADOS
    await db.execute(
        "UPDATE `budget` SET `$kAlimentacao`='${o.alimentacao}',`$kBolsaAuxilio`='${o.bolsaAuxilio}',`$kHigiene`='${o.higiene}',`$kInvestimento`='${o.investimento}',`$kLazer`='${o.lazer}',`$kMoradia`='${o.moradia}',`$kPensao`='${o.pensao}',`$kSalario`='${o.salario}',`$kSaude`='${o.saude}',`$kTransporte`='${o.transporte}',`$kUniversidade`='${o.universidade}',`$kVestimenta`='${o.vestimenta}',`$kOutros`='${o.outros}' WHERE id = '1'");
    //print(o);
  }
}
