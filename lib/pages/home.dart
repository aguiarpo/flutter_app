import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/show_message_snackbar.dart';
import 'package:flutter_app/database/connect.dart';
import 'package:flutter_app/pages/animals/page_view_animals.dart';
import 'package:flutter_app/pages/incidents/page_view_incidents.dart';
import 'package:flutter_app/pages/medications/page_view_medications.dart';
import 'package:flutter_app/pages/page_view_persons.dart';

import 'package:flutter_app/icons/surca_icons.dart';
import 'package:flutter_app/user_login.dart';

import '../blocs/page_tab_bloc.dart';
import 'package:flutter_app/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NavBar();
  }
}

class NavBar extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  var bloc = NavigationDrawerBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DatabaseConnect db = DatabaseConnect();

  List<Widget> _kTabPages(){
    switch(LoginDatabase.levelsOfAccess){
      case "ADMIN":
        return [
          PageViewListAnimals(),
          PageViewListPersons(
            parentAction: _updateNavigationWithChild,
          ),
          PageViewListMedications(),
          PageViewListIncidents()
        ];
      case "USUARIO":
        return [
          PageViewListAnimals(),
          PageViewListPersons(
            parentAction: _updateNavigationWithChild,
          ),
        ];
      case "VETERINARIO":
        return [
          PageViewListAnimals(),
          PageViewListPersons(
            parentAction: _updateNavigationWithChild,
          ),
        ];
    }

  }

  List<Tab> _kTabs(){
    switch(LoginDatabase.levelsOfAccess){
      case "ADMIN":
        return <Tab> [
          Tab(icon: Icon(Surca.animal),),
          Tab(icon: Icon(Icons.person),),
          Tab(icon: Icon(Surca.vaccine)),
          Tab(icon: Icon(Surca.alert),),
        ];
      case "USUARIO":
        return <Tab> [
          Tab(icon: Icon(Surca.animal),),
          Tab(icon: Icon(Icons.person),),
        ];
      case "VETERINARIO":
        return <Tab> [
          Tab(icon: Icon(Surca.animal),),
          Tab(icon: Icon(Icons.person),),
        ];
    }
  }

  _updateNavigationWithChild(int navigation) {
    bloc.updateNavigationPagePersons(navigation);
    setState(() {});
  }

  Future _getPage(navigator) async{
    var response;
    response = await navigator;
    MySnackBar.message(response, scaffoldKey: _scaffoldKey);
  }

  selectPage() async {
    switch(bloc.getCurrentNavigation){
      case 2:
        await _getPage(Navigator.pushNamed(context, '/registerMedications'));
        break;
      case 0:
        Navigator.pushNamed(context, '/registerAnimals');
        break;
      case 1:
        switch(bloc.getCurrentNavigationPagePersons){
          case 0:
            await _getPage(Navigator.pushNamed(context, '/registerUser'));
            break;
        }
        break;
      case 3:
        await _getPage(Navigator.pushNamed(context, '/registerIncidents'));
        break;
    }
  }

  void selectTabBar(index) async{
    bloc.updateNavigation(index);
    setState(() {

    });
  }

  @override
  void initState(){
    List<Widget> kTabPagesList = _kTabPages();
    _tabController = TabController(
      length: kTabPagesList.length,
      initialIndex: 0,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: Visibility(
        visible: LoginDatabase.levelsOfAccess == "USUARIO" ? false : true,
        child: AnimatedOpacity(
          opacity: bloc.getCurrentNavigation == 1 ? bloc.getCurrentNavigationPagePersons == 1 ? 0 : 1 : 1,
          child: DraggableFab(
            child: FloatingActionButton(
              onPressed: selectPage,
              child: Icon(Icons.add, color: Colors.white,),
              backgroundColor: Color(0xffAD4347),
            ),
        ), duration: Duration(milliseconds: 500),
    ),
      ),
      appBar: AppBar(
        elevation: bloc.getCurrentNavigation == 1 ? 0 : 1,
        title: Text("Registro de animais", style: TextStyle(color: ColorsUsed.greenDarkColor,
          fontFamily: 'Roboto', fontWeight: FontWeight.w400,),),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.dehaze),
          color: ColorsUsed.greenDarkColor,
          onPressed: (){
            Navigator.pushNamed(context, "/config");
          },)
        ],
        backgroundColor: ColorsUsed.mainColor,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Material(
        color: ColorsUsed.mainColor,
        child: Builder(
          builder: (context) {
            return TabBar(
              indicatorColor: ColorsUsed.greenDarkColor,
              labelColor: ColorsUsed.greenDarkColor,
              unselectedLabelColor: ColorsUsed.secundaryColor,
              tabs: _kTabs(),
              onTap: (index){
                Scaffold.of(context).hideCurrentSnackBar();
                selectTabBar(index);
              },
              controller: _tabController,
            );
          }
        ),
      ),
      body: StreamBuilder<Object>(
        stream: bloc.getNavigation,
        initialData: bloc.navigationProvider.currentNavigation,
        builder: (context, snapshot) {
          return TabBarView(
            children: _kTabPages(),
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
          );
        }
      ),
    );
  }
}


