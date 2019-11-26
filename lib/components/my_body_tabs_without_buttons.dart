import 'package:flutter/material.dart';

import '../colors.dart';
import 'my_tab_page_selector.dart';

class MyBodyTabsWithoutButtons extends StatefulWidget {
  final List kIcons;
  final tabController;

  const MyBodyTabsWithoutButtons({Key key, this.kIcons, this.tabController}) : super(key: key);

  @override
  _MyBodyTabsWithoutButtonsState createState() => _MyBodyTabsWithoutButtonsState();
}

class _MyBodyTabsWithoutButtonsState extends State<MyBodyTabsWithoutButtons> with SingleTickerProviderStateMixin  {
  var _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = widget.tabController;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
