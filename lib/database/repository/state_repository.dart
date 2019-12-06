import 'package:flutter_app/models/state.dart';
import 'package:sqflite/sqflite.dart';
import '../columns_names.dart';
import '../connect.dart';

abstract class StateRepository{
  static Future<int> truncateState() async {
    Database dbContact = await DatabaseConnect.internal().db;
    return await dbContact.delete(stateTable);
  }

  static Future<State> saveState(State state) async {
    Database dbContact = await DatabaseConnect.internal().db;
    state.id = await dbContact.insert(stateTable, state.toMap());
    return state;
  }

  static Future<State> getByName(name) async {
    Database dbContact = await DatabaseConnect.internal().db;
    List<Map> maps = await dbContact.rawQuery("SELECT $stateTable.$idColumn FROM $stateTable"
        " WHERE $nameColumn == '$name' ");
    if(maps.length > 0){
      return State.fromMap(maps.first);
    } else {
      return null;
    }
  }

}