import 'package:flutter_app/models/incidents.dart';
import 'package:flutter_app/models/tutor.dart';

class TutorsIncidents {
  TutorsIncidents();

  int id;
  int idTutor;
  int idIncidents;
  Tutor tutor = Tutor();
  Incidents incident = Incidents();

  Map<String, dynamic> toMap() {
    Map<String, dynamic>  map = {
      "idTutorColumn": idTutor,
      "idIncidentsColumn": idIncidents,
    };
    if (id != null) {
      map["idColumn"] = id;
    }
    return map;
  }

  setValues(Map map){
    id = map['code'];
  }

  TutorsIncidents.fromMap(Map map) {
    id = map["idColumn"];
    idTutor = map["idTutorColumn"];
    idIncidents = map['idIncidentsColumn'];
    incident.name = map['nameColumn'];
  }
}