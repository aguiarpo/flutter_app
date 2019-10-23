import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_scaffold_tabs.dart';
import 'package:flutter_app/pages/user/tabs/tab_page1.dart';
import 'package:flutter_app/pages/user/tabs/tab_page2.dart';

class EditCont extends StatefulWidget {

  @override
  _EditCont createState() => _EditCont();
}

class _EditCont extends State<EditCont>{

  var kIcons = <Widget>[
    TabPage1(),
    TabPage2()
  ];

  @override
  Widget build(BuildContext context) {
    return MyScaffoldTabs(
      kIcons: kIcons,
      title: "Editar",
    );
  }
}