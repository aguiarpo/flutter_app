
import 'package:flutter/material.dart';
import 'package:flutter_app/database/repository/incidents_repository.dart';
import 'package:flutter_app/models/incidents.dart';

abstract class IncidentsDb{

  static String text = "";

  static Future updateIncidents(value, id, context) async {
    var text = "";
    Incidents incident = Incidents();
    Incidents dbIncidents = await IncidentsRepository.getIncidents(id);
    if(value['name'] == ""){
      value['name'] = dbIncidents.name;
    }
    incident.setValues(value);
    incident.id = id;
    incident.createdDate = dbIncidents.createdDate;
    incident.createdBy = dbIncidents.createdBy;
    incident.removed = 0;
    incident.registered = dbIncidents.registered;
    incident.edited = 1;
    var response = await IncidentsRepository.updateIncidents(incident);
    if(response == 1){
      text = "Incidente Editado com sucesso";
      Navigator.pop(context, text);
    }
  }

  static Future saveIncidents(value, context) async{
    try{
      Incidents incident = Incidents();
      incident.setValues(value);
      incident.registered = 1;
      incident.edited = 0;
      incident.removed = 0;
      Incidents incidentSaved = await IncidentsRepository.saveIncidents(incident);
      if(incidentSaved != null){
        text = "Incidente Cadastrado com sucesso";
        Navigator.pop(context, text);
      }
    }catch(e){
      text = "Erro ao realizaro cadastro";
      Navigator.pop(context, text);
    }
  }
}