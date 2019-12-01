
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/json_bloc.dart';
import 'package:flutter_app/components/tabs/my_body_tabs.dart';
import 'package:flutter_app/components/tabs/my_scaffold_tabs.dart';
import 'package:flutter_app/models/tutor.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page1.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page2.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page3.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page4.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page9.dart';

class EditTutors extends StatefulWidget {
  const EditTutors({Key key}) : super(key: key);

  @override
  _EditTutors createState() => _EditTutors();
}

class _EditTutors extends State<EditTutors>{

  var bloc = JsonBloc();
  var level;
  var incidents = [];
  Tutor tutor;
  var incidentsWithTutors = [];
  int id;

  List<Widget> kIcons(bloc) {

    return <Widget>[
      TabPage1(
        name: tutor.name,
        motherName: tutor.motherName,
        cpf: tutor.cpf,
        rg: tutor.rg,
        jsonBloc: bloc,
      ),
      TabPage2(
        state : tutor.state,
        cep : tutor.cep,
        neighborhood : tutor.neighborhood,
        city : tutor.city,
        jsonBloc: bloc,
      ),
      TabPage3(
        street: tutor.street,
        number : tutor.number.toString(),
        complements: tutor.complements,
        jsonBloc: bloc,
      ),
      TabPage4(
        profession: tutor.profession,
        telephone1 : tutor.telephone1,
        telephone2 : tutor.telephone2,
        jsonBloc: bloc,
      ),
      TabPage9(
        incidentsWithTutor : incidentsWithTutors,
        jsonBloc: bloc,
        incidents: incidents,
      ),
    ] ;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    if(tutor == null)tutor = ModalRoute.of(context).settings.arguments;
    incidents = tutor.incidents;
    id = tutor.id;
    incidentsWithTutors = tutor.incidentsWithTutors;
    return MyScaffoldTabs(
      body: MyBodyTabs(
                          id : id,
                          requestNumber: 9,
                          jsonSchemaBloc: bloc,
                          kIcons: kIcons(bloc),
                        ),
      title: "Editar",
    );
  }
}