import 'package:flutter_app/models/state.dart';

class City{
  int id;
  String name;
  int stateId;
  State state = State();

  City();

  City.fromMap(Map map){
    id = map['idColumn'];
    name = map['nameColumn'];
    stateId = map['idStateColumn'];
  }

  setValues(Map map){
    id = map['code'];
    name = map['name'];
    stateId = map['state']['code'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nameColumn' : name,
      'idStateColumn' : stateId,
    };
    if(id != null){
      map['idColumn'] = id;
    }
    return map;
  }
}