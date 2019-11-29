import 'package:flutter_app/models/animal.dart';
import 'package:sqflite/sqflite.dart';

import '../columns_names.dart';
import '../connect.dart';

abstract class AnimalRepository{
  static Future<Animal> saveAnimal(Animal animal) async {
    Database dbContact = await DatabaseConnect.internal().db;
    animal.id = await dbContact.insert(animalTable, animal.toMap());
    return animal;
  }

  static Future<int> updateAnimal(Animal animal) async {
    Database dbContact = await DatabaseConnect.internal().db;
    return await dbContact.update(animalTable, animal.toMap(), where: "$idColumn = ?", whereArgs: [animal.id]);
  }

  static Future<Animal> getAnimal(int id) async {
    Database dbContact = await DatabaseConnect.internal().db;
    List<Map> maps = await dbContact.rawQuery("SELECT $animalTable.$idColumn, $animalTable.$nameColumn, $animalTable.$removedColumn, "
        "$animalTable.$registeredColumn, $animalTable.$lastModifiedByColumn, $animalTable.$editedColumn, $animalTable.$commentsColumn, "
        "$animalTable.$microchipNumberColumn, $animalTable.$speciesColumn, $animalTable.$birthDateColumn,"
        " $animalTable.$coatColorColumn, $tutorTable.$nameColumn as name,"
        "$animalTable.$breedColumn, $animalTable.$sizeCmColumn, $animalTable.$dateMicrochipColumn, "
        "$animalTable.$createdDateColumn, $animalTable.$idVetColumn, $animalTable.$idTutorColumn, $vetTable.$crmvColumn, $tutorTable.$cpfColumn "
        " FROM $animalTable JOIN $vetTable ON $vetTable.$idColumn = $animalTable.$idVetColumn"
        " JOIN $tutorTable ON $tutorTable.$idColumn = $animalTable.$idTutorColumn"
        " WHERE $animalTable.$idColumn == $id");
    if(maps.length > 0){
      return Animal.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<int> truncateAnimal() async {
    Database dbContact = await DatabaseConnect.internal().db;
    return await dbContact.delete(animalTable);
  }

  static Future<List> getAllAnimals() async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $animalTable WHERE $removedColumn == 0");
    List<Animal> listContact = List();
    for(Map m in listMap){
      listContact.add(Animal.fromMap(m));
    }
    return listContact;
  }

  static Future<List> getAllAnimalsRemoved() async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $animalTable WHERE $removedColumn == 1");
    List<Animal> listContact = List();
    for(Map m in listMap){
      listContact.add(Animal.fromMap(m));
    }
    return listContact;
  }

  static Future<List> getAllAnimalsWhere(column, value) async {
    Database dbContact = await DatabaseConnect.internal().db;
    var columnName;
    List listMap;
    value = value.replaceAll("\'", "");
    switch(column){
      case "Nome":
        columnName = nameColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $animalTable WHERE $removedColumn == 0 AND $columnName == '$value'");
        break;
      case "Microchip":
        columnName = microchipNumberColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $animalTable WHERE $removedColumn == 0 AND $columnName == '$value' LIMIT 1");
        break;
      case "Espécie":
        columnName = speciesColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $animalTable WHERE $removedColumn == 0 AND $columnName == '$value'");
        break;
      case "Raça":
        columnName = breedColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $animalTable WHERE $removedColumn == 0 AND $columnName == '$value'");
        break;
      case "Removidos":
        columnName = nameColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $animalTable WHERE $removedColumn == 1 AND $columnName == '$value' LIMIT 1");
        break;
    }
    List<Animal> listContact = List();
    for(Map m in listMap){
      listContact.add(Animal.fromMap(m));
    }
    return listContact;
  }

  static Future<List> getAllAnimalsEdited() async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT $animalTable.$idColumn as code,"
        " $animalTable.$nameColumn as name, $animalTable.$removedColumn as status, "
        "$animalTable.$commentsColumn as comments, "
        "$animalTable.$microchipNumberColumn as microchipNumber, "
        "$animalTable.$speciesColumn as species, $animalTable.$birthDateColumn as birthDate,"
        "$animalTable.$coatColorColumn as coatColor,"
        "$animalTable.$breedColumn as breed, $animalTable.$sizeCmColumn as size,"
        " $animalTable.$dateMicrochipColumn as dateMicrochip, "
        " $vetTable.$crmvColumn as crmv, $tutorTable.$cpfColumn as cpf "
        " FROM $animalTable JOIN $vetTable ON $vetTable.$idColumn = $animalTable.$idVetColumn"
        " JOIN $tutorTable ON $tutorTable.$idColumn = $animalTable.$idTutorColumn"
        " WHERE $animalTable.$editedColumn == 1 AND $animalTable.$registeredColumn == 0");
    return listMap;
  }

  static Future<List> getAllAnimalsRegistered() async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT $animalTable.$idColumn as code,"
        " $animalTable.$nameColumn as name, $animalTable.$removedColumn as status, "
        "$animalTable.$commentsColumn as comments, "
        "$animalTable.$microchipNumberColumn as microchipNumber, "
        "$animalTable.$speciesColumn as species, $animalTable.$birthDateColumn as birthDate,"
        "$animalTable.$coatColorColumn as coatColor,"
        "$animalTable.$breedColumn as breed, $animalTable.$sizeCmColumn as size,"
        " $animalTable.$dateMicrochipColumn as dateMicrochip, "
        " $vetTable.$crmvColumn as crmv, $tutorTable.$cpfColumn as cpf "
        " FROM $animalTable JOIN $vetTable ON $vetTable.$idColumn = $animalTable.$idVetColumn"
        " JOIN $tutorTable ON $tutorTable.$idColumn = $animalTable.$idTutorColumn"
        " WHERE $animalTable.$registeredColumn == 1 AND $animalTable.$removedColumn == 0");
    return listMap;
  }

  static Future<List> getAllAnimalsRemovedList() async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT $idColumn as code"
        " FROM $animalTable WHERE $removedColumn == 1 AND $registeredColumn == 0");
    return listMap;
  }
}