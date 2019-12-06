import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/json_bloc.dart';
import 'package:flutter_app/components/tabs/my_body_tabs.dart';
import 'package:flutter_app/database/repository/tutor_incidents_repository.dart';
import 'package:flutter_app/models/animal.dart';
import 'package:flutter_app/models/tutor.dart';
import 'package:flutter_app/models/tutors_incidents.dart';
import 'package:flutter_app/pages/animals/tabs/tab_page6.dart';
import 'package:flutter_app/pages/animals/tabs/tab_page8.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page1.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page2.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page3.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page4.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page9.dart';
import '../../components/tabs/my_scaffold_tabs.dart';
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
  List medications = [];
  Map dates = {};
  List list =[];
  var incidents;
  Tutor tutor = Tutor();
  Animal animal;

  List<Widget> kIcons(bloc){
    return <Widget>[
      TabPage1(
        incidentsWithTutor: incidentsWithTutorsFunction,
        rg: tutor.rg,
        cpf: tutor.cpf,
        motherName: tutor.motherName,
        name: tutor.name,
        parentAction: getTutor,
        jsonBloc: bloc,
      ),
      TabPage2(
        state: tutor.neighborhood.city.state.name,
        city: tutor.neighborhood.city.name,
        neighborhood: tutor.neighborhood.name,
        cep: tutor.cep,
        jsonBloc: bloc,
      ),
      TabPage3(
        street: tutor.street,
        number: tutor.number.toString(),
        complements: tutor.complements,
        jsonBloc: bloc,
      ),
      TabPage4(
        telephone2: tutor.telephone2,
        telephone1: tutor.telephone1,
        profession: tutor.profession,
        jsonBloc: bloc,
      ),
      TabPage5(
        jsonBloc: bloc,
      ),
      TabPage6(
        jsonBloc: bloc,
      ),
      TabPage7(
        jsonBloc: bloc,
      ),
      TabPage8(
        id: id,
        medications : medications,
        dates : dates,
        list : list,
        jsonBloc: bloc,
      ),
      TabPage9(
        incidentsWithTutor: tutor.incidentsWithTutors,
        jsonBloc: bloc,
        incidents: incidents,
      ),
    ];
  }

  void incidentsWithTutorsFunction(idTutor)async{
    List incidents = await TutorIncidentRepository.getAllIncidentsByIdTutor(idTutor);
    for(TutorsIncidents value in incidents){
      tutor.incidentsWithTutors.add(value.idIncidents);
    }
  }

  void getTutor(tutor){
    this.tutor = tutor;
  }

  @override
  void initState() {
    super.initState();
    tutor.neighborhood.city.state.name = "SC";
  }

  @override
  Widget build(BuildContext context) {
    if(animal == null)animal = ModalRoute.of(context).settings.arguments;
    list = animal.list;
    incidents = animal.tutor.incidents;
    return MyScaffoldTabs(
      body: MyBodyTabs(
        requestNumber: 10,
        jsonSchemaBloc: bloc,
        kIcons: kIcons(bloc),
      ),
      title: "Registrar",
    );
  }
}

