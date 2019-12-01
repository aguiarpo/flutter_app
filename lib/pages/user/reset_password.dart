import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/user_bloc.dart';
import 'package:flutter_app/components/tabs/my_body_tabs_without_buttons.dart';
import 'package:flutter_app/components/tabs/my_scaffold_tabs.dart';
import 'package:flutter_app/components/others/show_message_snackbar.dart';
import 'package:flutter_app/pages/user/tabs/tabs_reset_password/tab_page3.dart';
import 'package:flutter_app/pages/user/tabs/tabs_reset_password/tab_page2.dart';
import 'package:flutter_app/pages/user/tabs/tabs_reset_password/tab_page1.dart';
import 'package:flutter_app/services/client.dart';
import 'package:flutter_app/services/request/user_request.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var bloc = UserBloc();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: kIcons().length,
      initialIndex: 0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> kIcons() {
    return <Widget>[
      TabPage1(
        bloc: bloc,
        parentAction: showTabs,
      ),
      TabPage2(
        bloc: bloc,
        parentAction: showTabs,
      ),
      TabPage3(
        bloc: bloc,
      ),
    ];
  }

  void showTabs(Map values){
    if(values['page'] != null){
      _tabController.animateTo(values['page']);
      setState(() {});
    }
    if(values['value'] != null)request(values['value']);
  }


  void request(values) async{
    try{
      UserRequest loginRequest = UserRequest();
      await loginRequest.addToken(json.encode(values));
      MySnackBar.message('Email Enviado', scaffoldKey: _scaffoldKey);
    }catch(e){
      UserAgentClient.client.close();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldTabs(
      scaffoldKey: _scaffoldKey,
      body: MyBodyTabsWithoutButtons(
        tabController: _tabController,
        kIcons: kIcons(),
      ),
      title: "Editar",
    );
  }
}