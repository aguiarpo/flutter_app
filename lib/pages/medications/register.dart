import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/json_bloc.dart';
import 'package:flutter_app/components/my_body_tabs.dart';
import 'package:flutter_app/components/my_scaffold_tabs.dart';
import 'package:flutter_app/pages/medications/tabs/tab_page1.dart';
import 'package:flutter_app/validates/validator_medications.dart';

class RegisterMedications extends StatefulWidget {
  @override
  _RegisterMedicationsState createState() => _RegisterMedicationsState();
}

class _RegisterMedicationsState extends State<RegisterMedications> {

  var bloc = JsonBloc();

  List<Widget> kIcons(bloc) {
    return [
      TabPage1(
        validator: ValidateMedication.validateName,
        jsonBloc: bloc,
      ),
    ];
  }

    @override
    Widget build(BuildContext context) {
      return MyScaffoldTabs(
        body: StreamBuilder<Object>(
            stream: bloc.getJSON,
            initialData: bloc.jsonProvider.values,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MyBodyTabs(
                  requestNumber: 2,
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
        title: "Cadastrar",
      );
    }
  }