import 'package:flutter_app/database/connect.dart';
import 'package:flutter_app/database/repository/animal_medications_repository.dart';
import 'package:flutter_app/database/repository/animal_repository.dart';
import 'package:flutter_app/database/repository/incidents_repository.dart';
import 'package:flutter_app/database/repository/medications_repository.dart';
import 'package:flutter_app/database/repository/tutor_incidents_repository.dart';
import 'package:flutter_app/database/repository/tutor_repository.dart';
import 'package:flutter_app/database/repository/user_repository.dart';
import 'package:flutter_app/database/repository/vet_repository.dart';
import 'package:flutter_app/models/animal.dart';
import 'package:flutter_app/models/animal_medications.dart';
import 'package:flutter_app/models/incidents.dart';
import 'package:flutter_app/models/medications.dart';
import 'package:flutter_app/models/tutor.dart';
import 'package:flutter_app/models/tutors_incidents.dart';
import 'package:flutter_app/models/vet.dart';
import 'package:sqflite/sqflite.dart';

import '../columns_names.dart';

abstract class AllRepository{

  static truncateAll() async{
    await TutorIncidentRepository.truncateIncidentsWithTutor();
    await MedicationsRepository.truncateMedications();
    await IncidentsRepository.truncateIncidents();
    await UserRepository.truncateUsers();
    await TutorRepository.truncateTutor();
    await AnimalRepository.truncateAnimal();
    await VetRepository.truncateVets();
    await AnimalMedicationRepository.truncateAnimalMedications();
  }

  static saveAll(valuesBody)async{
    Medications medications = Medications();
    Incidents incident = Incidents();
    Vet vet = Vet();
    Tutor tutor = Tutor();
    Animal animal = Animal();
    for(var i = 0; i<valuesBody['medications'].length; i++){
      medications.setValues(valuesBody['medications'][i]);
      await MedicationsRepository.saveMedications(medications);
    }
    for(var i = 0; i<valuesBody['incidents'].length; i++) {
      incident.setValues(valuesBody['incidents'][i]);
      await IncidentsRepository.saveIncidents(incident);
    }
    for(var i = 0; i<valuesBody['tutors'].length; i++) {
      TutorsIncidents tutorsIncidents = TutorsIncidents();
      tutor.setValues(valuesBody['tutors'][i]);
      await TutorRepository.saveTutor(tutor);
      for(var value in valuesBody['tutors'][i]["incidents"]){
        tutorsIncidents.idIncidents = value["code"];
        tutorsIncidents.idTutor = tutor.id;
        await TutorIncidentRepository.saveTutorIncidents(tutorsIncidents);
      }
    }
    for(var i = 0; i<valuesBody['animals'].length; i++) {
      AnimalMedications animalMedications = AnimalMedications();
      animal.setValues(valuesBody['animals'][i]);
      await AnimalRepository.saveAnimal(animal);
      for(var value in valuesBody['animals'][i]["medications"]){
        animalMedications.idMedication = value['medication']["code"];
        animalMedications.dateMedication = value["dateMedications"];
        animalMedications.idAnimal = animal.id;
        await AnimalMedicationRepository.saveAnimalMedications(animalMedications);
      }
    }
    for(var i = 0; i < valuesBody['vets'].length; i++) {
      vet.user.setValues(valuesBody['vets'][i]['user']);
      vet.setValues(valuesBody['vets'][i]);
      await VetRepository.saveVet(vet);
    }
  }

  static Future<List> getExists(table, column, value, {id}) async {
    Database dbContact = await DatabaseConnect.internal().db;
    value = value.replaceAll("\'", "");
    var exists;
    if(id == null)exists = await dbContact.rawQuery("select exists(select * from $table where $column = '$value') as rowExists");
    else exists = await dbContact.rawQuery("select exists(select * from $table where $column = '$value' AND $idColumn != $id) as rowExists");
    return exists;
  }

  static Future<List> getLike(title, column, value) async {
    Database dbContact = await DatabaseConnect.internal().db;
    var tableName;
    var columnName;
    List listMap;
    value = value.replaceAll("\'", "");
    switch(title){
      case "Incidentes":
        tableName = incidentsTable;
        break;
      case "Medicações":
        tableName = medicationsTable;
        break;
      case "Animais":
        tableName = animalTable;
        break;
      case "Tutores":
        tableName = tutorTable;
        break;
      case "Vet":
        tableName = vetTable;
        break;
    }
    switch(column){
      case "Nome":
        columnName = nameColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tableName WHERE $removedColumn == 0 AND $columnName LIKE '$value%' GROUP BY $nameColumn LIMIT 5");
        break;
      case "Microchip":
        columnName = microchipNumberColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tableName WHERE $removedColumn == 0 AND $columnName LIKE '$value%' LIMIT 5");
        break;
      case "Espécie":
        columnName = speciesColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tableName WHERE $removedColumn == 0 AND $columnName LIKE '$value%' LIMIT 5");
        break;
      case "Raça":
        columnName = breedColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tableName WHERE $removedColumn == 0 AND $columnName LIKE '$value%' LIMIT 5");
        break;
      case "CPF":
      case "Cpf":
        columnName = cpfColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tableName WHERE $removedColumn == 0 AND $columnName LIKE '$value%' LIMIT 5");
        break;
      case "RG":
        columnName = rgColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tableName WHERE $removedColumn == 0 AND $columnName LIKE '$value%' LIMIT 5");
        break;
      case "Crmv":
        columnName = crmvColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tableName WHERE $columnName LIKE '$value%' LIMIT 5");
        break;
      case "Removidos":
        columnName = nameColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tableName WHERE $removedColumn == 1 AND $columnName LIKE '$value%' LIMIT 5");
        break;
    }
    List listContact = List();
    for(Map m in listMap){
      listContact.add(m[columnName]);
    }
    return listContact;
  }

}