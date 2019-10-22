import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_scaffold_tabs.dart';
import 'package:flutter_app/pages/incidents/tabs/tab_page1.dart';

class RegisterIncidents extends StatefulWidget {
  @override
  _RegisterIncidentsState createState() => _RegisterIncidentsState();
}

class _RegisterIncidentsState extends State<RegisterIncidents> {

  var kIcons = <Widget>[
    TabPage1(),
  ];

  @override
  Widget build(BuildContext context) {
    return MyScaffoldTabs(
      kIcons: kIcons,
      title: "Registrar",
    );
  }
}
