import 'package:flutter/material.dart';
import 'package:flutter_app/database/columns_names.dart';
import 'package:flutter_app/models/tutor.dart';
import 'package:flutter_app/models/vet.dart';

class Animal{
  int id;
  String name;
  String microchipNumber;
  String species;
  String birthDate;
  String coatColor;
  String breed;
  String sizeCm;
  String dateMicrochip;
  String comments;
  String createdBy;
  String createdDate;
  String lastModifiedBy;
  String genre;
  int castrated;
  int removed;
  int registered;
  int edited;
  int idVet;
  int idTutor;
  Tutor tutor = Tutor();
  Vet vet = Vet();
  List medications = [];
  List list;
  Map dates = {};
  List<Widget> medicationsWidget;

  Animal();

  Animal.fromMap(Map map){
    id = map['idColumn'];
    name = map['nameColumn'];
    microchipNumber = map['microchipNumberColumn'];
    species = map['speciesColumn'];
    birthDate = map['birthDateColumn'];
    coatColor = map['coatColorColumn'];
    breed = map['breedColumn'];
    sizeCm = map['sizeCmColumn'];
    dateMicrochip = map['dateMicrochipColumn'];
    lastModifiedBy = map['lastModifiedByColumn'];
    comments = map['commentsColumn'];
    castrated = map['castratedColumn'];
    genre = map['genreColumn'];
    createdBy = map['createdByColumn'];
    createdDate = map['createdDateColumn'];
    removed = map['removedColumn'];
    registered = map['registeredColumn'];
    edited = map['editedColumn'];
    idVet = map['vetColumn'];
    idTutor = map['idTutorColumn'];
    vet.crmv = map['crmvColumn'];
    tutor.cpf = map["cpfColumn"];
    tutor.name = map["name"];
  }

  setValues(Map map){
    switch(map['size']){
      case "MINI":
        sizeCm = "Mini";
        break;
      case "PEQUENO":
        sizeCm = "Pequeno";
        break;
      case "MEDIO":
        sizeCm = "Médio";
        break;
      case "GRANDE":
        sizeCm = "Grande";
        break;
      case "GIGANTE":
        sizeCm = "Gigante";
        break;
    }
    id = map['code'];
    name = map['name'];
    microchipNumber = map['microchipNumber'];
    species = map['species'];
    birthDate = map['birthDate'];
    coatColor = map['coatColor'];
    breed = map['breed'];
    dateMicrochip = map['dateMicrochip'];
    comments = map['comments'];
    createdBy = map['createdBy'];
    lastModifiedBy = map['lastModifiedBy'];
    createdDate = map['createdDate'];
    castrated = map['castrated'] ? 1 : 0;
    genre = map['genre'];
    idVet = map['vetMicrochip']['code'];
    idTutor = map["tutor"]["code"];
    registered = 0;
    edited = 0;
    removed = map['status'] == "INVISIBLE" ? 1 : 0;
  }

  setValuesWithoutId(Map map){
    id = map['code'];
    name = map['name'];
    microchipNumber = map['microchipNumber'];
    species = map['species'];
    birthDate = map['birthDate'];
    coatColor = map['coatColor'];
    breed = map['breed'];
    sizeCm = map['size'];
    dateMicrochip = map['dateMicrochip'];
    comments = map['comments'];
    createdBy = map['createdBy'];
    castrated = map['castrated'];
    genre = map['genre'];
    createdDate = map['createdDate'];
    removed = 0;
    registered = 0;
    edited = 0;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nameColumn' : name,
      'microchipNumberColumn' : microchipNumber,
      'speciesColumn' : species,
      'birthDateColumn' : birthDate,
      'lastModifiedByColumn' : lastModifiedBy,
      'coatColorColumn' : coatColor,
      'breedColumn' : breed,
      'sizeCmColumn' : sizeCm,
      'dateMicrochipColumn' : dateMicrochip,
      'commentsColumn' : comments,
      'createdByColumn': createdBy,
      'createdDateColumn': createdDate,
      'removedColumn' : removed,
      'registeredColumn' : registered,
      'editedColumn' : edited,
      'castratedColumn' : castrated,
      'genreColumn' : genre,
      'vetColumn' : idVet,
      "idTutorColumn" : idTutor,
    };
    if(id != null){
      map['idColumn'] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "User(id: $id, name: $name,"
        ")";
  }
}