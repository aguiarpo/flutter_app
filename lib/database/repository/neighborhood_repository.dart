import 'package:flutter_app/database/columns_names.dart';
import 'package:flutter_app/models/neighborhood.dart';
import 'package:sqflite/sqlite_api.dart';

import '../connect.dart';

abstract class NeighborhoodRepository{
  static Future<int> truncateNeighborhood() async {
    Database dbContact = await DatabaseConnect.internal().db;
    return await dbContact.delete(neighborhoodTable);
  }

  static Future<Neighborhood> saveNeighborhood(Neighborhood neighborhood) async {
    Database dbContact = await DatabaseConnect.internal().db;
    neighborhood.id = await dbContact.insert(neighborhoodTable, neighborhood.toMap());
    return neighborhood;
  }

  static Future<Neighborhood> getByNameAndCityNameAndStateName(neighborhoodName, cityName, stateName) async {
    Database dbContact = await DatabaseConnect.internal().db;
    List<Map> maps = await dbContact.rawQuery("SELECT $neighborhoodTable.$idColumn FROM $neighborhoodTable"
        " JOIN $cityTable ON $cityTable.$idColumn = $neighborhoodTable.$idCityColumn"
        " JOIN $stateTable ON $stateTable.$idColumn = $cityTable.$idStateColumn"
        " WHERE $neighborhoodTable.$nameColumn == '$neighborhoodName' AND"
        " $cityTable.$nameColumn == '$cityName' AND $stateTable.$nameColumn == '$stateName'");
    if(maps.length > 0){
      return Neighborhood.fromMap(maps.first);
    } else {
      return null;
    }
  }
}