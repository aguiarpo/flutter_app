import 'package:flutter/material.dart';
import 'package:flutter_app/pages/page_view_tutors.dart';
import 'package:flutter_app/pages/page_view_users.dart';

Color mainColor = Color(0xff8CFFBA);
const color = Color(0xff1A773F);
const color2 = Color(0xff66D994);

class PageViewListPersons extends StatefulWidget {
  final ValueChanged<int> parentAction;

  const PageViewListPersons({Key key, this.parentAction}) : super(key: key);

  @override
  _PageViewListPersonsState createState() => _PageViewListPersonsState();
}

class _PageViewListPersonsState extends State<PageViewListPersons> with SingleTickerProviderStateMixin {
  TabController _tabController;

  final List<Widget> _kTabPages = [
    PageViewListUsers(),
    PageViewListTutors()
  ];

  final _kTabs = <Tab>[
    Tab(text: 'Usuários'),
    Tab(text: 'Tutores'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _kTabPages.length,
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
    return Column(
      children: <Widget>[
        Container(
          color: mainColor,
          child: TabBar(
            controller: _tabController,
            indicatorColor: color,
            labelColor: color,
            unselectedLabelColor: color2,
            tabs: _kTabs,
            onTap: (index){
              Scaffold.of(context).hideCurrentSnackBar();
              widget.parentAction(index);
            },
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: _kTabPages,
          ),
        )
      ],
    );
  }
}