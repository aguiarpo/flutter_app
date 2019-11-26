import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/json_bloc.dart';
import 'package:flutter_app/components/my_body_tabs.dart';
import 'package:flutter_app/components/my_scaffold_tabs.dart';
import 'package:flutter_app/pages/medications/tabs/tab_page1.dart';
import 'package:flutter_app/validates/validator_medications.dart';

class EditMedications extends StatefulWidget {
  @override
  _EditMedicationsState createState() => _EditMedicationsState();
}

class _EditMedicationsState extends State<EditMedications> {

  var bloc = JsonBloc();
  int id;

  List<Widget> kIcons(bloc) {
    return [
      TabPage1(
        validator: ValidateMedication.validateName2,
        jsonBloc: bloc,
      ),
    ];
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(id == null)id = ModalRoute.of(context).settings.arguments;
    return MyScaffoldTabs(
      body: StreamBuilder<Object>(
          stream: bloc.getJSON,
          initialData: bloc.jsonProvider.values,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MyBodyTabs(
                id : id,
                requestNumber: 3,
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

