import 'dart:convert';

Profile profileFromJson(String str) {
  final jsonData = json.decode(str);
  return Profile.fromMap(jsonData);
}

String profileToJson(Profile data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Profile {
  String name;
  int originState;
  int originCity;
  int universityState;
  int universityCity;
  int university;
  String hash;
  String platform;

  Profile(
      {this.name,
      this.universityState,
      this.originCity,
      this.originState,
      this.universityCity,
      this.university,
      this.hash,
      this.platform});

  factory Profile.fromMap(Map<String, dynamic> json) => Profile(
        name: json["name"],
        universityState: json["university_state"],
        universityCity: json["university_city"],
        originCity: json["origin_city"],
        originState: json["origin_state"],
        university: json["university"],
        hash: json["hash"],
        platform: json["platform"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "university_state": universityState,
        "university_city": universityCity,
        "university": university,
        "origin_city": originCity,
        "origin_state": originState,
        "hash": hash,
        "platform": platform
      };

  @override
  String toString() {
    return " Nome: $name, OrigemEstado: $originState, OrigemCidade: $originCity, Estado: $universityState, Cidade: $universityCity, Universidade: $university,plataforma: $platform, Hash: $hash";
  }
}
