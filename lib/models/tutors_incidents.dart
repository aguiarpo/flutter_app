import 'package:flutter_app/models/incidents.dart';
import 'package:flutter_app/models/tutor.dart';

class TutorsIncidents {
  TutorsIncidents();

  int idTutor;
  int idIncidents;
  Tutor tutor = Tutor();
  Incidents incident = Incidents();

  Map<String, dynamic> toMap() {
    Map<String, dynamic>  map = {
      "idTutorColumn": idTutor,
      "idIncidentsColumn": idIncidents,
    };
    return map;
  }

  TutorsIncidents.fromMap(Map map) {
    idTutor = map["idTutorColumn"];
    idIncidents = map['idIncidentsColumn'];
    incident.name = map['nameColumn'];
  }
}