import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/database/connect.dart';
import 'package:flutter_app/models/animal.dart';
import 'package:flutter_app/models/animal_medications.dart';
import 'package:flutter_app/models/incidents.dart';
import 'package:flutter_app/models/medications.dart';
import 'package:flutter_app/models/tutor.dart';
import 'package:flutter_app/models/tutors_incidents.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/models/user_login.dart';
import 'package:flutter_app/models/vet.dart';
import 'package:flutter_app/services/login_request.dart';
import 'package:flutter_app/user_login.dart';

import '../colors.dart';
import 'my_raise_button.dart';
import 'my_tab_page_selector.dart';

class MyBodyTabs extends StatefulWidget {
  final int requestNumber;
  final List kIcons;
  final jsonSchemaBloc;
  final scaffold;
  final id;

  const MyBodyTabs({Key key, this.kIcons, this.jsonSchemaBloc, this.requestNumber, this.scaffold, this.id}) : super(key: key);

  @override
  _MyBodyTabsState createState() => _MyBodyTabsState();
}

class _MyBodyTabsState extends State<MyBodyTabs> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _requestNumber;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool disabledButton = false;
  int _backPage = 0;
  DatabaseConnect db = DatabaseConnect();
  var text = "";
  int maxTabs;

  void formValidate(int value) {
    if(value != _backPage){
      if(_formKey.currentState.validate()){
        switch(_requestNumber){
          case 0:
          case 1:
          case 6:
            if(maxTabs == value && !widget.jsonSchemaBloc.getSelectValidator){
              formSaved();
              Map valuesMap = widget.jsonSchemaBloc.getValue;
              if(valuesMap['password'] == null && valuesMap['confirmPassword'] == null){
                optionsButtons(value);
              }else{
                if(comparePasswords(valuesMap['password'], valuesMap['confirmPassword'])){
                  optionsButtons(value);
                }
              }
            }else{
              showTabs({'page' : value, 'currentPage' : _tabController.index});
            }
            break;
          default:
            formSaved();
            Map valuesMap = widget.jsonSchemaBloc.getValue;
            if(valuesMap['password'] == null && valuesMap['confirmPassword'] == null){
              optionsButtons(value);
            }else{
              if(comparePasswords(valuesMap['password'], valuesMap['confirmPassword'])){
                optionsButtons(value);
              }
            }
            break;
        }
      }
    }else{
      showTabs({'page' : value, 'currentPage' : _tabController.index});
    }
  }

  Future formSaved()async{
    FocusScope.of(context).requestFocus(new FocusNode());
   _formKey.currentState.save();
  }

  bool comparePasswords(String password, String confirmPassword){
    if(password == confirmPassword){
      return true;
    }else{
      final snackBar = SnackBar(content: Text('Senhas não coincidem'));
      Scaffold.of(context).showSnackBar(snackBar);
      return false;
    }
  }

  void optionsButtons(value){
    if(value == _tabController.length ) request();
    else showTabs({'page' : value, 'currentPage' : _tabController.index});
  }

  void showTabs(Map value){
    _backPage = value['currentPage'];
    _tabController.animateTo(value['page']);
    setState(() {});
  }

  void request() async{
    try {
      var response;
      var text = '';
      LoginRequest loginRequest = LoginRequest();
      disabledOrEnabledButton(true);
      Map value = widget.jsonSchemaBloc.getValue;
      switch (_requestNumber) {
        case 0:
          response =
          await loginRequest.addUser(widget.jsonSchemaBloc.getValueJSON);
          text = 'Usuário Cadastrado com Sucesso';
          break;
        case 1:
          var value = widget.jsonSchemaBloc.getValue;
          response =
          await loginRequest.setUserLogin(widget.jsonSchemaBloc.getValueJSON);
          LoginDatabase.name = value['name'];
          LoginDatabase.telephone1 = value['telephone1'];
          LoginDatabase.telephone2 = value['telephone2'];
          LoginDatabase.city = value['city'];
          LoginDatabase.state = value['state'];
          if (value['password'] != "")
            LoginDatabase.password = value['password'];
          else
            value['password'] = LoginDatabase.password;
          UserLogin user = await db.getContactEmail();
          if (user != null) {
            value['email'] = LoginDatabase.email;
            UserLogin saveUser = UserLogin();
            saveUser.setValues(value);
            saveUser.id = user.id;
            db.updateContact(saveUser);
          }
          text = 'Usuário Editado com Sucesso';
          break;
        case 2:
          saveMedications(value);
          break;
        case 3:
          updateMedications(value);
          break;
        case 4:
          saveIncidents(value);
          break;
        case 5:
          updateIncidents(value);
          break;
        case 6:
          saveUser(value);
          break;
        case 7:
          updateUsers(value);
          break;
        case 9:
          updateTutors(value);
          break;
        case 10:
          Map animalValue = widget.jsonSchemaBloc.getValueAnimal;
          saveAnimal(value, animalValue);
          break;
        case 11:
          Map animalValue = widget.jsonSchemaBloc.getValueAnimal;
          updateAnimal(value, animalValue);
          break;
      }
      disabledOrEnabledButton(false);
      if (_requestNumber <= 1) {
        var body;
        if (response == null) {
          errorMessage('Erro ao realizar o cadastro');
        } else {
          switch (response.statusCode) {
            case 200:
              Navigator.pop(context, text);
              break;
            case 404:
              body = json.decode(response.body);
              if (body['title'] == 'ConstraintViolationException')
                if (body['fieldMessage'] != null)
                  errorMessage(body['fieldMessage']);
              break;
          }
        }
      }
    }catch(exception){
      Navigator.pop(context, "Erro");
    }
  }

  void saveAnimal(value, animalValue)async{
    db = DatabaseConnect();
    var text = "";
    Tutor tutor = Tutor();
    Animal animal = Animal();
    Vet vet = Vet();
    Vet dbVet;
    Tutor dbTutor;
    dbVet = await db.getVetByCrmv(animalValue['crmv']);
    if(dbVet == null){
      text = "CRMV não existe";
      Navigator.pop(context, text);
    }else{
      tutor.setValuesWithoutNumber(value);
      var number = int.parse(value['number']);
      tutor.number = number;
      tutor.registered = 1;
      animalValue['sizeCm'] = int.parse(animalValue['sizeCm']);
      animal.setValuesWithoutId(animalValue);
      animal.idVet = dbVet.id;
      animal.registered = 1;
      Tutor savedTutor = await db.saveTutor(tutor);
      if(savedTutor == null){
        Navigator.pop(context, "Erro");
      }else{
        await db.deleteTutorIncidents(savedTutor.id);
        var incidents = value['incidents'];
        if(incidents.isNotEmpty){
          for(var i = 0; i < incidents.length; i++){
            await saveIncidentsTutor(incidents, i);
          }
        }
        animal.idTutor = savedTutor.id;
        Animal savedAnimal = await db.saveAnimal(animal);
        if(savedAnimal != null){
          await db.deleteMedicationsByIdAnimal(savedAnimal.id);
          Map medicationsList = value['medications'];
          if(medicationsList != null){
            medicationsList.forEach((index, value)async{
              AnimalMedications animalMedications = AnimalMedications();
              animalMedications.idAnimal = animal.id;
              animalMedications.idMedication = index;
              animalMedications.dateMedication = value.toString();
              await db.saveAnimalMedications(animalMedications);
            });
          }
          text = "Animal Editado com sucesso";
          Navigator.pop(context, text);
        }else{
          Navigator.pop(context, "Erro");
        }
      }
    }
  }

  void updateAnimal(value, animalValue)async{
    db = DatabaseConnect();
    var text = "";
    Tutor tutor = Tutor();
    Animal animal = Animal();
    Vet vet = Vet();
    Vet dbVet;
    Tutor dbTutor;
    Animal dbAnimal = await db.getAnimal(widget.id);
    if(value['cpf'] == ""){
      dbTutor = await db.getTutor(dbAnimal.idTutor);
      value['cpf'] = dbTutor.cpf;
    }else{
      dbTutor = await db.getTutorByCpf(value['cpf']);
    }
    if(dbTutor == null){
      text = "CPF não existe";
      Navigator.pop(context, text);
    }else{
      if(animalValue['crmv'] == ""){
        animalValue['crmv'] = dbAnimal.vet.crmv;
        dbVet = dbAnimal.vet;
        dbVet.id = dbAnimal.idVet;
      }else{
        dbVet = await db.getVetByCrmv(animalValue['crmv']);
      }
      if(dbVet == null){
        text = "CRMV não existe";
        Navigator.pop(context, text);
      }else{
        if(value['name'] == ""){
          value['name'] = dbTutor.name;
        }
        if(value['motherName'] == ""){
          value['motherName'] = dbTutor.motherName;
        }
        if(value['rg'] == ""){
          value['rg'] = dbTutor.rg;
        }
        if(value['cpf'] == ""){
          value['cpf'] = dbTutor.cpf;
        }
        if(value['state'] == null){
          value['state'] = dbTutor.state;
        }
        if(value['cep'] == ""){
          value['cep'] = dbTutor.cep;
        }
        if(value['neighborhood'] == ""){
          value['neighborhood'] = dbTutor.neighborhood;
        }
        if(value['city'] == ""){
          value['city'] = dbTutor.city;
        }
        if(value['street'] == ""){
          value['street'] = dbTutor.street;
        }
        if(value['number'] == ""){
          value['number'] = dbTutor.number;
        }else{
          value['number'] = int.parse(value['number']);
        }
        if(value['complements'] == ""){
          value['complements'] = dbTutor.complements;
        }
        if(value['profession'] == ""){
          value['profession'] = dbTutor.profession;
        }
        if(value['telephone1'] == ""){
          value['telephone1'] = dbTutor.telephone1;
        }
        if(value['telephone2'] == ""){
          value['telephone2'] = dbTutor.telephone2;
        }
        if(animalValue['name'] == ""){
          animalValue['name'] = dbAnimal.name;
        }
        if(animalValue['breed'] == ""){
          animalValue['breed'] = dbAnimal.breed;
        }
        if(animalValue['sizeCm'] == ""){
          animalValue['sizeCm'] = dbAnimal.sizeCm;
        }else{
          animalValue['sizeCm'] = int.parse(animalValue['sizeCm']);
        }
        if(animalValue['coatColor'] == ""){
          animalValue['coatColor'] = dbAnimal.coatColor;
        }
        if(animalValue['species'] == ""){
          animalValue['species'] = dbAnimal.species;
        }
        if(animalValue['microchipNumber'] == ""){
          animalValue['microchipNumber'] = dbAnimal.microchipNumber;
        }
        if(animalValue['comments'] == ""){
          animalValue['comments'] = dbAnimal.comments;
        }
        if(animalValue['dateMicrochip'] == "" || animalValue['dateMicrochip'] == null){
          animalValue['dateMicrochip'] = dbAnimal.dateMicrochip;
        }
        if(animalValue['birthDate'] == "" || animalValue['birthDate'] == null){
          animalValue['birthDate'] = dbAnimal.birthDate;
        }
        if(animalValue['animalCastrated'] == "" || animalValue['animalCastrated'] == null){
          animalValue['animalCastrated'] = dbAnimal.animalCastrated == 1 ? true : false;
        }
        tutor.setValues(value);
        tutor.id = dbTutor.id;
        tutor.createdDate = dbTutor.createdDate;
        tutor.createdBy = dbTutor.createdBy;
        tutor.removed = 0;
        tutor.registered = dbTutor.registered;
        tutor.edited = 1;
        animal.setValuesWithoutId(animalValue);
        animal.id = dbAnimal.id;
        animal.idTutor = dbTutor.id;
        animal.idVet = dbVet.id;
        animal.createdDate = dbAnimal.createdDate;
        animal.createdBy = animal.createdBy;
        animal.removed = 0;
        animal.registered = animal.registered;
        animal.edited = 1;
        var response = await db.updateTutor(tutor);
        if(response != 1){
          Navigator.pop(context, "Erro");
        }else{
          response = await db.updateAnimal(animal);
          if(response == 1){
            await db.deleteMedicationsByIdAnimal(animal.id);
            Map medicationsList = value['medications'];
            if(medicationsList != null){
              medicationsList.forEach((index, value)async{
                AnimalMedications animalMedications = AnimalMedications();
                animalMedications.idAnimal = animal.id;
                animalMedications.idMedication = index;
                animalMedications.dateMedication = value.toString();
                await db.saveAnimalMedications(animalMedications);
              });
            }
            }
            text = "Animal Editado com sucesso";
            Navigator.pop(context, text);
          }
        }
      }
    }

  void updateIncidents(value) async {
    db = DatabaseConnect();
    var text = "";
    Incidents incident = Incidents();
    Incidents dbIncidents = await db.getIncidents(widget.id);
    if(value['name'] == ""){
      value['name'] = dbIncidents.name;
    }
    if(value['comments'] == ""){
      value['comments'] = dbIncidents.comments;
    }
    incident.setValues(value);
    incident.id = widget.id;
    incident.createdDate = dbIncidents.createdDate;
    incident.createdBy = dbIncidents.createdBy;
    incident.removed = 0;
    incident.registered = dbIncidents.registered;
    incident.edited = 1;
    var response = await db.updateIncidents(incident);
    if(response == 1){
      text = "Incidente Editado com sucesso";
      Navigator.pop(context, text);
    }
  }

  void updateTutors(value) async {
    db = DatabaseConnect();
    var text = "";
    Tutor tutor = Tutor();
    Tutor dbTutor = await db.getTutor(widget.id);
    if(value['name'] == ""){
      value['name'] = dbTutor.name;
    }
    if(value['motherName'] == ""){
      value['motherName'] = dbTutor.motherName;
    }
    if(value['cpf'] == ""){
      value['cpf'] = dbTutor.cpf;
    }
    if(value['rg'] == ""){
      value['rg'] = dbTutor.rg;
    }
    if(value['cpf'] == ""){
      value['cpf'] = dbTutor.cpf;
    }
    if(value['state'] == null){
      value['state'] = dbTutor.state;
    }
    if(value['cep'] == ""){
      value['cep'] = dbTutor.cep;
    }
    if(value['neighborhood'] == ""){
      value['neighborhood'] = dbTutor.neighborhood;
    }
    if(value['city'] == ""){
      value['city'] = dbTutor.city;
    }
    if(value['street'] == ""){
      value['street'] = dbTutor.street;
    }
    if(value['number'] == ""){
      value['number'] = dbTutor.number;
    }else{
      value['number'] = int.parse(value['number']);
    }
    if(value['complements'] == ""){
      value['complements'] = dbTutor.complements;
    }
    if(value['profession'] == ""){
      value['profession'] = dbTutor.profession;
    }
    if(value['telephone1'] == ""){
      value['telephone1'] = dbTutor.telephone1;
    }
    if(value['telephone2'] == ""){
      value['telephone2'] = dbTutor.telephone2;
    }
    tutor.setValues(value);
    tutor.id = widget.id;
    tutor.createdDate = dbTutor.createdDate;
    tutor.createdBy = dbTutor.createdBy;
    tutor.removed = 0;
    tutor.registered = dbTutor.registered;
    tutor.edited = 1;
    var response = await db.updateTutor(tutor);
    await db.deleteTutorIncidents(widget.id);
    var incidents = value['incidents'];
    if(incidents.isNotEmpty){
      for(var i = 0; i < incidents.length; i++){
        await saveIncidentsTutor(incidents, i);
      }
    }
    if(response == 1){
      text = "Tutor Editado com sucesso";
      Navigator.pop(context, text);
    }
  }

  Future saveIncidentsTutor(incidents, i) async {
    if(incidents[i]["value"]){
      TutorsIncidents incident = TutorsIncidents();
      incident.idTutor = widget.id;
      incident.idIncidents = incidents[i]["id"];
      await db.saveTutorIncidents(incident);
    }
  }

  void updateUsers(value) async {
    db = DatabaseConnect();
    var text = "";
    User user = User();
    Vet vet = Vet();
    User dbUser = await db.getUser(widget.id);
    if(value['name'] == ""){
      value['name'] = dbUser.name;
    }
    if(value['email'] == ""){
      value['email'] = dbUser.email;
    }
    if(value['password'] == ""){
      value['password'] = dbUser.password;
    }
    if(value['password'] == ""){
      value['password'] = dbUser.password;
    }
    if(value['city'] == ""){
      value['city'] = dbUser.city;
    }
    if(value['state'] == null){
      value['state'] = dbUser.state;
    }
    if(value['telephone1'] == ""){
      value['telephone1'] = dbUser.telephone1;
    }
    if(value['telephone2'] == ""){
      value['telephone2'] = dbUser.telephone2;
    }
    if(value['levelsOfAccess'] == null){
      value['levelsOfAccess'] = dbUser.levelsOfAccess;
    }
    user.setValues(value);
    user.id = widget.id;
    user.createdDate = dbUser.createdDate;
    user.createdBy = dbUser.createdBy;
    user.removed = 0;
    user.registered = dbUser.registered;
    user.edited = 1;
    var response = await db.updateUser(user);
    if(value['crmv'] != null){
      Vet dbVet = await db.getVet(user.id);
      vet.userId = user.id;
      vet.crmv = value['crmv'];
      if(dbVet == null){
        db.saveVet(vet);
      }else{
        vet.id = dbVet.id;
        db.updateVet(vet);
      }
    }
    if(response == 1){
      text = "Usuário Editado com sucesso";
      Navigator.pop(context, text);
    }
  }

  void updateMedications(value) async {
    db = DatabaseConnect();
    var text = "";
    Medications medication = Medications();
    Medications dbMedication = await db.getMedications(widget.id);
    medication.setValues(value);
    medication.id = widget.id;
    medication.createdDate = dbMedication.createdDate;
    medication.createdBy = dbMedication.createdBy;
    medication.removed = 0;
    medication.registered = dbMedication.registered;
    medication.edited = 1;
    var response = await db.updateMedication(medication);
    if(response == 1){
      text = "Medicação Editada com sucesso";
      Navigator.pop(context, text);
    }
  }

  void errorMessage(String text){
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void saveMedications(value) async{
    try{
      db = DatabaseConnect();
      Medications medication = Medications();
      medication.setValues(value);
      medication.registered = 1;
      medication.edited = 0;
      medication.removed = 0;
      Medications medicationSaved = await db.saveMedications(medication);
      if(medicationSaved != null){
        text = "Medicação Cadastrada com sucesso";
        Navigator.pop(context, text);
      }
    }catch(e){
      text = "Erro ao realizaro cadastro";
      Navigator.pop(context, text);
    }
  }

  void saveUser(value) async{
    try{
      db = DatabaseConnect();
      Vet vet = Vet();
      Vet vetSaved;
      vet.user.setValues(value);
      vet.user.registered = 1;
      vet.user..edited = 0;
      vet.user..removed = 0;
      User userSaved = await db.saveUser(vet.user);
      if(userSaved != null){
        if(vet.user.levelsOfAccess == "VETERINARIO"){
          vet.crmv = value['crmv'];
          vet.userId = userSaved.id;
          vetSaved = await db.saveOnlyVet(vet);
          if(vetSaved != null){
            text = "Usuário Cadastrado com sucesso";
            Navigator.pop(context, text);
          }
        }else{
          if(userSaved != null){
            text = "Usuário Cadastrado com sucesso";
            Navigator.pop(context, text);
          }
        }
      }
    }catch(e){
      text = "Erro ao realizaro cadastro";
      Navigator.pop(context, text);
    }
  }


  void saveIncidents(value) async{
    try{
      db = DatabaseConnect();
      Incidents incident = Incidents();
      incident.setValues(value);
      incident.registered = 1;
      incident.edited = 0;
      incident.removed = 0;
      Incidents incidentSaved = await db.saveIncidents(incident);
      if(incidentSaved != null){
        text = "Incidente Cadastrado com sucesso";
        Navigator.pop(context, text);
      }
    }catch(e){
      text = "Erro ao realizaro cadastro";
      Navigator.pop(context, text);
    }
  }

  void disabledOrEnabledButton(bool value){
    disabledButton = value;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _requestNumber = widget.requestNumber;
    switch(_requestNumber){
      case 0:
      case 1:
        maxTabs = 2;
        break;
      case 7:
      case 6:
        maxTabs = 3;
        break;
      case 9:
        maxTabs = 5;
        break;
      case 11:
      case 10:
        maxTabs = 9;
        break;
    }
    _tabController = TabController(
      length: widget.kIcons.length,
      initialIndex: 0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: MyTabPageSelector(
                color: Colors.white,
                controller: _tabController,
                indicatorSize: 9,
                selectedColor: ColorsUsed.blueColor,
              ),
            ),
              Container(
                height: MediaQuery.of(context).size.height - 130,
                child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 510,
                          child: IconTheme(
                            data: IconThemeData(
                              size: 128.0,
                              color: Theme.of(context).accentColor,
                            ),
                            child: TabBarView(
                              controller: _tabController,
                              children: widget.kIcons,
                              physics: NeverScrollableScrollPhysics(),
                            ),
                          ),
                        ),
                        MyRaiseButton(
                          color: disabledButton ? Colors.grey.shade400 : null,
                          tabController: _tabController,
                          continueButton: disabledButton ? (value){} : formValidate,
                          backButton : disabledButton ? (value){} : showTabs
                        ),
                      ],
                    ),
                  ),
              ),
          ],
        ),
      ),
    );
  }
}

