import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_scaffold_tabs.dart';
import 'package:flutter_app/pages/animals/tabs/tab_page1.dart';
import 'package:flutter_app/pages/animals/tabs/tab_page2.dart';
import 'package:flutter_app/pages/animals/tabs/tab_page3.dart';
import 'package:flutter_app/pages/animals/tabs/tab_page4.dart';
import 'package:flutter_app/pages/animals/tabs/tab_page8.dart';

import 'tabs/tab_page5.dart';
import 'tabs/tab_page6.dart';
import 'tabs/tab_page7.dart';

class EditAnimals extends StatefulWidget {
  const EditAnimals({Key key}) : super(key: key);

  @override
  _EditUser createState() => _EditUser();
}

class _EditUser extends State<EditAnimals> {

  var kIcons = <Widget>[
    TabPage1(),
    TabPage2(),
    TabPage3(),
    TabPage4(),
    TabPage5(),
    TabPage6(),
    TabPage7(),
    TabPage8(),
  ];

  @override
  Widget build(BuildContext context) {
    return MyScaffoldTabs(
      kIcons: kIcons,
      title: "Editar",
    );
  }
}
