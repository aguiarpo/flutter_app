import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_list.dart';
import 'package:flutter_app/components/my_list_ui.dart';
import 'package:flutter_app/pages/tutor/components/bottom_sheet_tutors.dart';

class PageViewListTutors extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PageViewListTutors();
  }
}

class _PageViewListTutors extends State<PageViewListTutors> {
  String title;
  List<String> listIndexNames = [];

  List<Map> list = [{
    "Nome" : "Nome", "CPF" : "CPF",
  },
    {
      "Nome" : "Nome", "CPF" : "CPF",
    },
    {
      "Nome" : "Nome", "CPF" : "CPF",
    },
    {
      "Nome" : "Nome", "CPF" : "CPF",
    },
    {
      "Nome" : "Nome", "CPF" : "CPF",
    },
    {
      "Nome" : "Nome", "CPF" : "CPF",
    },
    {
      "Nome" : "Nome", "CPF" : "CPF",
    },
    {
      "Nome" : "Nome", "CPF" : "CPF",
    },
    {
      "Nome" : "Nome", "CPF" : "CPF",
    },
    {
      "Nome" : "Nome", "CPF" : "CPF",
    },
    {
      "Nome" : "Nome", "CPF" : "CPF",
    },
    {
      "Nome" : "Nome", "CPF" : "CPF",
    },
    {
      "Nome" : "Nome", "CPF" : "CPF",
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
    title = "Tutores";
    _listIndexNamesFunction();
  }

  @override
  Widget build(BuildContext context) {
    return MyListUI(
      selectList : ["Nome", "CPF", "RG", "Removidos"],
      title: "Tutores",
      list: MyList(
        navigation: '/editTutors',
        list: list,
        showBottomSheet: showMyBottomSheet,
        snackRemove: "Nome",
        indexName: listIndexNames,
        height: 70,
      ),
    );
  }
}