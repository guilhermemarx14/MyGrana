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
  int id;
  int key;
  String nome;
  int estado;
  int cidade;
  int universidade;
  String hash;

  Profile(
      {this.id,
      this.key,
      this.nome,
      this.estado,
      this.cidade,
      this.universidade,
      this.hash});

  factory Profile.fromMap(Map<String, dynamic> json) => Profile(
        id: json["id"],
        key: json["key"],
        nome: json["nome"],
        estado: json["estado"],
        cidade: json["cidade"],
        universidade: json["universidade"],
        hash: json["hash"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "key": key,
        "nome": nome,
        "estado": estado,
        "cidade": cidade,
        "universidade": universidade,
        "hash": hash,
      };

  @override
  String toString() {
    return "Id: $id, Key: $key, Nome: $nome, Estado: $estado, Cidade: $cidade, Universidade: $universidade, Hash: $hash";
  }
}
