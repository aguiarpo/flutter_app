
import 'package:flutter/material.dart';
import 'package:flutter_app/database/repository/tutor_incidents_repository.dart';
import 'package:flutter_app/database/repository/tutor_repository.dart';
import 'package:flutter_app/models/tutor.dart';
import 'package:flutter_app/models/tutors_incidents.dart';

abstract class TutorDb{

  static String text = "";

  static Future updateTutors(value, id, context) async {
    Tutor tutor = Tutor();
    Tutor dbTutor = await TutorRepository.getTutor(id);
    value['number'] = int.parse(value['number']);
    tutor.setValues(value);
    tutor.id = id;
    tutor.createdDate = dbTutor.createdDate;
    tutor.createdBy = dbTutor.createdBy;
    tutor.removed = 0;
    tutor.registered = dbTutor.registered;
    tutor.edited = 1;
    var response = await TutorRepository.updateTutor(tutor);
    await TutorIncidentRepository.deleteTutorIncidents(id);
    var incidents = value['incidents'];
    if(incidents != null){
      for(var i = 0; i < incidents.length; i++){
        await saveIncidentsTutor(incidents, i, id);
      }
    }
    if(response == 1){
      text = "Tutor Editado com sucesso";
      Navigator.pop(context, text);
    }
  }

  static Future saveTutors(value, context) async {
    Tutor tutor = Tutor();
    value['number'] = int.parse(value['number']);
    tutor.setValues(value);
    tutor.removed = 0;
    tutor.registered = 1;
    tutor.edited = 0;
    Tutor response = await TutorRepository.saveTutor(tutor);
    var incidents = value['incidents'];
    if(incidents != null){
      for(var i = 0; i < incidents.length; i++){
        await saveIncidentsTutor(incidents, i, response.id);
      }
    }
    if(response != null){
      text = "Tutor Registrado com sucesso";
      Navigator.pop(context, text);
    }
  }

  static Future saveIncidentsTutor(incidents, i, id) async {
    if(incidents[i]["value"]){
      TutorsIncidents incident = TutorsIncidents();
      incident.idTutor = id;
      incident.idIncidents = incidents[i]["id"];
      await TutorIncidentRepository.saveTutorIncidents(incident);
    }
  }

}