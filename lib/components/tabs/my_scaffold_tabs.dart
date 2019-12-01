import 'package:flutter/material.dart';

import '../../colors.dart';

class MyScaffoldTabs extends StatefulWidget {
  final Widget body;
  final List kIcons;
  final String title;
  final scaffoldKey;

  const MyScaffoldTabs({Key key, this.kIcons, this.title, this.body, this.scaffoldKey}) : super(key: key);

  @override
  _MyScaffoldTabsState createState() => _MyScaffoldTabsState();
}

class _MyScaffoldTabsState extends State<MyScaffoldTabs>{

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        key: widget.scaffoldKey,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: ColorsUsed.greenDarkColor, //change your color here
            ),
            title: Text(widget.title, style: TextStyle(
              fontFamily: 'Roboto', fontWeight: FontWeight.w400,
              color: ColorsUsed.greenDarkColor,
            ),
            ),
            backgroundColor: ColorsUsed.mainColor,
          ),
          body: widget.body,
      ),
    );
  }
}
