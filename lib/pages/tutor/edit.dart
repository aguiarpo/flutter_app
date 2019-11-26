import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/json_bloc.dart';
import 'package:flutter_app/components/my_body_tabs.dart';
import 'package:flutter_app/components/my_scaffold_tabs.dart';
import 'package:flutter_app/database/connect.dart';
import 'package:flutter_app/models/tutors_incidents.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page1.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page2.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page3.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page4.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page5.dart';
import 'package:flutter_app/validates/validator_medications.dart';
import 'package:flutter_app/validates/validator_tutor.dart';
import 'package:flutter_app/validates/validator_user.dart';
import 'package:rxdart/rxdart.dart';

class EditTutors extends StatefulWidget {
  const EditTutors({Key key}) : super(key: key);

  @override
  _EditTutors createState() => _EditTutors();
}

class _EditTutors extends State<EditTutors>{

  var bloc = JsonBloc();
  var level;
  var incidents = [];
  var incidentsWithTutors = [];
  int id;
  DatabaseConnect db = DatabaseConnect();

  List<Widget> kIcons(bloc) {

    return <Widget>[
      TabPage1(
        validateName: ValidateUser.validateNameEdit,
        validateMotherName: ValidateUser.validateNameEdit,
        validateRG: ValidateTutor.validateRgEdit,
        validateCpf: ValidateTutor.validateCpfEdit,
        jsonBloc: bloc,
      ),
      TabPage2(
        validateCep: ValidateTutor.validateCepEdit,
        validateCity: ValidateUser.validateCityEdit,
        validateNeighborhood: ValidateUser.validateCityEdit,
        jsonBloc: bloc,
      ),
      TabPage3(
        validateStreet: ValidateUser.validateCityEdit,
        jsonBloc: bloc,
      ),
      TabPage4(
        validateProfession: ValidateUser.validateCityEdit,
        validateTelephone1: ValidateUser.validateTelephoneEdit,
        jsonBloc: bloc,
      ),
      TabPage5(
        incidentsWithTutor : incidentsWithTutors,
        jsonBloc: bloc,
        incidents: incidents,
      ),
    ] ;
  }


  Future getIncidentsWIthTutor() async{
    List incidents = await db.getAllIncidentsByIdTutor(id);
    for(TutorsIncidents value in incidents){
      incidentsWithTutors.add(value.idIncidents);
    }
  }

  Future display() async {
    incidents = await db.getAllIncidents();
    return incidents;
  }


  @override
  void initState() {
    display();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    if(id == null)id = ModalRoute.of(context).settings.arguments;
    getIncidentsWIthTutor();
    return MyScaffoldTabs(
      body: StreamBuilder<Object>(
                    stream: bloc.getJSON,
                    initialData: bloc.jsonProvider.values,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return MyBodyTabs(
                          id : id,
                          requestNumber: 9,
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
      title: "Editar",
    );
  }
}