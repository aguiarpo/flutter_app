import 'package:flutter_app/models/medications.dart';

import 'animal.dart';

class AnimalMedications {
  AnimalMedications();

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
    return map;
  }


  AnimalMedications.fromMap(Map map) {
    idAnimal = map["idAnimalColumn"];
    idMedication = map['idMedicationsColumn'];
    dateMedication = map['dateMedicationColumn'];
    medications.name = map["nameColumn"];
  }
}