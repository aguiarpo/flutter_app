import 'dart:convert';

import 'package:flutter_app/database/repository/tutor_incidents_repository.dart';
import 'package:flutter_app/database/repository/tutor_repository.dart';
import 'package:flutter_app/services/url.dart';

import '../request/modals_request.dart';

abstract class RefreshTutor{

  static String urlName = Url.name + 'v1/veterinario/tutor/';

  static Future refresh()async{
    await save();
    await update();
    await delete();
  }

  static Future save()async{
    List tutorRegistered = await TutorRepository.getAllTutorsRegistered();
    String jsonString = jsonEncode(tutorRegistered);
    tutorRegistered = jsonDecode(jsonString);
    jsonString = null;
    if(tutorRegistered.isNotEmpty && tutorRegistered != null){
      for(int i = 0; i < tutorRegistered.length; i++){
        List incidents = await TutorIncidentRepository.getAllIncidentsByIdTutorList(tutorRegistered[i]['code']);
        tutorRegistered[i]['incidents'] = incidents;
        if(tutorRegistered[i]['status'] == 1)tutorRegistered[i]['status'] = "INVISIBLE";
        else tutorRegistered[i]['status'] = "VISIBLE";
      }
      await ModalsRequest.post(tutorRegistered, urlName);
    }
  }

  static Future update()async{
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
      await ModalsRequest.put(tutorEdited, urlName);
    }
  }

  static Future delete()async{
    List tutorRemoved = await TutorRepository.getAllTutorsRemovedList();
    String jsonString = jsonEncode(tutorRemoved);
    tutorRemoved = jsonDecode(jsonString);
    jsonString = null;
    if(tutorRemoved.isNotEmpty && tutorRemoved != null){
      for(int i = 0; i < tutorRemoved.length; i++){
        if(tutorRemoved[i]['status'] == 1)tutorRemoved[i]['status'] = "INVISIBLE";
        else tutorRemoved[i]['status'] = "VISIBLE";
      }
      await ModalsRequest.delete(tutorRemoved, urlName);
    }
  }
}