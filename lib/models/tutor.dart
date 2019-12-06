import 'package:flutter/cupertino.dart';
import 'package:flutter_app/models/neighborhood.dart';

class Tutor{
  int id;
  String name;
  String cpf;
  String rg;
  String motherName;
  String cep;
  int neighborhoodId;
  Neighborhood neighborhood = Neighborhood();
  String street;
  int number;
  String profession;
  String complements;
  String telephone1;
  String telephone2;
  String createdBy;
  String lastModifiedBy;
  String createdDate;
  int removed;
  int registered;
  int edited;
  List<Widget> nameIncidents = [];
  List incidents;
  List incidentsWithTutors = [];

  Tutor();

  Tutor.fromMap(Map map){
    id = map['idColumn'];
    name = map['nameColumn'];
    cpf = map['cpfColumn'];
    rg = map['rgColumn'];
    motherName = map['motherNameColumn'];
    cep = map['cepColumn'];
    street = map['streetColumn'];
    if(map['neighborhoodColumn'] != null){
      neighborhood.name = map['neighborhoodColumn'];
      neighborhood.city.name = map['cityColumn'];
      neighborhood.city.state.name = map['stateColumn'];
    }
    lastModifiedBy = map['lastModifiedByColumn'];
    number = map['numberColumn'];
    complements = map['complementColumn'];
    profession = map['professionColumn'];
    telephone1 = map['telephone1Column'];
    telephone2 = map['telephone2Column'];
    createdBy = map['createdByColumn'];
    createdDate = map['createdDateColumn'];
    removed = map['removedColumn'];
    registered = map['registeredColumn'];
    edited = map['editedColumn'];
  }

  setValues(Map map){
    id = map['code'];
    name = map['name'];
    cpf = map['cpf'];
    rg = map['rg'];
    motherName = map['motherName'];
    lastModifiedBy = map['lastModifiedBy'];
    street = map['street'];
    neighborhoodId = map['neighborhood']['code'];
    number = map['number'];
    cep = map['cep'];
    complements = map['complement'];
    profession = map['profession'];
    telephone1 = map['telephone1'];
    telephone2 = map['telephone2'];
    createdBy = map['createdBy'];
    createdDate = map['createdDate'];
    removed = map['status'] == "INVISIBLE" ? 1 : 0;
    registered = 0;
    edited = 0;
  }

  setValuesWithAddress(Map map){
    id = map['code'];
    name = map['name'];
    cpf = map['cpf'];
    rg = map['rg'];
    motherName = map['motherName'];
    lastModifiedBy = map['lastModifiedBy'];
    street = map['street'];
    if(map['neighborhood'] != null)neighborhood.name = map['neighborhood'];
    if(map['city'] != null)neighborhood.city.name = map['city'];
    if(map['state'] != null)neighborhood.city.state.name = map['state'];
    number = map['number'];
    cep = map['cep'];
    complements = map['complement'];
    profession = map['profession'];
    telephone1 = map['telephone1'];
    telephone2 = map['telephone2'];
    createdBy = map['createdBy'];
    createdDate = map['createdDate'];
    removed = map['status'] == "INVISIBLE" ? 1 : 0;
    registered = 0;
    edited = 0;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nameColumn' : name,
      'cpfColumn' : cpf,
      'rgColumn' : rg,
      'lastModifiedByColumn' : lastModifiedBy,
      'motherNameColumn' : motherName,
      'streetColumn' : street,
      'cepColumn' : cep,
      'idNeighborhoodColumn' : neighborhoodId,
      'numberColumn' : number,
      'complementColumn' : complements,
      'professionColumn' : profession,
      'telephone1Column' : telephone1,
      'telephone2Column' : telephone2,
      'createdByColumn': createdBy,
      'createdDateColumn': createdDate,
      'removedColumn' : removed,
      'registeredColumn' : registered,
      'editedColumn' : edited,
    };
    if(id != null){
      map['idColumn'] = id;
    }
    return map;
  }
}