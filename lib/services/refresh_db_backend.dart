import 'dart:convert';

import 'package:flutter_app/database/repository/animal_medications_repository.dart';
import 'package:flutter_app/database/repository/animal_repository.dart';
import 'package:flutter_app/database/repository/incidents_repository.dart';
import 'package:flutter_app/database/repository/medications_repository.dart';
import 'package:flutter_app/database/repository/tutor_incidents_repository.dart';
import 'package:flutter_app/database/repository/tutor_repository.dart';
import 'package:flutter_app/services/animalRequest.dart';
import 'package:flutter_app/services/tutor_request.dart';

import 'incidents_request.dart';
import 'medications_request.dart';

abstract class RefreshDb{

  static Future refreshIncidents()async{
    var responseRefreshDB;
    List incidentsRegistered = await IncidentsRepository.getAllIncidentsRegistered();
    if(incidentsRegistered.isNotEmpty && incidentsRegistered != null)
      responseRefreshDB = await IncidentsRequest.postIncidents(incidentsRegistered);

    List incidentsEdited = await IncidentsRepository.getAllIncidentsEdited();
    if(incidentsEdited.isNotEmpty && incidentsEdited != null)
      responseRefreshDB = await IncidentsRequest.putIncidents(incidentsEdited);

    List incidentsRemoved = await IncidentsRepository.getAllIncidentsRemovedToRequest();
    if(incidentsRemoved.isNotEmpty && incidentsRemoved != null)
      responseRefreshDB = await IncidentsRequest.deleteIncidents(incidentsRemoved);
  }

  static Future refreshMedications()async{
    var responseRefreshDB;
    List medicationsRegistered = await MedicationsRepository.getAllMedicationsRegistered();
    if(medicationsRegistered.isNotEmpty && medicationsRegistered != null)
      responseRefreshDB = await MedicationsRequest.postMedications(medicationsRegistered);

    List medicationsEdited = await MedicationsRepository.getAllMedicationsEdited();
    if(medicationsEdited.isNotEmpty && medicationsEdited != null)
      responseRefreshDB = await MedicationsRequest.putMedications(medicationsEdited);

    List medicationsRemoved = await MedicationsRepository.getAllMedicationsRemovedToRequest();
    if(medicationsRemoved.isNotEmpty && medicationsRemoved != null)
      responseRefreshDB = await MedicationsRequest.deleteMedications(medicationsRemoved);
  }

  static Future refreshTutors()async{
    var responseRefreshDB;
    List tutorEdited = await TutorRepository.getAllTutorsEdited();
    String jsonString = jsonEncode(tutorEdited);
    tutorEdited = jsonDecode(jsonString);
    jsonString = null;
    if(tutorEdited.isNotEmpty && tutorEdited != null){
      for(int i = 0; i < tutorEdited.length; i++){
        List incidents = await TutorIncidentRepository.getAllIncidentsByIdTutorList(tutorEdited[i]['code']);
        tutorEdited[i]['incidents'] = incidents;
        if(tutorEdited[i]['status'] == 1)tutorEdited[i]['status'] = "INVISIBLE";
        else tutorEdited[i]['status'] = "VISIBLE";
      }
      await TutorRequest.putTutor(tutorEdited);
    }

    List tutorRegistered = await TutorRepository.getAllTutorsRegistered();
    jsonString = jsonEncode(tutorRegistered);
    tutorRegistered = jsonDecode(jsonString);
    jsonString = null;
    if(tutorRegistered.isNotEmpty && tutorRegistered != null){
      for(int i = 0; i < tutorRegistered.length; i++){
        List incidents = await TutorIncidentRepository.getAllIncidentsByIdTutorList(tutorRegistered[i]['code']);
        tutorRegistered[i]['incidents'] = incidents;
        if(tutorRegistered[i]['status'] == 1)tutorRegistered[i]['status'] = "INVISIBLE";
        else tutorRegistered[i]['status'] = "VISIBLE";
      }
      await TutorRequest.postTutor(tutorRegistered);
    }

    List tutorRemoved = await TutorRepository.getAllTutorsRemovedList();
    jsonString = jsonEncode(tutorRemoved);
    tutorRemoved = jsonDecode(jsonString);
    jsonString = null;
    if(tutorRemoved.isNotEmpty && tutorRemoved != null){
      for(int i = 0; i < tutorRemoved.length; i++){
        if(tutorRemoved[i]['status'] == 1)tutorRemoved[i]['status'] = "INVISIBLE";
        else tutorRemoved[i]['status'] = "VISIBLE";
      }
      await TutorRequest.deleteTutor(tutorRemoved);
    }
  }

