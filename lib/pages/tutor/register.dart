import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_scaffold_tabs.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page1.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page2.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page3.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page4.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page5.dart';

class RegisterTutors extends StatefulWidget {
  const RegisterTutors({Key key}) : super(key: key);

  @override
  _RegisterTutors createState() => _RegisterTutors();
}

class _RegisterTutors extends State<RegisterTutors>{

  var kIcons = <Widget>[
    TabPage1(),
    TabPage2(),
    TabPage3(),
    TabPage4(),
    TabPage5(),
  ];

  @override
  Widget build(BuildContext context) {
    return MyScaffoldTabs(
      kIcons: kIcons,
      title: "Registrar",
    );
  }

}