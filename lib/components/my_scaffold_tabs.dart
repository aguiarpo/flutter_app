import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_tab_page_selector.dart';

import '../colors.dart';
import 'my_raise_button.dart';

class MyScaffoldTabs extends StatefulWidget {
  final List kIcons;
  final String title;

  const MyScaffoldTabs({Key key, this.kIcons, this.title}) : super(key: key);

  @override
  _MyScaffoldTabsState createState() => _MyScaffoldTabsState();
}

class _MyScaffoldTabsState extends State<MyScaffoldTabs> with SingleTickerProviderStateMixin{
  TabController _tabController;

  void showTabs(int value){
    _tabController.animateTo(value);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.kIcons.length,
      initialIndex: 0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
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
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  child: MyTabPageSelector(
                    color: Colors.white,
                    controller: _tabController,
                    indicatorSize: 9,
                    selectedColor: ColorsUsed.blueColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 420,
                        child: IconTheme(
                          data: IconThemeData(
                            size: 128.0,
                            color: Theme.of(context).accentColor,
                          ),
                          child: TabBarView(
                            controller: _tabController,
                            children: widget.kIcons,
                            physics: NeverScrollableScrollPhysics(),
                          ),
                        ),
                      ),
                      MyRaiseButton(
                        tabController: _tabController,
                        parentAction: showTabs,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
