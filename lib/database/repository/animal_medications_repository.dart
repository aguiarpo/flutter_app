import 'package:flutter_app/models/animal_medications.dart';
import 'package:sqflite/sqflite.dart';

import '../columns_names.dart';
import '../connect.dart';

abstract class AnimalMedicationRepository{
  static Future<AnimalMedications> saveAnimalMedications(AnimalMedications animalMedications) async {
    Database dbContact = await DatabaseConnect.internal().db;
    await dbContact.insert(animalMedicationsTable, animalMedications.toMap());
    return animalMedications;
  }

  static Future<int> deleteMedicationsByIdAnimal(int id) async {
    Database dbContact = await DatabaseConnect.internal().db;
    return await dbContact.delete(animalMedicationsTable, where: "$idAnimalColumn = ?", whereArgs: [id]);
  }

  static Future<int> truncateAnimalMedications() async {
    Database dbContact = await DatabaseConnect.internal().db;
    return await dbContact.delete(animalMedicationsTable);
  }

  static Future<List> getAllMedicationsByIdAnimal(int id) async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT $animalMedicationsTable.$idMedicationsColumn,"
        " $animalMedicationsTable.$dateMedicationColumn, $medicationsTable.$nameColumn"
        " FROM $animalMedicationsTable"
        " JOIN $medicationsTable ON $medicationsTable.$idColumn = $animalMedicationsTable.$idMedicationsColumn"
        " WHERE $idAnimalColumn == $id");
    List<AnimalMedications> listContact = List();
    for(Map m in listMap){
      listContact.add(AnimalMedications.fromMap(m));
    }
    return listContact;
  }

  static Future<List> getAllMedicationsByIdAnimalList(int id) async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT "
        " $animalMedicationsTable.$dateMedicationColumn as dateMedications, $medicationsTable.$nameColumn as name"
        " FROM $animalMedicationsTable"
        " JOIN $medicationsTable ON $medicationsTable.$idColumn = $animalMedicationsTable.$idMedicationsColumn"
        " WHERE $idAnimalColumn == $id");
    return listMap;
  }
}