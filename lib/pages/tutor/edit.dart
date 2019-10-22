import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_scaffold_tabs.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page1.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page2.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page3.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page4.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page5.dart';

class EditTutors extends StatefulWidget {
  const EditTutors({Key key}) : super(key: key);

  @override
  _EditTutors createState() => _EditTutors();
}

class _EditTutors extends State<EditTutors>{

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
      title: "Editar",
    );
  }
}