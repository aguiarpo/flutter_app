import 'package:flutter/material.dart';
import 'package:flutter_app/database/create_and_update/tutor_db.dart';
import 'package:flutter_app/database/repository/animal_medications_repository.dart';
import 'package:flutter_app/database/repository/animal_repository.dart';
import 'package:flutter_app/database/repository/tutor_incidents_repository.dart';
import 'package:flutter_app/database/repository/tutor_repository.dart';
import 'package:flutter_app/database/repository/vet_repository.dart';
import 'package:flutter_app/models/animal.dart';
import 'package:flutter_app/models/animal_medications.dart';
import 'package:flutter_app/models/tutor.dart';
import 'package:flutter_app/models/vet.dart';

abstract class AnimalDb{

  static String text = "";

  static Future saveAnimal(value, animalValue, context)async{
    Tutor tutor = Tutor();
    Animal animal = Animal();
    Vet dbVet;
    dbVet = await VetRepository.getVetByCrmv(animalValue['crmv']);
    if(dbVet == null){
      text = "CRMV não existe";
      Navigator.pop(context, text);
    }else{
      value['number'] = int.parse(value['number']);
      tutor.setValues(value);
      tutor.registered = 1;
      animal.setValuesWithoutId(animalValue);
      animal.idVet = dbVet.id;
      Tutor savedTutor;
      Tutor findTutor = await TutorRepository.getTutorByCpf(tutor.cpf);
      if(findTutor == null) savedTutor = await TutorRepository.saveTutor(tutor);
      else{
        tutor.id = findTutor.id;
        tutor.edited = 1;
        tutor.registered = 0;
        await TutorRepository.updateTutor(tutor);
        savedTutor = tutor;
      }
      if(savedTutor == null ){
        Navigator.pop(context, "Erro");
      }else{
        await TutorIncidentRepository.deleteTutorIncidents(savedTutor.id);
        var incidents = value['incidents'];
        if(incidents.isNotEmpty){
          for(var i = 0; i < incidents.length; i++){
            await TutorDb.saveIncidentsTutor(incidents, i, savedTutor.id);
          }
        }
        animal.idTutor = savedTutor.id;
        animal.registered = 1;
        Animal savedAnimal = await AnimalRepository.saveAnimal(animal);
        if(savedAnimal != null){
          await AnimalMedicationRepository.deleteMedicationsByIdAnimal(savedAnimal.id);
          Map medicationsList = value['medications'];
          if(medicationsList != null){
            medicationsList.forEach((index, value)async{
              AnimalMedications animalMedications = AnimalMedications();
              animalMedications.idAnimal = animal.id;
              animalMedications.idMedication = index;
              animalMedications.dateMedication = value.toString();
              await AnimalMedicationRepository.saveAnimalMedications(animalMedications);
            });
          }
          text = "Animal Cadastrado com sucesso";
          Navigator.pop(context, text);
        }else{
          Navigator.pop(context, "Erro");
        }
      }
    }
  }

  static Future updateAnimal(value, animalValue, id, context)async{
    Tutor tutor = Tutor();
    Animal animal = Animal();
    Vet dbVet;
    Tutor dbTutor;
    Animal dbAnimal = await AnimalRepository.getAnimal(id);
    if(value['cpf'] == ""){
      dbTutor = await TutorRepository.getTutor(dbAnimal.idTutor);
      value['cpf'] = dbTutor.cpf;
    }else{
      dbTutor = await TutorRepository.getTutorByCpf(value['cpf']);
    }
    if(dbTutor == null){
      text = "CPF não existe";
      Navigator.pop(context, text);
    }else{
      if(animalValue['crmv'] == ""){
        animalValue['crmv'] = dbAnimal.vet.crmv;
        dbVet = dbAnimal.vet;
        dbVet.id = dbAnimal.idVet;
      }else{
        dbVet = await VetRepository.getVetByCrmv(animalValue['crmv']);
      }
      if(dbVet == null){
        text = "CRMV não existe";
        Navigator.pop(context, text);
      }else{
        value['number'] = int.parse(value['number']);
        tutor.setValues(value);
        tutor.id = dbTutor.id;
        tutor.createdDate = dbTutor.createdDate;
        tutor.createdBy = dbTutor.createdBy;
        tutor.removed = 0;
        tutor.registered = dbTutor.registered;
        tutor.edited = 1;
        animal.setValuesWithoutId(animalValue);
        animal.id = dbAnimal.id;
        animal.idTutor = dbTutor.id;
        animal.idVet = dbVet.id;
        animal.createdDate = dbAnimal.createdDate;
        animal.createdBy = animal.createdBy;
        animal.removed = 0;
        animal.registered = animal.registered;
        animal.edited = 1;
        var response = await TutorRepository.updateTutor(tutor);
        if(response != 1){
          Navigator.pop(context, "Erro");
        }else{
          response = await AnimalRepository.updateAnimal(animal);
          if(response == 1){
            await AnimalMedicationRepository.deleteMedicationsByIdAnimal(animal.id);
            Map medicationsList = value['medications'];
            if(medicationsList != null){
              medicationsList.forEach((index, value)async{
                AnimalMedications animalMedications = AnimalMedications();
                animalMedications.idAnimal = animal.id;
                animalMedications.idMedication = index;
                animalMedications.dateMedication = value.toString();
                await AnimalMedicationRepository.saveAnimalMedications(animalMedications);
              });
            }
          }
          text = "Animal Editado com sucesso";
          Navigator.pop(context, text);
        }
      }
    }
  }

}