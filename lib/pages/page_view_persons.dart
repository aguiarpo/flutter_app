import 'package:flutter/material.dart';
import 'package:flutter_app/pages/tutor/page_view_tutors.dart';
import 'package:flutter_app/pages/users/page_view_users.dart';
import 'package:flutter_app/colors.dart';
import 'package:flutter_app/user_login.dart';

class PageViewListPersons extends StatefulWidget {
  final ValueChanged<int> parentAction;
  const PageViewListPersons({Key key, this.parentAction}) : super(key: key);

  @override
  _PageViewListPersonsState createState() => _PageViewListPersonsState();
}

class _PageViewListPersonsState extends State<PageViewListPersons> with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<Widget> _kTabPages(){
    switch(LoginDatabase.levelsOfAccess){
      case "ADMIN":
        return [
          PageViewListUsers(
          ),
          PageViewListTutors(
          )
        ];
      default:
        return [
          PageViewListTutors(
          )
        ];
    }
  }

  final _kTabsADMIN = <Tab>[
    Tab(text: 'Usuários'),
    Tab(text: 'Tutores'),
  ];

  final _kTabs = <Tab>[
    Tab(text: 'Tutores'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _kTabPages().length,
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
          color: ColorsUsed.mainColor,
          child: Visibility(
            visible: LoginDatabase.levelsOfAccess == "ADMIN",
            child: TabBar(
              controller: _tabController,
              indicatorColor: ColorsUsed.greenDarkColor,
              labelColor: ColorsUsed.greenDarkColor,
              unselectedLabelColor: ColorsUsed.secundaryColor,
              tabs: LoginDatabase.levelsOfAccess == "ADMIN" ? _kTabsADMIN : _kTabs,
              onTap: (index){
                Scaffold.of(context).hideCurrentSnackBar();
                widget.parentAction(index);
              },
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: _kTabPages(),
          ),
        )
      ],
    );
  }
}