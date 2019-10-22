import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_list.dart';
import 'package:flutter_app/components/my_list_ui.dart';

import 'components/bottom_sheet_incidents.dart';


class PageViewListIncidents extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PageViewListIncidents();
  }
}

class _PageViewListIncidents extends State<PageViewListIncidents> {
  String title;
  List<String> listIndexNames = [];

  List<Map> list = [{
    "Nome" : "Nome"
  },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },

  ];

  @override
  void initState() {
    super.initState();
    title = "Incidentes";
    _listIndexNamesFunction();
  }

  void _listIndexNamesFunction(){
    if(list[0] != null){
      var item = list[0];
      item.forEach((index, value){
        if(index != null) listIndexNames.add(index);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return MyListUI(
      selectList : ["Nome", "Removidos"],
      title: "Incidentes",
      list: MyList(
        navigation: '/editIncidents',
        list: list,
        showBottomSheet: showMyBottomSheet,
        snackRemove: "Nome",
        indexName: listIndexNames,
        height: 70,
      ),
    );
  }

}