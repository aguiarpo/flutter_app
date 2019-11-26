import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/json_bloc.dart';
import 'package:flutter_app/components/my_body_tabs.dart';
import 'package:flutter_app/database/connect.dart';
import 'package:flutter_app/models/animal_medications.dart';
import 'package:flutter_app/pages/animals/tabs/tab_page6.dart';
import 'package:flutter_app/pages/animals/tabs/tab_page8.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page1.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page2.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page3.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page4.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page5.dart' as prefix0;
import 'package:flutter_app/validates/validator_animals.dart';
import 'package:flutter_app/validates/validator_tutor.dart';
import 'package:flutter_app/validates/validator_user.dart';
import 'package:flutter_app/validates/validator_user_login.dart';
import 'package:flutter_app/validates/validator_vet.dart';
import '../../components/my_scaffold_tabs.dart';
import 'tabs/tab_page5.dart';
import 'tabs/tab_page7.dart';

class RegisterAnimals extends StatefulWidget {
  const RegisterAnimals({Key key}) : super(key: key);

  @override
  _RegisterAnimals createState() => _RegisterAnimals();
}

class _RegisterAnimals extends State<RegisterAnimals> with SingleTickerProviderStateMixin {
  var bloc = JsonBloc();
  int id;
  var level;
  DatabaseConnect db = DatabaseConnect();
  List medications = [];
  Map dates = {};
  List list =[];
  var incidents;

  List<Widget> kIcons(bloc){
    return <Widget>[
      TabPage1(
        validateName: ValidateUserLogin.validateName,
        validateCpf: ValidateTutor.validateCpf,
        validateRG: ValidateTutor.validateRg,
        validateMotherName: ValidateUserLogin.validateName,
        jsonBloc: bloc,
      ),
      TabPage2(
        validateCep: ValidateTutor.validateCep,
        validateNeighborhood: ValidateUserLogin.validateCity,
        validateCity: ValidateUserLogin.validateCity,
        jsonBloc: bloc,
      ),
      TabPage3(
        validateStreet: ValidateUserLogin.validateCity,
        jsonBloc: bloc,
      ),
      TabPage4(
        validateTelephone1: ValidateUserLogin.validateTelephone,
        validateProfession: ValidateUserLogin.validateCity,
        jsonBloc: bloc,
      ),
      prefix0.TabPage5(
        incidentsWithTutor : [],
        jsonBloc: bloc,
        incidents: incidents,
      ),
      TabPage5(
        validateName: ValidateUserLogin.validateCity,
        validateMicrochip: ValidateTutor.validateRg,
        validateBreed: ValidateUserLogin.validateCity,
        jsonBloc: bloc,
      ),
      TabPage6(
        validateSpecies: ValidateUserLogin.validateCity,
        validateSize: ValidateAnimals.validateSizeCm,
        validateCoatColor: ValidateUserLogin.validateCity,
        jsonBloc: bloc,
      ),
      TabPage7(
        validateCrmv: ValidateVet.validateCRMV3,
        jsonBloc: bloc,
      ),
      TabPage8(
        id: id,
        medications : medications,
        dates : dates,
        list : list,
        jsonBloc: bloc,
      ),
    ];
  }

  Future display() async{
    var list2 = [];
    incidents = await db.getAllIncidents();
    list =  await db.getAllMedications();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(id == null)id = ModalRoute.of(context).settings.arguments;
    display();
    return MyScaffoldTabs(
      body: StreamBuilder<Object>(
          stream: bloc.getJSON,
          initialData: bloc.jsonProvider.values,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MyBodyTabs(
                id : id,
                requestNumber: 10,
                jsonSchemaBloc: bloc,
                kIcons: kIcons(bloc),
              );
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }
      ),
      title: "Registrar",
    );
  }
}

