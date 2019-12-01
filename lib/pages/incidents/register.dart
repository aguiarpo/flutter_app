import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/json_bloc.dart';
import 'package:flutter_app/components/tabs/my_body_tabs.dart';
import 'package:flutter_app/components/tabs/my_scaffold_tabs.dart';
import 'package:flutter_app/pages/incidents/tabs/tab_page1.dart';

class RegisterIncidents extends StatefulWidget {
  @override
  _RegisterIncidentsState createState() => _RegisterIncidentsState();
}

class _RegisterIncidentsState extends State<RegisterIncidents> {

  var bloc = JsonBloc();

  List<Widget> kIcons(bloc) {
    return [
      TabPage1(
        jsonBloc: bloc,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldTabs(
      body: MyBodyTabs(
        requestNumber: 4,
        jsonSchemaBloc: bloc,
        kIcons: kIcons(bloc),
      ),
      title: "Cadastrar",
    );
  }
}
