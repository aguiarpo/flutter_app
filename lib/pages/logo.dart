import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
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

import '../components/show_message_snackbar.dart';
import '../user_login.dart';

class SplashScreen  extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen > {
  DatabaseConnect db = DatabaseConnect();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  startTime() async {
    List userList = [];
    userList = await db.getAllContacts();
    Request request = Request();
    request.setNavigationContext(context);
    request.setScaffoldKey(_scaffoldKey);
    request.requestGetLogin(userList);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: InkWell(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(120),
            child: Image.asset('images/logo.png'),
          ),
        ),
      ),
    );
  }
}

class Request{

  List _userList;
  BuildContext _navigationContext;
  DatabaseConnect _db = DatabaseConnect();
  LoginRequest _user = LoginRequest();
  GlobalKey _scaffoldKey;

  void setNavigationContext(BuildContext context){
    _navigationContext = context;
  }

  void setScaffoldKey(GlobalKey scaffoldKey){
    _scaffoldKey = scaffoldKey;
  }

  requestGetLogin(List userList) async {
    _userList = userList;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none && userList != null){
      setLoginDatabase(_userList[0]);
      navigatePage('/home');
    }
    else if (connectivityResult == ConnectivityResult.none && userList == null) navigatePage('/login');
    else request();
  }

  request() async{
    var response;
    var responseMedications;
    try{
      if(_userList.isNotEmpty){
        UserLogin userLogin = _userList[0];
        setLoginDatabase(userLogin);
        _user.setClient(userLogin.email, userLogin.password);
        response = await _user.getLogin();
        await responseVerify(response, responseMedications, userLogin);
      }
      await Future.delayed(const Duration(seconds: 2));
      navigation(response);
    }catch(exception){
      navigatePage('/login');
    }
  }

  Future responseVerify(response,responseMedications, userLogin) async {
    if(response != null) {
      if (response.statusCode == 200) {
        saveLoginDatabase(userLogin, response);
        MySnackBar.message("Atualizando Banco de Dados", scaffoldKey: _scaffoldKey);
        responseMedications = await _user.getAll();
        await saveAllValuesDatabase(responseMedications);
      }else{
        navigatePage("/login");
      }
    }else{
      navigatePage("/home");
    }
  }

  void saveLoginDatabase(userLogin, response) async {
    UserLogin userRefresh = UserLogin();
    userRefresh.setValues(json.decode(response.body));
    userRefresh.password = userLogin.password;
    setLoginDatabase(userRefresh);
    await _db.truncateUserLogin();
    await _db.saveContact(userRefresh);
  }

  Future saveAllValuesDatabase(responseMedications) async {
    Medications medications = Medications();
    Incidents incident = Incidents();
    User user = User();
    Vet vet = Vet();
    Tutor tutor = Tutor();
    Animal animal = Animal();
    Map valuesMedications = json.decode(responseMedications.body);
    await _db.truncateIncidentsWithTutor();
    await _db.truncateMedications();
    await _db.truncateIncidents();
    await _db.truncateUsers();
    await _db.truncateTutor();
    await _db.truncateAnimal();
    await _db.truncateVets();
    await _db.truncateAnimalMedications();
    for(var i = 0; i<valuesMedications['medications'].length; i++){
      medications.setValues(valuesMedications['medications'][i]);
      await _db.saveMedications(medications);
    }
    for(var i = 0; i<valuesMedications['incidents'].length; i++) {
      incident.setValues(valuesMedications['incidents'][i]);
      await _db.saveIncidents(incident);
    }
    if(LoginDatabase.levelsOfAccess == "ADMIN"){
      for(var i = 0; i<valuesMedications['users'].length; i++) {
        user.setValues(valuesMedications['users'][i]);
        await _db.saveUser(user);
      }
    }
    for(var i = 0; i<valuesMedications['tutors'].length; i++) {
      TutorsIncidents tutorsIncidents = TutorsIncidents();
      tutor.setValues(valuesMedications['tutors'][i]);
      await _db.saveTutor(tutor);
      for(var value in valuesMedications['tutors'][i]["incidents"]){
        tutorsIncidents.idIncidents = value["code"];
        tutorsIncidents.idTutor = tutor.id;
        await _db.saveTutorIncidents(tutorsIncidents);
      }
    }
    for(var i = 0; i<valuesMedications['animals'].length; i++) {
      AnimalMedications animalMedications = AnimalMedications();
      animal.setValues(valuesMedications['animals'][i]);
      await _db.saveAnimal(animal);
      for(var value in valuesMedications['animals'][i]["medications"]){
        animalMedications.idMedication = value['medication']["code"];
        animalMedications.dateMedication = value["dateMedications"];
        animalMedications.idAnimal = animal.id;
        await _db.saveAnimalMedications(animalMedications);
      }
    }
      for(var i = 0; i < valuesMedications['vets'].length; i++) {
        vet.user.setValues(valuesMedications['vets'][i]['user']);
        vet.setValues(valuesMedications['vets'][i]);
        await _db.saveVet(vet);
      }
  }

  void setLoginDatabase(UserLogin userLogin){
    LoginDatabase.email = userLogin.email;
    LoginDatabase.password = userLogin.password;
    LoginDatabase.name = userLogin.name;
    LoginDatabase.city = userLogin.city;
    LoginDatabase.state = userLogin.state;
    LoginDatabase.levelsOfAccess = userLogin.levelsOfAccess;
    LoginDatabase.telephone1 = userLogin.telephone1;
    LoginDatabase.telephone2 = userLogin.telephone2;
  }

  void navigation(response){
    if(response == null){
      navigatePage("/login");
    }else{
      if(response.statusCode == 200)navigatePage("/home");
      else navigatePage("/login");
    }
  }

  void navigatePage(page){
    Navigator.pushReplacementNamed(_navigationContext, page);
  }
}
