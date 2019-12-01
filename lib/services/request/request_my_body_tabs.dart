import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/others/show_message_snackbar.dart';
import 'package:flutter_app/database/columns_names.dart';
import 'package:flutter_app/database/create_and_update/animals_db.dart';
import 'package:flutter_app/database/create_and_update/incidents_db.dart';
import 'package:flutter_app/database/create_and_update/medications_db.dart';
import 'package:flutter_app/database/create_and_update/tutor_db.dart';
import 'package:flutter_app/database/repository/all_repository.dart';
import 'package:flutter_app/database/repository/user_login_repository.dart';
import 'package:flutter_app/models/user_login.dart';
import 'package:flutter_app/services/request/user_request.dart';

import '../../user_login.dart';
import '../client.dart';

class RequestMyBodyTabs{

  var id;
  var context;

  Future request(Function disabledOrEnabledButton, jsonSchemaBloc, requestNumber) async{
    try {
      var response;
      var text = '';
      UserRequest loginRequest = UserRequest();
      disabledOrEnabledButton(true);
      Map value = jsonSchemaBloc.getValue;
      switch (requestNumber) {
        case 0:
          response =
          await loginRequest.addUser(jsonSchemaBloc.getValueJSON);
          text = 'Usuário Cadastrado com Sucesso';
          break;
        case 1:
          var value = jsonSchemaBloc.getValue;
          response =
          await loginRequest.setUserLogin(jsonSchemaBloc.getValueJSON);
          LoginDatabase.name = value['name'];
          LoginDatabase.telephone1 = value['telephone1'];
          LoginDatabase.telephone2 = value['telephone2'];
          LoginDatabase.city = value['city'];
          LoginDatabase.state = value['state'];
          if (value['password'] != "")
            LoginDatabase.password = value['password'];
          else
            value['password'] = LoginDatabase.password;
          UserLogin user = await UserLoginRepository.getContactEmail();
          if (user != null) {
            value['email'] = LoginDatabase.email;
            UserLogin saveUser = UserLogin();
            saveUser.setValues(value);
            saveUser.id = user.id;
            UserLoginRepository.updateContact(saveUser);
          }
          text = 'Usuário Editado com Sucesso';
          break;
        case 2:
          if(await uniqueValidate(medicationsTable, nameColumn, value['name']) == 0)
            await MedicationsDb.saveMedications(value, context);
          break;
        case 3:
          if(await uniqueValidate(medicationsTable, nameColumn, value['name']) == 0)
            await MedicationsDb.updateMedications(value, id, context);
          break;
        case 4:
          if(await uniqueValidate(incidentsTable, nameColumn, value['name']) == 0)
            await IncidentsDb.saveIncidents(value, context);
          break;
        case 5:
          if(await uniqueValidate(incidentsTable, nameColumn, value['name']) == 0)
            await IncidentsDb.updateIncidents(value, id, context);
          break;
        case 9:
          if(await uniqueValidate(tutorTable, cpfColumn, value['cpf']) == 0)
            if(await uniqueValidate(tutorTable, rgColumn, value['rg']) == 0)
              await TutorDb.updateTutors(value, id, context);
          break;
        case 10:
          Map animalValue = jsonSchemaBloc.getValueAnimal;
          if(await uniqueValidate(animalTable, microchipNumberColumn, animalValue['microchipNumber']) == 0)
            await AnimalDb.saveAnimal(value, animalValue, context);
          break;
        case 11:
          Map animalValue = jsonSchemaBloc.getValueAnimal;
          if(await uniqueValidate(animalTable, microchipNumberColumn, animalValue['microchipNumber']) == 0)
            await AnimalDb.updateAnimal(value, animalValue, id, context);
          break;
      }
      disabledOrEnabledButton(false);
      if (requestNumber <= 1) {
        var body;
        if (response == null) {
          MySnackBar.message('Erro ao realizar o cadastro', context: context);
        } else {
          switch (response.statusCode) {
            case 200:
              Navigator.pop(context, text);
              break;
            case 404:
              body = json.decode(response.body);
              if (body['title'] == 'ConstraintViolationException')
                if (body['fieldMessage'] != null)
                  MySnackBar.message(body['fieldMessage'], context: context);
              break;
          }
        }
      }
    }catch(exception){
      UserAgentClient.client.close();
      Navigator.pop(context, "Erro");
    }
  }

  Future uniqueValidate(table, column, value)async{
    var exists;
    String text;
    switch(column){
      case "nameColumn":
        text = "Esse nome já foi cadastrado";
        break;
      case "cpfColumn":
        text = "Esse cpf já foi cadastrado";
        break;
      case "rgColumn":
        text = "Esse rg já foi cadastrado";
        break;
      case "microchipNumberColumn":
        text = "Esse microchip já foi cadastrado";
    }
    if(id == null)exists = await AllRepository.getExists(table, column, value);
    else exists = await AllRepository.getExists(table, column, value, id: id);
    if(exists[0]['rowExists'] == 1) Scaffold.of(context).showSnackBar(
        SnackBar(content: Text(text))
    );
    return exists[0]["rowExists"];
  }
}