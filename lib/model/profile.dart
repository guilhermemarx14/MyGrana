import 'dart:convert';

Profile ProfileFromJson(String str) {
  final jsonData = json.decode(str);
  return Profile.fromMap(jsonData);
}

String ProfileToJson(Profile data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Profile {
  String nome;
  int estado;
  int cidade;
  int universidade;
  String hash;

  Profile({this.nome, this.estado, this.cidade, this.universidade, this.hash});

  factory Profile.fromMap(Map<String, dynamic> json) => Profile(
        nome: json["nome"],
        estado: json["estado"],
        cidade: json["cidade"],
        universidade: json["universidade"],
        hash: json["hash"],
      );

  Map<String, dynamic> toMap() => {
        "nome": nome,
        "estado": estado,
        "cidade": cidade,
        "universidade": universidade,
        "hash": hash,
      };

  @override
  String toString() {
    return " Nome: $nome, Estado: $estado, Cidade: $cidade, Universidade: $universidade, Hash: $hash";
  }
}
