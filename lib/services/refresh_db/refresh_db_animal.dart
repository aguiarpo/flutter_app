import 'dart:convert';

import 'package:flutter_app/database/repository/animal_medications_repository.dart';
import 'package:flutter_app/database/repository/animal_repository.dart';
import 'package:flutter_app/services/url.dart';

import '../request/modals_request.dart';

abstract class RefreshAnimal{

  static String urlName = Url.name +  'v1/veterinario/animal/';

  static Future refresh()async{
    await save();
    await update();
    await delete();
  }

  static Future save()async{
    List animalRegistered = await AnimalRepository.getAllAnimalsRegistered();
    String jsonString = jsonEncode(animalRegistered);
    animalRegistered = jsonDecode(jsonString);
    jsonString = null;
    if(animalRegistered.isNotEmpty && animalRegistered != null){
      for(int i = 0; i < animalRegistered.length; i++){
        switch(animalRegistered[i]['size']){
          case "Mini":
            animalRegistered[i]['size'] = "MINI";
            break;
          case "Pequeno":
            animalRegistered[i]['size'] = "PEQUENO";
            break;
          case "Médio":
            animalRegistered[i]['size'] = "MEDIO";
            break;
          case "Grande":
            animalRegistered[i]['size'] = "GRANDE";
            break;
          case "Gigante":
            animalRegistered[i]['size'] = "GIGANTE";
            break;
        }
        animalRegistered[i]['tutor']= {"cpf" : animalRegistered[i]['cpf']};
        animalRegistered[i]['vetMicrochip'] = {"crmv" : animalRegistered[i]['crmv']};
        if(animalRegistered[i]['status'] == 1)animalRegistered[i]['status'] = "INVISIBLE";
        else animalRegistered[i]['status'] = "VISIBLE";
        List medications = await AnimalMedicationRepository.getAllMedicationsByIdAnimalList(animalRegistered[i]["code"]);
        jsonString = jsonEncode(medications);
        medications = jsonDecode(jsonString);
        jsonString = null;
        if(medications.isNotEmpty && medications != null){
          for(int i = 0; i < medications.length; i++){
            medications[i]['medication']= {"name" : medications[i]['name']};
          }
        }
        animalRegistered[i]['medications'] = medications;
        animalRegistered[i]["code"] = null;
      }
      await ModalsRequest.post(animalRegistered, urlName);
    }
  }

  static Future update()async{
    List animalEdited = await AnimalRepository.getAllAnimalsEdited();
    String jsonString = jsonEncode(animalEdited);
    animalEdited = jsonDecode(jsonString);
    jsonString = null;
    if(animalEdited.isNotEmpty && animalEdited != null){
      for(int i = 0; i < animalEdited.length; i++){
        switch(animalEdited[i]['size']){
          case "Mini":
            animalEdited[i]['size'] = "MINI";
            break;
          case "Pequeno":
            animalEdited[i]['size'] = "PEQUENO";
            break;
          case "Médio":
            animalEdited[i]['size'] = "MEDIO";
            break;
          case "Grande":
            animalEdited[i]['size'] = "GRANDE";
            break;
          case "Gigante":
            animalEdited[i]['size'] = "GIGANTE";
            break;
        }
        animalEdited[i]['tutor']= {"cpf" : animalEdited[i]['cpf']};
        animalEdited[i]['vetMicrochip'] = {"crmv" : animalEdited[i]['crmv']};
        if(animalEdited[i]['status'] == 1)animalEdited[i]['status'] = "INVISIBLE";
        else animalEdited[i]['status'] = "VISIBLE";
        List medications = await AnimalMedicationRepository.getAllMedicationsByIdAnimalList(animalEdited[i]["code"]);
        jsonString = jsonEncode(medications);
        medications = jsonDecode(jsonString);
        jsonString = null;
        if(medications.isNotEmpty && medications != null){
          for(int i = 0; i < medications.length; i++){
            medications[i]['medication']= {"name" : medications[i]['name']};
          }
        }
        animalEdited[i]['medications'] = medications;
      }
      await ModalsRequest.put(animalEdited, urlName);
    }
  }

  static Future delete()async{
    List animalDelete = await AnimalRepository.getAllAnimalsRemovedList();
    String jsonString = jsonEncode(animalDelete);
    animalDelete = jsonDecode(jsonString);
    jsonString = null;
    if(animalDelete.isNotEmpty && animalDelete != null){
      await ModalsRequest.delete(animalDelete, urlName);
    }
  }
}