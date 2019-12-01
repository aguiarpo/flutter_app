import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/json_bloc.dart';
import 'package:flutter_app/components/tabs/my_body_tabs.dart';
import 'package:flutter_app/components/tabs/my_scaffold_tabs.dart';
import 'package:flutter_app/models/incidents.dart';
import 'package:flutter_app/pages/incidents/tabs/tab_page1.dart';

class EditIncidents extends StatefulWidget {
  @override
  _EditIncidentsState createState() => _EditIncidentsState();
}

class _EditIncidentsState extends State<EditIncidents> {
  var bloc = JsonBloc();
  int id;
  Incidents incident;

  List<Widget> kIcons(bloc) {
    return [
      TabPage1(
        name: incident.name,
        comments: incident.comments,
        jsonBloc: bloc,
      ),
    ];
  }


  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    if(incident == null)incident = ModalRoute.of(context).settings.arguments;
    id = incident.id;
    return MyScaffoldTabs(
      body: MyBodyTabs(
      id : id,
      requestNumber: 5,
      jsonSchemaBloc: bloc,
      kIcons: kIcons(bloc),
    ),
      title: "Editar",
    );
  }
}
