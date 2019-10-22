import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_scaffold_tabs.dart';
import 'package:flutter_app/pages/user/tabs/tabs_reset_password/tab_page3.dart';
import 'package:flutter_app/pages/user/tabs/tabs_reset_password/tab_page2.dart';
import 'package:flutter_app/pages/user/tabs/tabs_reset_password/tab_page1.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> with SingleTickerProviderStateMixin {

  List<Widget> kIcons = <Widget>[
    TabPage1(),
    TabPage2(),
    TabPage3(),
  ];

  @override
  Widget build(BuildContext context) {
    return MyScaffoldTabs(
      kIcons: kIcons,
      title: "Editar",
    );
  }
}