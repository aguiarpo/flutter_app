import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_scaffold_tabs.dart';
import 'package:flutter_app/pages/medications/tabs/tab_page1.dart';

class EditMedications extends StatefulWidget {
  @override
  _EditMedicationsState createState() => _EditMedicationsState();
}

class _EditMedicationsState extends State<EditMedications> {

  var kIcons = <Widget>[
    TabPage1(),
  ];

  @override
  Widget build(BuildContext context) {
    return MyScaffoldTabs(
      kIcons: kIcons,
      title: 'Editar',
    );
  }
}

