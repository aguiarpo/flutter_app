import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/json_bloc.dart';
import 'package:flutter_app/components/my_body_tabs.dart';
import 'package:flutter_app/components/my_scaffold_tabs.dart';
import 'package:flutter_app/pages/user/tabs/tab_page1.dart';
import 'package:flutter_app/pages/user/tabs/tab_page2.dart';
import 'package:flutter_app/validates/validator_user_login.dart';

class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register>{

  var bloc = JsonBloc();

  List<Widget> kIcons(bloc){
    return <Widget>[
      TabPage1(
        validatePassword: ValidateUserLogin.validatePassword,
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
      body: StreamBuilder<Object>(
        stream: bloc.getJSON,
        initialData: bloc.jsonProvider.values,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyBodyTabs(
              requestNumber: 0,
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