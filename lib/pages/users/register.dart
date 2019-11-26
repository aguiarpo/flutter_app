import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/json_bloc.dart';
import 'package:flutter_app/components/my_body_tabs.dart';
import 'package:flutter_app/components/my_scaffold_tabs.dart';
import 'package:flutter_app/database/connect.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/pages/users/tabs/tab_page1.dart';
import 'package:flutter_app/pages/users/tabs/tab_page2.dart';
import 'package:flutter_app/pages/users/tabs/tab_page3.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key key}) : super(key: key);

  @override
  _EditUser createState() => _EditUser();
}

class _EditUser extends State<RegisterUser> with SingleTickerProviderStateMixin {

  var bloc = JsonBloc();

  List<Widget> kIcons(bloc) {
    return [
      TabPage1(
        type: 1,
        jsonBloc: bloc,
      ),
      TabPage2(
        jsonBloc: bloc,
      ),
      TabPage3(
        type: 1,
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
                requestNumber: 6,
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
      title: "Registrar",
    );
  }
}