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

class EditUser extends StatefulWidget {
  const EditUser({Key key}) : super(key: key);

  @override
  _EditUser createState() => _EditUser();
}

class _EditUser extends State<EditUser> with SingleTickerProviderStateMixin {

  var bloc = JsonBloc();
  int id;
  var level;

  List<Widget> kIcons(bloc) {
    return [
      TabPage1(
        type: 0,
        jsonBloc: bloc,
      ),
      TabPage2(
        level : level,
        jsonBloc: bloc,
      ),
      TabPage3(
        type: 0,
        jsonBloc: bloc,
      ),
    ];
  }

  Future getLevelsOfAccess() async{
    User user = User();
    DatabaseConnect db = DatabaseConnect();
    user = await db.getUser(id);
    if( user != null) level = user.levelsOfAccess;
  }


  @override
  Widget build(BuildContext context) {
    if(id == null)id = ModalRoute.of(context).settings.arguments;
    getLevelsOfAccess();
    return MyScaffoldTabs(
      body: StreamBuilder<Object>(
          stream: bloc.getJSON,
          initialData: bloc.jsonProvider.values,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MyBodyTabs(
                id : id,
                requestNumber: 7,
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