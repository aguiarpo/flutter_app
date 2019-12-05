import 'package:flutter_app/models/incidents.dart';
import 'package:sqflite/sqflite.dart';

import '../columns_names.dart';
import '../connect.dart';

abstract class IncidentsRepository{
  static Future<Incidents> saveIncidents(Incidents incidents) async {
    Database dbContact = await DatabaseConnect.internal().db;
    incidents.id = await dbContact.insert(incidentsTable, incidents.toMap());
    return incidents;
  }

  static Future<int> updateIncidents(Incidents incidents) async {
    Database dbContact = await DatabaseConnect.internal().db;
    return await dbContact.update(incidentsTable, incidents.toMap(), where: "$idColumn = ?", whereArgs: [incidents.id]);
  }

  static Future<Incidents> getIncidents(int id) async {
    Database dbContact = await DatabaseConnect.internal().db;
    List<Map> maps = await dbContact.query(incidentsTable,
        columns: [idColumn, nameColumn, lastModifiedByColumn, commentsColumn, removedColumn, registeredColumn, editedColumn],
        where: "$idColumn == ?",
        whereArgs: [id]);
    if(maps.length > 0){
      return Incidents.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<int> truncateIncidents() async {
    Database dbContact = await DatabaseConnect.internal().db;
    return await dbContact.delete(incidentsTable);
  }

  static Future<List> getAllIncidents() async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $incidentsTable WHERE $removedColumn == 0");
    List<Incidents> listContact = List();
    for(Map m in listMap){
      listContact.add(Incidents.fromMap(m));
    }
    return listContact;
  }

  static Future<List> getAllIncidentsRemoved() async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $incidentsTable WHERE $removedColumn == 1");
    List<Incidents> listContact = List();
    for(Map m in listMap){
      listContact.add(Incidents.fromMap(m));
    }
    return listContact;
  }

  static Future<List> getAllIncidentsEdited() async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT $idColumn as code, "
        "$nameColumn as name, $commentsColumn as comments FROM $incidentsTable"
        " WHERE $editedColumn == 1 AND $registeredColumn == 0 AND $removedColumn == 0");
    return listMap;
  }

  static Future<List> getAllIncidentsRegistered() async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT $nameColumn as name, $commentsColumn as comments FROM "
        "$incidentsTable WHERE $registeredColumn == 1 AND $removedColumn == 0");
    return listMap;
  }


  static Future<List> getAllIncidentsRemovedToRequest() async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT $idColumn as code FROM "
        "$incidentsTable WHERE $removedColumn == 1 AND $registeredColumn == 0");
    return listMap;
  }

  static Future<List> getAllIncidentsWhere(column, value) async {
    Database dbContact = await DatabaseConnect.internal().db;
    var columnName;
    List listMap;
    value = value.replaceAll("\'", "");
    switch(column){
      case "Nome":
        columnName = nameColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $incidentsTable WHERE $removedColumn == 0 AND $columnName like '$value%'");
        break;
      case "Removidos":
        columnName = nameColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $incidentsTable WHERE $removedColumn == 1 AND $columnName like '$value%'");
        break;
    }
    List<Incidents> listContact = List();
    for(Map m in listMap){
      listContact.add(Incidents.fromMap(m));
    }
    return listContact;
  }
}