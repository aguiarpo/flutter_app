
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

class RegisterTutors extends StatefulWidget {
  const RegisterTutors({Key key}) : super(key: key);

  @override
  _RegisterTutors createState() => _RegisterTutors();
}

class _RegisterTutors extends State<RegisterTutors>{

  var bloc = JsonBloc();
  var incidents = [];
  Tutor tutor;
  int id;

  List<Widget> kIcons(bloc) {

    return <Widget>[
      TabPage1(
        jsonBloc: bloc,
      ),
      TabPage2(
        state: "SC",
        jsonBloc: bloc,
      ),
      TabPage3(
        jsonBloc: bloc,
      ),
      TabPage4(
        jsonBloc: bloc,
      ),
      TabPage9(
        incidentsWithTutor: [],
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
    return MyScaffoldTabs(
      body: MyBodyTabs(
        id : id,
        requestNumber: 8,
        jsonSchemaBloc: bloc,
        kIcons: kIcons(bloc),
      ),
      title: "Registrar",
    );
  }
}