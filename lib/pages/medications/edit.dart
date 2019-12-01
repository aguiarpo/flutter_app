import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/json_bloc.dart';
import 'package:flutter_app/components/tabs/my_body_tabs.dart';
import 'package:flutter_app/components/tabs/my_scaffold_tabs.dart';
import 'package:flutter_app/models/medications.dart';
import 'package:flutter_app/pages/medications/tabs/tab_page1.dart';

class EditMedications extends StatefulWidget {
  @override
  _EditMedicationsState createState() => _EditMedicationsState();
}

class _EditMedicationsState extends State<EditMedications> {
  TextEditingController controllerName = TextEditingController();
  Medications medication;

  var bloc = JsonBloc();
  int id;

  List<Widget> kIcons(bloc) {
    return [
      TabPage1(
        jsonBloc: bloc,
        name : medication.name,
      ),
    ];
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(medication == null)medication = ModalRoute.of(context).settings.arguments;
    id = medication.id;
    return MyScaffoldTabs(
      body: MyBodyTabs(
        id : id,
        requestNumber: 3,
        jsonSchemaBloc: bloc,
        kIcons: kIcons(bloc),
      ),
      title: "Editar",
    );
  }
}

