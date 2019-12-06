import 'package:flutter_app/database/columns_names.dart';
import 'package:flutter_app/models/city.dart';
import 'package:sqflite/sqlite_api.dart';

import '../connect.dart';

abstract class CityRepository{
  static Future<int> truncateCity() async {
    Database dbContact = await DatabaseConnect.internal().db;
    return await dbContact.delete(cityTable);
  }

  static Future<City> saveCity(City city) async {
    Database dbContact = await DatabaseConnect.internal().db;
    city.id = await dbContact.insert(cityTable, city.toMap());
    return city;
  }

  static Future<City> getByNameAndStateName(cityName, stateName) async {
    Database dbContact = await DatabaseConnect.internal().db;
    List<Map> maps = await dbContact.rawQuery("SELECT $cityTable.$idColumn FROM $cityTable"
        " JOIN $stateTable ON $stateTable.$idColumn = $cityTable.$idStateColumn"
        " WHERE $cityTable.$nameColumn == '$cityName' AND $stateTable.$nameColumn == '$stateName'");
    if(maps.length > 0){
      return City.fromMap(maps.first);
    } else {
      return null;
    }
  }
}