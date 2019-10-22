import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_list.dart';
import 'package:flutter_app/components/my_list_ui.dart';

import 'components/bottom_sheet_medications.dart';

class PageViewListMedications extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PageViewListMedications();
  }
}

class _PageViewListMedications extends State<PageViewListMedications> {
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

  void _listIndexNamesFunction(){
    if(list[0] != null){
      var item = list[0];
      item.forEach((index, value){
        if(index != null) listIndexNames.add(index);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    title = "Medicações";
    _listIndexNamesFunction();
  }

  @override
  Widget build(BuildContext context) {
    return MyListUI(
      selectList : ["Nome", "Removidos"],
      title: "Medicações",
      list: MyList(
        navigation: '/editMedications',
        list: list,
        showBottomSheet: showMyBottomSheet,
        snackRemove: "Número",
        indexName: listIndexNames,
        height: 70,
      ),
    );
  }
}
