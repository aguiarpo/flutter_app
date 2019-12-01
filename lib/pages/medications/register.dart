import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/json_bloc.dart';
import 'package:flutter_app/components/tabs/my_body_tabs.dart';
import 'package:flutter_app/components/tabs/my_scaffold_tabs.dart';
import 'package:flutter_app/pages/medications/tabs/tab_page1.dart';

class RegisterMedications extends StatefulWidget {
  @override
  _RegisterMedicationsState createState() => _RegisterMedicationsState();
}

class _RegisterMedicationsState extends State<RegisterMedications> {

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
          requestNumber: 2,
          jsonSchemaBloc: bloc,
          kIcons: kIcons(bloc),
        ),
        title: "Cadastrar",
      );
    }
  }