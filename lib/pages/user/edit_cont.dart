import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/json_bloc.dart';
import 'package:flutter_app/components/tabs/my_body_tabs.dart';
import 'package:flutter_app/components/tabs/my_scaffold_tabs.dart';
import 'package:flutter_app/pages/user/tabs/tab_page1.dart';
import 'package:flutter_app/pages/user/tabs/tab_page2.dart';
import 'package:flutter_app/validates/validate.dart';

import '../../user_login.dart';

class EditCont extends StatefulWidget {

  @override
  _EditCont createState() => _EditCont();
}

class _EditCont extends State<EditCont>{
  var bloc = JsonBloc();
  final myControllerName = TextEditingController();
  var myControllerState;
  final myControllerCity = TextEditingController();
  final myControllerTelephone1 = TextEditingController();
  final myControllerTelephone2 = TextEditingController();

  List<Widget> kIcons(bloc){
    return <Widget>[
      TabPage1(
        validatePassword : Validate.validatePassword2,
        controllerName: myControllerName,
        emailVisible: false,
        jsonBloc: bloc,
      ),
      TabPage2(
        jsonBloc: bloc,
        controllerState: myControllerState,
        controllerCity: myControllerCity,
        controllerTelephone1: myControllerTelephone1,
        controllerTelephone2: myControllerTelephone2,
      )
    ];
  }

  @override
  void initState(){
    super.initState();
    myControllerName.text = LoginDatabase.name;
    myControllerState = LoginDatabase.state;
    myControllerCity.text = LoginDatabase.city;
    myControllerTelephone1.text = LoginDatabase.telephone1;
    myControllerTelephone2.text = LoginDatabase.telephone2;
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldTabs(
      body: MyBodyTabs(
        requestNumber: 1,
        jsonSchemaBloc: bloc,
        kIcons: kIcons(bloc),
      ),
      title: "Editar",
    );
  }
}