import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/json_bloc.dart';
import 'package:flutter_app/components/my_body_tabs.dart';
import 'package:flutter_app/components/my_scaffold_tabs.dart';
import 'package:flutter_app/pages/incidents/tabs/tab_page1.dart';
import 'package:flutter_app/validates/validator_medications.dart';

class RegisterIncidents extends StatefulWidget {
  @override
  _RegisterIncidentsState createState() => _RegisterIncidentsState();
}

class _RegisterIncidentsState extends State<RegisterIncidents> {

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
                requestNumber: 4,
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
