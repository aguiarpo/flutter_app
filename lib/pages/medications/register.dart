import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_scaffold_tabs.dart';
import 'package:flutter_app/pages/medications/tabs/tab_page1.dart';

class RegisterMedications extends StatefulWidget {
  @override
  _RegisterMedicationsState createState() => _RegisterMedicationsState();
}

class _RegisterMedicationsState extends State<RegisterMedications> {

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