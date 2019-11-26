import 'package:flutter/material.dart';
import 'package:flutter_app/models/tutor.dart';
import 'package:flutter_app/models/vet.dart';

class Animal{
  int id;
  String name;
  String microchipNumber;
  String species;
  String birthDate;
  int animalCastrated;
  String coatColor;
  String breed;
  int sizeCm;
  String dateMicrochip;
  String comments;
  String createdBy;
  String createdDate;
  int removed;
  int registered;
  int edited;
  int idVet;
  int idTutor;
  Tutor tutor = Tutor();
  Vet vet = Vet();
  List<Widget> medicationsWidget;

  Animal();

  Animal.fromMap(Map map){
    id = map['idColumn'];
    name = map['nameColumn'];
    microchipNumber = map['microchipNumberColumn'];
    species = map['speciesColumn'];
    birthDate = map['birthDateColumn'];
    animalCastrated = map['animalCastratedColumn'];
    coatColor = map['coatColorColumn'];
    breed = map['breedColumn'];
    sizeCm = map['sizeCmColumn'];
    dateMicrochip = map['dateMicrochipColumn'];
    comments = map['commentsColumn'];
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
    id = map['code'];
    name = map['name'];
    microchipNumber = map['microchipNumber'];
    species = map['species'];
    birthDate = map['birthDate'];
    animalCastrated = map['animalCastrated'] ? 1 : 0;
    coatColor = map['coatColor'];
    breed = map['breed'];
    sizeCm = map['sizeCm'];
    dateMicrochip = map['dateMicrochip'];
    comments = map['comments'];
    createdBy = map['createdBy'];
    createdDate = map['createdDate'];
    idVet = map['vetMicrochip']['code'];
    idTutor = map["tutor"]["code"];
    removed = 0;
    registered = 0;
    edited = 0;
  }

  setValuesWithoutId(Map map){
    id = map['code'];
    name = map['name'];
    microchipNumber = map['microchipNumber'];
    species = map['species'];
    birthDate = map['birthDate'];
    coatColor = map['coatColor'];
    breed = map['breed'];
    sizeCm = map['sizeCm'];
    dateMicrochip = map['dateMicrochip'];
    comments = map['comments'];
    createdBy = map['createdBy'];
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
      'animalCastratedColumn' : animalCastrated,
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