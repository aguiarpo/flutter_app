import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/others/show_message_snackbar.dart';
import 'package:flutter_app/database/repository/incidents_repository.dart';
import 'package:flutter_app/database/repository/medications_repository.dart';
import 'package:flutter_app/models/animal.dart';
import 'package:flutter_app/models/tutor.dart';
import 'package:flutter_app/pages/animals/page_view_animals.dart';
import 'package:flutter_app/pages/incidents/page_view_incidents.dart';
import 'package:flutter_app/pages/medications/page_view_medications.dart';

import 'package:flutter_app/icons/surca_icons.dart';
import 'package:flutter_app/pages/tutor/page_view_tutors.dart';
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

  List<Widget> _kTabPages(){
    switch(LoginDatabase.levelsOfAccess){
      case "ADMIN":
        return [
          PageViewListAnimals(),
          PageViewListTutors(),
          PageViewListMedications(),
          PageViewListIncidents()
        ];
      case "USUARIO":
        return [
          PageViewListAnimals(),
          PageViewListTutors(),
        ];
      case "VETERINARIO":
        return [
          PageViewListAnimals(),
          PageViewListTutors()
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
      case 1:
        Tutor tutor = Tutor();
        tutor.incidents = await IncidentsRepository.getAllIncidents();
        await _getPage(Navigator.pushNamed(context, '/registerTutor', arguments: tutor));
        break;
      case 0:
        Animal animal = Animal();
        animal.tutor.incidents = await IncidentsRepository.getAllIncidents();
        animal.list = await MedicationsRepository.getAllMedications();
        await _getPage(Navigator.pushNamed(context, '/registerAnimals', arguments: animal));
        break;
      case 3:
        await _getPage(Navigator.pushNamed(context, '/registerIncidents'));
        break;
    }
  }

  void selectTabBar(index) async{
    _scaffoldKey.currentState.hideCurrentSnackBar();
    bloc.updateNavigation(index);
    setState(() {});
  }

  @override
  void initState(){
    List<Widget> kTabPagesList = _kTabPages();
    _tabController = TabController(
      length: kTabPagesList.length,
      initialIndex: 0,
      vsync: this,
    );
    _tabController.addListener(() {
      selectTabBar(_tabController.index);
    });
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
        child: DraggableFab(
          child: FloatingActionButton(
            onPressed: selectPage,
            child: Icon(Icons.add, color: Colors.white,),
            backgroundColor: Color(0xffAD4347),
          ),
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
              controller: _tabController,
            );
          }
        ),
      ),
      body: Container(
            child: GestureDetector(
              child: TabBarView(
                children: _kTabPages(),
                controller: _tabController,
              ),
            ),
          )
    );
  }
}


