import 'package:flutter/material.dart';
import 'package:flutter_app/database/repository/medications_repository.dart';
import 'package:flutter_app/models/medications.dart';

abstract class MedicationsDb{

  static String text = "";

  static Future updateMedications(value, id, context) async {
    Medications medication = Medications();
    Medications dbMedication = await MedicationsRepository.getMedications(id);
    medication.setValues(value);
    medication.id = id;
    medication.createdDate = dbMedication.createdDate;
    medication.createdBy = dbMedication.createdBy;
    medication.removed = 0;
    medication.registered = dbMedication.registered;
    medication.edited = 1;
    var response = await MedicationsRepository.updateMedication(medication);
    if(response == 1){
      text = "Medicação Editada com sucesso";
      Navigator.pop(context, text);
    }
  }

  static Future saveMedications(value, context) async{
    try{
      Medications medication = Medications();
      medication.setValues(value);
      medication.registered = 1;
      medication.edited = 0;
      medication.removed = 0;
      Medications medicationSaved = await MedicationsRepository.saveMedications(medication);
      if(medicationSaved != null){
        text = "Medicação Cadastrada com sucesso";
        Navigator.pop(context, text);
      }
    }catch(e){
      text = "Erro ao realizaro cadastro";
      Navigator.pop(context, text);
    }
  }
}