import 'package:flutter/cupertino.dart';

import 'incidents.dart';

class Tutor{
  int id;
  String name;
  String cpf;
  String rg;
  String motherName;
  String state;
  String city;
  String cep;
  String neighborhood;
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
    city = map['cityColumn'];
    cep = map['cepColumn'];
    state = map['stateColumn'];
    street = map['streetColumn'];
    neighborhood = map['neighborhoodColumn'];
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
    neighborhood = map['neighborhood'];
    number = map['number'];
    cep = map['cep'];
    complements = map['complement'];
    profession = map['profession'];
    city = map['city'];
    state = map['state'];
    telephone1 = map['telephone1'];
    telephone2 = map['telephone2'];
    createdBy = map['createdBy'];
    createdDate = map['createdDate'];
    removed = map['status'] == "INVISIBLE" ? 1 : 0;
    registered = 0;
    edited = 0;
  }

  setValuesWithoutNumber(Map map){
    id = map['code'];
    name = map['name'];
    cpf = map['cpf'];
    rg = map['rg'];
    motherName = map['motherName'];
    street = map['street'];
    neighborhood = map['neighborhood'];
    cep = map['cep'];
    complements = map['complement'];
    profession = map['profession'];
    city = map['city'];
    state = map['state'];
    telephone1 = map['telephone1'];
    telephone2 = map['telephone2'];
    createdBy = map['createdBy'];
    createdDate = map['createdDate'];
    removed = 0;
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
      'neighborhoodColumn' : neighborhood,
      'numberColumn' : number,
      'complementColumn' : complements,
      'professionColumn' : profession,
      'stateColumn' : state,
      'cityColumn' : city,
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

  @override
  String toString() {
    return "User(id: $id, name: $name,"
        " state: $state, city: $city, telephone: $telephone1, telephone: $telephone2)";
  }
}