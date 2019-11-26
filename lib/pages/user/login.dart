import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_button.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:flutter_app/colors.dart';
import 'package:flutter_app/components/show_message_snackbar.dart';
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

import '../../user_login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();
  bool disabledButton = false;
  Map dataRequest = {};
  DatabaseConnect db = DatabaseConnect();

  _getPage(navigator) async{
    var response;
    response = await navigator;
    MySnackBar.message(response, scaffoldKey: _scaffoldKey);
  }

  void onSaved(values){
     dataRequest[values['title']] = values['value'];
  }

  void disabledOrEnabledButton(bool value){
    disabledButton = value;
    setState(() {});
  }

  void formSaved(){
    _formKeyLogin.currentState.save();
    request();
  }

  void request() async{
    var response;

    LoginRequest user = LoginRequest();
    user.setClient(dataRequest['email'], dataRequest['password']);

    try{
      disabledOrEnabledButton(true);
      response = await user.getLogin();
      disabledOrEnabledButton(false);
      if(response == null){
        MySnackBar.message('Erro ao Logar', scaffoldKey: _scaffoldKey);
      }else{
        switch(response.statusCode){
          case 200:
            saveUser(response);
            var responseMedications = await user.getAll();
            await saveAllValuesDatabase(responseMedications);
            break;
          default:
            MySnackBar.message('Email ou senha inválida',scaffoldKey: _scaffoldKey);
            break;
        }
      }
    }catch(exception){
      MySnackBar.message('Erro',scaffoldKey: _scaffoldKey);
    }
  }

  void saveUser(response) async {
    var body;
    body = json.decode(response.body);
    UserLogin user = UserLogin();
    user.setValues(body);
    user.password = dataRequest['password'];
    db.truncateUserLogin();
    var saved = await db.saveContact(user);
    if(saved != null)
      Navigator.pushReplacementNamed(context, "/home");
    else
      MySnackBar.message('Erro', scaffoldKey: _scaffoldKey);
  }

  Future saveAllValuesDatabase(responseMedications) async {
    Medications medications = Medications();
    Incidents incident = Incidents();
    User user = User();
    Vet vet = Vet();
    Tutor tutor = Tutor();
    Animal animal = Animal();
    Map valuesMedications = json.decode(responseMedications.body);
    await db.truncateIncidentsWithTutor();
    await db.truncateMedications();
    await db.truncateIncidents();
    await db.truncateUsers();
    await db.truncateTutor();
    await db.truncateAnimal();
    await db.truncateVets();
    await db.truncateAnimalMedications();
    for(var i = 0; i<valuesMedications['medications'].length; i++){
      medications.setValues(valuesMedications['medications'][i]);
      await db.saveMedications(medications);
    }
    for(var i = 0; i<valuesMedications['incidents'].length; i++) {
      incident.setValues(valuesMedications['incidents'][i]);
      await db.saveIncidents(incident);
    }
    if(LoginDatabase.levelsOfAccess == "ADMIN"){
      for(var i = 0; i<valuesMedications['users'].length; i++) {
        user.setValues(valuesMedications['users'][i]);
        await db.saveUser(user);
      }
    }
    for(var i = 0; i<valuesMedications['tutors'].length; i++) {
      TutorsIncidents tutorsIncidents = TutorsIncidents();
      tutor.setValues(valuesMedications['tutors'][i]);
      await db.saveTutor(tutor);
      for(var value in valuesMedications['tutors'][i]["incidents"]){
        tutorsIncidents.idIncidents = value["code"];
        tutorsIncidents.idTutor = tutor.id;
        await db.saveTutorIncidents(tutorsIncidents);
      }
    }
    for(var i = 0; i<valuesMedications['animals'].length; i++) {
      AnimalMedications animalMedications = AnimalMedications();
      animal.setValues(valuesMedications['animals'][i]);
      await db.saveAnimal(animal);
      for(var value in valuesMedications['animals'][i]["medications"]){
        animalMedications.idMedication = value['medication']["code"];
        animalMedications.dateMedication = value["dateMedications"];
        animalMedications.idAnimal = animal.id;
        await db.saveAnimalMedications(animalMedications);
      }
    }
    for(var i = 0; i < valuesMedications['vets'].length; i++) {
      vet.user.setValues(valuesMedications['vets'][i]['user']);
      vet.setValues(valuesMedications['vets'][i]);
      await db.saveVet(vet);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Registro de animais", style: TextStyle(color: ColorsUsed.greenDarkColor,
          fontFamily: 'Roboto', fontWeight: FontWeight.w400,),),
        backgroundColor: ColorsUsed.mainColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKeyLogin,
              child: Column(
                children: <Widget>[
                  MyTextField(
                    parentAction: onSaved,
                    title: 'email',
                    icon: Icons.email,
                    hint: "Email",
                  ),
                  MyTextField(
                    obscureText: true,
                    parentAction: onSaved,
                    title: 'password',
                    icon: Icons.vpn_key,
                    hint: "Senha",
                  ),
                  Padding(
                      padding: EdgeInsets.only(top : 30, left: 100, right: 100),
                      child: MyButton(
                        text: "Logar",
                        color: disabledButton ? Colors.black12 : null,
                        onPress: disabledButton ? (){} : formSaved,
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: GestureDetector(
                      onTap: () =>_getPage(Navigator.pushNamed(context, "/resetPassword1")),
                      child: Text("Esqueceu a senha?", style: TextStyle(
                        color: ColorsUsed.blueDarkColor,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: GestureDetector(
                      onTap: () =>_getPage(Navigator.pushNamed(context, "/register")),
                      child: Text("Não possui uma conta?", style: TextStyle(
                        color: ColorsUsed.blueDarkColor,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

