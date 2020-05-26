import 'dart:io';

import 'package:flutter_app/model/cidade_universidade.dart';
import 'package:flutter_app/model/estado.dart';
import 'package:flutter_app/util/bd1_scripts.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/*
BANCO DE DADOS LOCAL:
 - tabela estados: relaciona o nome dos estados a um int
 - tabela cidades: relaciona o nome de uma cidade a um id e a uma chave estrangeira pra um estado
 - tabela universidade: relaciona o nome de uma universidade a um id e uma chave estrangeira pra um estado
Por conta das tabelas de cidade e de universidade terem os mesmos atributos, elas foram tratadas como uma unica classe no programa

No Profile do usuario so sao salvos esses valores inteiros, uma vez que essas tabelas estarao presentes no script de processamento dos dados

Esse banco de dados e' criado na primeira execucao do programa, entretanto, para economizar espaco, uma vez terminado o cadastro do usuario ele e' dropado, pois tornou-se desnecessario
 */

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
        await db.execute(insertUniversidades[0] + " " + insertUniversidades[i]);
    });
  }

  //CONSULTAS DE ESTADOS
  Future<List<Estado>> getEstadosList() async {
    final db = await database;
    List<Estado> estados = [];
    try {
      List<Map> res =
          await db.rawQuery('Select id,nome from estado order by nome asc');
      for (int i = 0; i < res.length; i++) estados.add(Estado.fromMap(res[i]));
    } catch (Exception) {}
    return estados;
  }

  Future<Estado> getEstado(int id) async {
    final db = await database;
    Estado retorno;
    try {
      List<Map> res =
          await db.query("estado", where: "id = ?", whereArgs: [id]);
      retorno = Estado.fromMap(res.first);
    } catch (Exception) {}

    return retorno;
  }

  //CONSULTAS DE CIDADES

  Future<CidadeUniversidade> getCidade(int id) async {
    final db = await database;
    List<Map> res = [];
    try {
      res =
          await db.rawQuery('SELECT id,nome,estado FROM cidade WHERE id=$id;');
    } catch (Exception) {}
    return res.isNotEmpty ? CidadeUniversidade.fromMap(res.first) : Null;
  }

  Future<int> getCidadeCount() async {
    final db = await database;
    try {
      return Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(id) FROM cidade'));
    } catch (Exception) {
      return -1;
    }
  }

  Future<List<CidadeUniversidade>> getCidadesList(int estadoId) async {
    final db = await database;
    List<CidadeUniversidade> cidades = [];
    try {
      List<Map> res = await db.rawQuery(
          'SELECT * FROM cidade WHERE estado=$estadoId order by nome');
      for (int i = 0; i < res.length; i++)
        cidades.add(CidadeUniversidade.fromMap(res[i]));
    } catch (Exception) {}

    return cidades;
  }

  //CONSULTAS DE UNIVERSIDADE

  Future<CidadeUniversidade> getUniversidade(int id) async {
    final db = await database;
    List<Map> res = [];
    try {
      res = await db
          .rawQuery('SELECT id,nome,estado FROM universidade WHERE id=$id;');
    } catch (Exception) {}
    return res.isNotEmpty ? CidadeUniversidade.fromMap(res.first) : Null;
  }

  Future<List<CidadeUniversidade>> getUniversidadesList(int estadoId) async {
    final db = await database;
    List<CidadeUniversidade> universidades = [];
    try {
      List<Map> res = await db.rawQuery(
          'SELECT * FROM universidade WHERE estado=$estadoId order by nome asc');
      for (int i = 0; i < res.length; i++)
        universidades.add(CidadeUniversidade.fromMap(res[i]));
    } catch (Exception) {}
    return universidades;
  }

  //DROP

  drop() async {
    final db = await database;
    await db.rawQuery('DROP TABLE IF EXISTS universidade;');
    await db.rawQuery('DROP TABLE IF EXISTS cidade;');
    await db.rawQuery('DROP TABLE IF EXISTS estado;');
    createTableEstado = null;
    createTableCidade = null;
    createTableUniversidade = null;
    insertEstados = null;
    insertUniversidades = null;
    insertCidades = null;
  }
}
