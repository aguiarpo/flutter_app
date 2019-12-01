import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/json_bloc.dart';
import 'package:flutter_app/components/tabs/my_body_tabs.dart';
import 'package:flutter_app/components/tabs/my_scaffold_tabs.dart';
import 'package:flutter_app/pages/user/tabs/tab_page1.dart';
import 'package:flutter_app/pages/user/tabs/tab_page2.dart';
import 'package:flutter_app/validates/validate.dart';

class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register>{

  var bloc = JsonBloc();

  List<Widget> kIcons(bloc){
    return <Widget>[
      TabPage1(
        validatePassword: Validate.validatePassword,
        emailVisible: true,
        jsonBloc: bloc,
      ),
      TabPage2(
        jsonBloc: bloc,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldTabs(
      body: MyBodyTabs(
        requestNumber: 0,
        jsonSchemaBloc: bloc,
        kIcons: kIcons(bloc),
      ),
      title: "Cadastrar",
    );
  }
}