  static Future refreshAnimals()async{
    var responseRefreshDB;
    List animalEdited = await AnimalRepository.getAllAnimalsEdited();
    String jsonString = jsonEncode(animalEdited);
    animalEdited = jsonDecode(jsonString);
    jsonString = null;
    if(animalEdited.isNotEmpty && animalEdited != null){
      for(int i = 0; i < animalEdited.length; i++){
        switch(animalEdited[i]['size']){
          case "Mini":
            animalEdited[i]['size'] = "MINI";
            break;
          case "Pequeno":
            animalEdited[i]['size'] = "PEQUENO";
            break;
          case "Médio":
            animalEdited[i]['size'] = "MEDIO";
            break;
          case "Grande":
            animalEdited[i]['size'] = "GRANDE";
            break;
          case "Gigante":
            animalEdited[i]['size'] = "GIGANTE";
            break;
        }
        animalEdited[i]['tutor']= {"cpf" : animalEdited[i]['cpf']};
        animalEdited[i]['vetMicrochip'] = {"crmv" : animalEdited[i]['crmv']};
        if(animalEdited[i]['status'] == 1)animalEdited[i]['status'] = "INVISIBLE";
        else animalEdited[i]['status'] = "VISIBLE";
        List medications = await AnimalMedicationRepository.getAllMedicationsByIdAnimalList(animalEdited[i]["code"]);
        jsonString = jsonEncode(medications);
        medications = jsonDecode(jsonString);
        jsonString = null;
        if(medications.isNotEmpty && medications != null){
          for(int i = 0; i < medications.length; i++){
            medications[i]['medication']= {"name" : medications[i]['name']};
          }
        }
        animalEdited[i]['medications'] = medications;
      }
      await AnimalRequest.putAnimal(animalEdited);
    }
  }

  static Future refreshAnimalsSave()async{
    var responseRefreshDB;
    List animalRegistered = await AnimalRepository.getAllAnimalsRegistered();
    String jsonString = jsonEncode(animalRegistered);
    animalRegistered = jsonDecode(jsonString);
    jsonString = null;
    if(animalRegistered.isNotEmpty && animalRegistered != null){
      for(int i = 0; i < animalRegistered.length; i++){
        switch(animalRegistered[i]['size']){
          case "Mini":
            animalRegistered[i]['size'] = "MINI";
            break;
          case "Pequeno":
            animalRegistered[i]['size'] = "PEQUENO";
            break;
          case "Médio":
            animalRegistered[i]['size'] = "MEDIO";
            break;
          case "Grande":
            animalRegistered[i]['size'] = "GRANDE";
            break;
          case "Gigante":
            animalRegistered[i]['size'] = "GIGANTE";
            break;
        }
        animalRegistered[i]['tutor']= {"cpf" : animalRegistered[i]['cpf']};
        animalRegistered[i]['vetMicrochip'] = {"crmv" : animalRegistered[i]['crmv']};
        if(animalRegistered[i]['status'] == 1)animalRegistered[i]['status'] = "INVISIBLE";
        else animalRegistered[i]['status'] = "VISIBLE";
        List medications = await AnimalMedicationRepository.getAllMedicationsByIdAnimalList(animalRegistered[i]["code"]);
        jsonString = jsonEncode(medications);
        medications = jsonDecode(jsonString);
        jsonString = null;
        if(medications.isNotEmpty && medications != null){
          for(int i = 0; i < medications.length; i++){
            medications[i]['medication']= {"name" : medications[i]['name']};
          }
        }
        animalRegistered[i]['medications'] = medications;
        animalRegistered[i]["code"] = null;
      }
      await AnimalRequest.postAnimal(animalRegistered);
    }
  }


  static Future refreshAnimalsDelete()async{
    var responseRefreshDB;
    List animalDelete = await AnimalRepository.getAllAnimalsRemovedList();
    String jsonString = jsonEncode(animalDelete);
    animalDelete = jsonDecode(jsonString);
    jsonString = null;
    if(animalDelete.isNotEmpty && animalDelete != null){
      await AnimalRequest.deleteAnimal(animalDelete);
    }
  }

}