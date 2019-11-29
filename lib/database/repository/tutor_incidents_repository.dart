import 'package:flutter_app/models/tutors_incidents.dart';
import 'package:sqflite/sqflite.dart';

import '../columns_names.dart';
import '../connect.dart';

abstract class TutorIncidentRepository{
  static Future<TutorsIncidents> saveTutorIncidents(TutorsIncidents tutorsIncidents) async {
    Database dbContact = await DatabaseConnect.internal().db;
    await dbContact.insert(tutorIncidentsTable, tutorsIncidents.toMap());
    return tutorsIncidents;
  }

  static Future<int> deleteTutorIncidents(int id) async {
    Database dbContact = await DatabaseConnect.internal().db;
    return await dbContact.delete(tutorIncidentsTable, where: "$idTutorColumn = ?", whereArgs: [id]);
  }

  static Future<int> truncateIncidentsWithTutor() async {
    Database dbContact = await DatabaseConnect.internal().db;
    return await dbContact.delete(tutorIncidentsTable);
  }

  static Future<List> getAllIncidentsByIdTutor(int id) async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT $tutorIncidentsTable.$idIncidentsColumn,"
        " $incidentsTable.$nameColumn"
        " FROM $tutorIncidentsTable"
        " JOIN $incidentsTable ON $incidentsTable.$idColumn = $tutorIncidentsTable.$idIncidentsColumn"
        " WHERE $idTutorColumn == $id");
    List<TutorsIncidents> listContact = List();
    for(Map m in listMap){
      listContact.add(TutorsIncidents.fromMap(m));
    }
    return listContact;
  }

  static Future<List> getAllIncidentsByIdTutorList(int id) async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT $incidentsTable.$nameColumn as name"
        " FROM $tutorIncidentsTable"
        " JOIN $incidentsTable ON $incidentsTable.$idColumn = $tutorIncidentsTable.$idIncidentsColumn"
        " WHERE $idTutorColumn == $id");
    return listMap;
  }
}