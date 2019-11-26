import 'package:flutter_app/models/user.dart';

class Vet {
  Vet();

  int id;
  String crmv;
  int userId;
  User user = User();

  Map<String, dynamic> toMap() {
    Map<String, dynamic>  map = {
      "idUserColumn": userId,
      "crmvColumn": crmv
    };
    if (id != null) {
      map["idColumn"] = id;
    }
    return map;
  }

  setValues(Map map){
    id = map['code'];
    crmv = map['crmv'];
    userId = map['user']['code'];
  }

  Vet.fromMap(Map map) {
    id = map["idColumn"];
    crmv = map["crmvColumn"];
    userId = map['idUserColumn'];
  }
}