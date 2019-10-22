import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_scaffold_tabs.dart';
import 'package:flutter_app/pages/users/tabs/tab_page1.dart';
import 'package:flutter_app/pages/users/tabs/tab_page2.dart';
import 'package:flutter_app/pages/users/tabs/tab_page3.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key key}) : super(key: key);

  @override
  _EditUser createState() => _EditUser();
}

class _EditUser extends State<RegisterUser> with SingleTickerProviderStateMixin {

  var kIcons = <Widget>[
    TabPage1(),
    TabPage2(),
    TabPage3(),
  ];

  @override
  Widget build(BuildContext context) {
    return MyScaffoldTabs(
      kIcons: kIcons,
      title: "Registrar",
    );
  }
}