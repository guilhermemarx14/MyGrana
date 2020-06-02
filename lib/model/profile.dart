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
  int originEstado;
  int originCidade;
  int estado;
  int cidade;
  int universidade;
  String hash;
  String plataforma;

  Profile(
      {this.nome,
      this.estado,
      this.originCidade,
      this.originEstado,
      this.cidade,
      this.universidade,
      this.hash,
      this.plataforma});

  factory Profile.fromMap(Map<String, dynamic> json) => Profile(
        nome: json["nome"],
        estado: json["estado"],
        cidade: json["cidade"],
        originCidade: json["originCidade"],
        originEstado: json["originEstado"],
        universidade: json["universidade"],
        hash: json["hash"],
        plataforma: json["plataforma"],
      );

  Map<String, dynamic> toMap() => {
        "nome": nome,
        "estado": estado,
        "cidade": cidade,
        "universidade": universidade,
        "originCidade": originCidade,
        "originEstado": originEstado,
        "hash": hash,
        "plataforma": plataforma
      };

  @override
  String toString() {
    return " Nome: $nome, OrigemEstado: $originEstado, OrigemCidade: $originCidade, Estado: $estado, Cidade: $cidade, Universidade: $universidade,plataforma: $plataforma, Hash: $hash";
  }
}
