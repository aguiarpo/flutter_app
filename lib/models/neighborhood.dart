
import 'package:flutter_app/models/city.dart';
import 'package:flutter_app/models/state.dart';

class Neighborhood{
  int id;
  String name;
  int cityId;
  City city = City();

  Neighborhood();

  Neighborhood.fromMap(Map map){
    id = map['idColumn'];
    name = map['nameColumn'];
    cityId = map['idCityColumn'];
  }

  setValues(Map map){
    id = map['code'];
    name = map['name'];
    cityId = map['city']['code'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nameColumn' : name,
      'idCityColumn' : cityId,
    };
    if(id != null){
      map['idColumn'] = id;
    }
    return map;
  }
}