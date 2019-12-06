
import 'package:flutter_app/models/tutor.dart';
import 'package:sqflite/sqflite.dart';
import '../columns_names.dart';
import '../connect.dart';


abstract class TutorRepository{
  static Future<Tutor> saveTutor(Tutor tutor) async {
    Database dbContact = await DatabaseConnect.internal().db;
    tutor.id = await dbContact.insert(tutorTable, tutor.toMap());
    return tutor;
  }

  static Future<int> updateTutor(Tutor tutor) async {
    Database dbContact = await DatabaseConnect.internal().db;
    return await dbContact.update(tutorTable, tutor.toMap(), where: "$idColumn = ?", whereArgs: [tutor.id]);
  }

  static Future<Tutor> getTutor(int id) async {
    Database dbContact = await DatabaseConnect.internal().db;
    List<Map> map2 = await dbContact.rawQuery("SELECT * FROM $neighborhoodTable");
    List<Map> maps = await dbContact.rawQuery("SELECT $tutorTable.$idColumn,"
        "$tutorTable.$nameColumn, $tutorTable.$motherNameColumn, $tutorTable.$cpfColumn,"
        "$tutorTable.$rgColumn, $tutorTable.$cepColumn, $tutorTable.$streetColumn,"
        "$tutorTable.$numberColumn, $tutorTable.$complementColumn, $tutorTable.$professionColumn,"
        "$tutorTable.$telephoneColumn1, $tutorTable.$telephoneColumn2,"
        "$neighborhoodTable.$nameColumn as neighborhoodColumn,"
        "$cityTable.$nameColumn as cityColumn, $tutorTable.$editedColumn,"
        "$tutorTable.$registeredColumn, $tutorTable.$removedColumn,"
        "$tutorTable.$createdByColumn, $tutorTable.$createdDateColumn, $tutorTable.$lastModifiedByColumn,"
        "$stateTable.$nameColumn as stateColumn FROM $tutorTable "
        "JOIN $neighborhoodTable ON $neighborhoodTable.$idColumn = $tutorTable.$idNeighborhoodColumn "
        "JOIN $cityTable ON $cityTable.$idColumn = $neighborhoodTable.$idCityColumn "
        "JOIN $stateTable ON $stateTable.$idColumn = $cityTable.$idStateColumn "
        "WHERE $tutorTable.$idColumn == $id");
    if(maps.length > 0){
      return Tutor.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<Tutor> getTutorByCpf(String cpf) async {
    Database dbContact = await DatabaseConnect.internal().db;
    List<Map> maps = await dbContact.rawQuery("SELECT $tutorTable.$idColumn,"
        "$tutorTable.$nameColumn, $tutorTable.$motherNameColumn, $tutorTable.$cpfColumn,"
        "$tutorTable.$rgColumn, $tutorTable.$cepColumn, $tutorTable.$streetColumn,"
        "$tutorTable.$numberColumn, $tutorTable.$complementColumn, $tutorTable.$professionColumn,"
        "$tutorTable.$telephoneColumn1, $tutorTable.$telephoneColumn2,"
        "$neighborhoodTable.$nameColumn as neighborhoodColumn,"
        "$cityTable.$nameColumn as cityColumn,"
        "$stateTable.$nameColumn as stateColumn FROM $tutorTable "
        "JOIN $neighborhoodTable ON $neighborhoodTable.$idColumn = $tutorTable.$idNeighborhoodColumn "
        "JOIN $cityTable ON $cityTable.$idColumn = $neighborhoodTable.$idCityColumn "
        "JOIN $stateTable ON $stateTable.$idColumn = $cityTable.$idStateColumn "
        "WHERE $tutorTable.$cpfColumn == '$cpf'");
    if(maps.length > 0){
      return Tutor.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<int> truncateTutor() async {
    Database dbContact = await DatabaseConnect.internal().db;
    return await dbContact.delete(tutorTable);
  }

  static Future<List> getAllTutorWhere(column, value) async {
    Database dbContact = await DatabaseConnect.internal().db;
    var columnName;
    List listMap;
    value = value.replaceAll("\'", "");
    switch(column){
      case "Nome":
        columnName = nameColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tutorTable WHERE $removedColumn == 0 AND $columnName like '$value%'");
        break;
      case "CPF":
        columnName = cpfColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tutorTable WHERE $removedColumn == 0 AND $columnName like '$value%'");
        break;
      case "RG":
        columnName = rgColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tutorTable WHERE $removedColumn == 0 AND $columnName like '$value%'");
        break;
      case "Removidos":
        columnName = nameColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tutorTable WHERE $removedColumn == 1 AND $columnName like '$value%'");
        break;
    }
    List<Tutor> listContact = List();
    for(Map m in listMap){
      listContact.add(Tutor.fromMap(m));
    }
    return listContact;
  }

  static Future<List> getAllTutors() async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $tutorTable WHERE $removedColumn == 0");
    List<Tutor> listContact = List();
    for(Map m in listMap){
      listContact.add(Tutor.fromMap(m));
    }
    return listContact;
  }

  static Future<Tutor> getTutorByIdAnimal(id) async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT $tutorTable.$idColumn,"
        "$tutorTable.$nameColumn, $tutorTable.$motherNameColumn, $tutorTable.$cpfColumn,"
        "$tutorTable.$rgColumn, $tutorTable.$cepColumn,"
        " $tutorTable.$streetColumn,"
        "$neighborhoodTable.$nameColumn as neighborhoodColumn, $cityTable.$nameColumn as cityColumn,"
        "$stateTable.$nameColumn as stateColumn,"
        "$tutorTable.$numberColumn, $tutorTable.$complementColumn, $tutorTable.$professionColumn,"
        "$tutorTable.$telephoneColumn1, $tutorTable.$telephoneColumn2 FROM $animalTable "
        "JOIN $tutorTable ON $tutorTable.$idColumn = $animalTable.$idTutorColumn "
        "JOIN $neighborhoodTable ON $neighborhoodTable.$idColumn = $tutorTable.$idNeighborhoodColumn "
        "JOIN $cityTable ON $cityTable.$idColumn = $neighborhoodTable.$idCityColumn "
        "JOIN $stateTable ON $stateTable.$idColumn = $cityTable.$idStateColumn "
        "WHERE $animalTable.$idColumn == $id LIMIT 1");
    if(listMap.length > 0){
      return Tutor.fromMap(listMap.first);
    } else {
      return null;
    }
  }

  static Future<List> getAllTutorsRemoved() async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $tutorTable WHERE $removedColumn == 1");
    List<Tutor> listContact = List();
    for(Map m in listMap){
      listContact.add(Tutor.fromMap(m));
    }
    return listContact;
  }

