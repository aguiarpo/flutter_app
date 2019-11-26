import 'package:flutter_app/models/medications.dart';

import 'animal.dart';

class AnimalMedications {
  AnimalMedications();

  int id;
  int idMedication;
  int idAnimal;
  String dateMedication;
  Medications medications = Medications();
  Animal animal = Animal();

  Map<String, dynamic> toMap() {
    Map<String, dynamic>  map = {
      "idAnimalColumn": idAnimal,
      "idMedicationsColumn": idMedication,
      "dateMedicationColumn" : dateMedication,
    };
    if (id != null) {
      map["idColumn"] = id;
    }
    return map;
  }

  setValues(Map map){
    id = map['code'];
  }

  AnimalMedications.fromMap(Map map) {
    id = map["idColumn"];
    idAnimal = map["idAnimalColumn"];
    idMedication = map['idMedicationsColumn'];
    dateMedication = map['dateMedicationColumn'];
    medications.name = map["nameColumn"];
  }
}