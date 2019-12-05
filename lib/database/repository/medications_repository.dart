import 'package:flutter_app/models/medications.dart';
import 'package:sqflite/sqflite.dart';
import '../columns_names.dart';
import '../connect.dart';


abstract class MedicationsRepository{
  static Future<Medications> saveMedications(Medications medications) async {
    Database dbContact = await DatabaseConnect.internal().db;
    medications.id = await dbContact.insert(medicationsTable, medications.toMap());
    return medications;
  }

  static Future<int> updateMedication(Medications medications) async {
    Database dbContact = await DatabaseConnect.internal().db;
    return await dbContact.update(medicationsTable, medications.toMap(), where: "$idColumn = ?", whereArgs: [medications.id]);
  }

  static Future<Medications> getMedications(int id) async {
    Database dbContact = await DatabaseConnect.internal().db;
    List<Map> maps = await dbContact.query(medicationsTable,
        columns: [idColumn, nameColumn, createdByColumn, lastModifiedByColumn, removedColumn, registeredColumn, editedColumn],
        where: "$idColumn == ?",
        whereArgs: [id]);
    if(maps.length > 0){
      return Medications.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<int> deleteMedications(int id) async {
    Database dbContact = await DatabaseConnect.internal().db;
    return await dbContact.delete(medicationsTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  static Future<int> truncateMedications() async {
    Database dbContact = await DatabaseConnect.internal().db;
    return await dbContact.delete(medicationsTable);
  }

  static Future<List> getAllMedications() async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $medicationsTable WHERE $removedColumn == 0");
    List<Medications> listContact = List();
    for(Map m in listMap){
      listContact.add(Medications.fromMap(m));
    }
    return listContact;
  }

  static Future<List> getAllMedicationsRemoved() async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $medicationsTable WHERE $removedColumn == 1");
    List<Medications> listContact = List();
    for(Map m in listMap){
      listContact.add(Medications.fromMap(m));
    }
    return listContact;
  }

  static Future<List> getAllMedicationsRemovedToRequest() async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT $idColumn as code FROM "
        "$medicationsTable WHERE $removedColumn == 1 AND $registeredColumn == 0");
    return listMap;
  }

  static Future<List> getAllMedicationsRegistered() async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT $nameColumn as name FROM "
        "$medicationsTable WHERE $registeredColumn == 1 AND $removedColumn == 0");
    return listMap;
  }

  static Future<List> getAllMedicationsEdited() async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT $idColumn as code, "
        "$nameColumn as name FROM $medicationsTable"
        " WHERE $editedColumn == 1 AND $registeredColumn == 0 AND $removedColumn == 0");
    return listMap;
  }

  static Future<List> getAllMedicationsWhere(column, value) async {
    Database dbContact = await DatabaseConnect.internal().db;
    var columnName;
    List listMap;
    value = value.replaceAll("\'", "");
    switch(column){
      case "Nome":
        columnName = nameColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $medicationsTable WHERE $removedColumn == 0 AND $columnName like '$value%'");
        break;
      case "Removidos":
        columnName = nameColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $medicationsTable WHERE $removedColumn == 1 AND $columnName like '$value%'");
        break;
    }
    List<Medications> listContact = List();
    for(Map m in listMap){
      listContact.add(Medications.fromMap(m));
    }
    return listContact;
  }
}