  static Future<List> getAllTutorsRegistered() async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT $tutorTable.$idColumn as code,"
        "$tutorTable.$nameColumn as name, $removedColumn as status, $cpfColumn as cpf, $rgColumn as rg,"
        " $motherNameColumn as motherName, $streetColumn as street, $numberColumn as number,"
        "$cepColumn as cep, $telephoneColumn1 as telephone1, $telephoneColumn2 as telephone2,"
        "$neighborhoodTable.$nameColumn as neighborhoodColumn, $cityTable.$nameColumn as cityColumn,"
        "$stateTable.$nameColumn as stateColumn,"
        " $professionColumn as profession FROM $tutorTable "
        "JOIN $neighborhoodTable ON $neighborhoodTable.$idColumn = $tutorTable.$idNeighborhoodColumn "
        "JOIN $cityTable ON $cityTable.$idColumn = $neighborhoodTable.$idCityColumn "
        "JOIN $stateTable ON $stateTable.$idColumn = $cityTable.$idStateColumn "
        " WHERE $registeredColumn == 1 AND $removedColumn == 0");
    return listMap;
  }

  static Future<List> getAllTutorsRemovedList() async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT $idColumn as code, $removedColumn as status"
        " FROM $tutorTable WHERE $removedColumn == 1 AND $registeredColumn == 0");
    return listMap;
  }

  static Future<List> getAllTutorsEdited() async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT $tutorTable.$idColumn as code, "
        "$tutorTable.$nameColumn as name, $cpfColumn as cpf, $rgColumn as rg,"
        " $motherNameColumn as motherName,$removedColumn as status, $streetColumn as street, $numberColumn as number,"
        "$cepColumn as cep, $telephoneColumn1 as telephone1, $telephoneColumn2 as telephone2,"
        "$neighborhoodTable.$nameColumn as neighborhoodColumn, $cityTable.$nameColumn as cityColumn,"
        "$stateTable.$nameColumn as stateColumn,"
        " $professionColumn as profession FROM $tutorTable "
        "JOIN $neighborhoodTable ON $neighborhoodTable.$idColumn = $tutorTable.$idNeighborhoodColumn "
        "JOIN $cityTable ON $cityTable.$idColumn = $neighborhoodTable.$idCityColumn "
        "JOIN $stateTable ON $stateTable.$idColumn = $cityTable.$idStateColumn "
        " WHERE $editedColumn == 1 AND $registeredColumn == 0");
    return listMap;
  }
}