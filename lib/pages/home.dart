import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/page_view_animals.dart';
import 'package:flutter_app/pages/page_view_incidents.dart';
import 'package:flutter_app/pages/page_view_medications.dart';
import 'package:flutter_app/pages/page_view_persons.dart';

import 'package:flutter_app/icons/surca_icons.dart';

import '../globals_var.dart';

Color mainColor = Color(0xff8CFFBA);
const color = Color(0xff1A773F);
const color2 = Color(0xff66D994);

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

  List<Widget> _kTabPages(){
    return [
      Container(),
      PageViewListMedications(),
      PageViewListAnimals(),
      PageViewListPersons(
        parentAction: _updateNavigationWithChild,
      ),
      PageViewListIncidents()
    ];
  }

  List<Tab> _kTabs(){
    return <Tab> [
      Tab(icon: Icon(Icons.home),),
      Tab(icon: Icon(Surca.vaccine)),
      Tab(icon: Icon(Surca.animal),),
      Tab(icon: Icon(Icons.person),),
      Tab(icon: Icon(Surca.incident),),
    ];
  }

  _updateNavigationWithChild(int navigation) {
    setState(() {
      bloc.updateNavigationPagePersons(navigation);
    });
  }

  @override
  void initState() {
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
      floatingActionButton: Visibility(
        visible: bloc.getCurrentNavigation != 0,
        child: DraggableFab(
          child: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
            },
            child: Icon(Icons.add, color: Colors.white,),
            backgroundColor: Color(0xffAD4347),
          ),
      ),
    ),
      appBar: AppBar(
        elevation: bloc.getCurrentNavigation == 3 ? 0 : 1,
        title: Text("Reserva", style: TextStyle(
          fontFamily: 'Roboto', fontWeight: FontWeight.w400,
          color: color,
        ),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.dehaze),
          color: color,
          onPressed: (){},)
        ],
        backgroundColor: mainColor,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Material(
        color: mainColor,
        child: TabBar(
          indicatorColor: color,
          labelColor: color,
          unselectedLabelColor: color2,
          tabs: _kTabs(),
          onTap: (index){
            setState(() {
              bloc.updateNavigation(index);
            });
          },
          controller: _tabController,
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


