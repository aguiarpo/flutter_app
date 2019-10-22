import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/animals/tabs/tab_page2.dart';
import 'package:flutter_app/pages/animals/tabs/tab_page6.dart';
import 'package:flutter_app/pages/animals/tabs/tab_page8.dart';
import '../../components/my_scaffold_tabs.dart';
import 'tabs/tab_page1.dart';
import 'tabs/tab_page3.dart';
import 'tabs/tab_page4.dart';
import 'tabs/tab_page5.dart';
import 'tabs/tab_page7.dart';

class RegisterAnimals extends StatefulWidget {
  const RegisterAnimals({Key key}) : super(key: key);

  @override
  _RegisterAnimals createState() => _RegisterAnimals();
}

class _RegisterAnimals extends State<RegisterAnimals> with SingleTickerProviderStateMixin {

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
      title: "Registrar",
    );
  }
}

