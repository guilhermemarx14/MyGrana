import 'package:flutter_app/model/transacao.dart';

class Localizacao {
  int estado;
  List<int> cidade = [];
  List<int> universidade = [];
  List<String> userHash = [];
  List<String> userPlataforma = [];
  List<String> plataforma = [];
  List<Map<String, Transacao>> userHash_transacao = [];

  Localizacao(
      {this.estado,
      this.cidade,
      this.universidade,
      this.userHash,
      this.userPlataforma,
      this.userHash_transacao});

  @override
  String toString() {
    return "Estado: $estado, Cidade: $cidade, Universide; $universidade, \n"
        "UserHashs: $userHash, \n"
        "UserPlataforma: $userPlataforma, \n"
        "UserHash_transacao: $userHash_transacao";
  }
}
