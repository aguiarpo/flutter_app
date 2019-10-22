import 'package:flutter/material.dart';
import 'package:flutter_app/pages/users/components/bottom_sheet_users.dart';
import 'package:flutter_app/components/my_list.dart';
import 'package:flutter_app/components/my_list_ui.dart';

class PageViewListUsers extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PageViewListUsers();
  }
}

class _PageViewListUsers extends State<PageViewListUsers> {
  String title;
  List<String> listIndexNames = [];

  List<Map> list = [{
    "Nome" : "Nome", "Email" : "Email", "CRMV" : "CRMV"
  },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : null
    },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : "CRMV"
    },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : "CRMV"
    },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : "CRMV"
    },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : "CRMV"
    },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : "CRMV"
    },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : null
    },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : null
    },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : "CRMV"
    },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : "CRMV"
    },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : "CRMV"
    },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : "CRMV"
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
    title = "Usuários";
    _listIndexNamesFunction();
  }

  @override
  Widget build(BuildContext context) {
    return MyListUI(
      selectList : ["Nome", "Email", "Removidos"],
      title: "Usuários",
      list: MyList(
        navigation: '/editUsers',
        list: list,
        showBottomSheet: showMyBottomSheet,
        snackRemove: "Nome",
        indexName: listIndexNames,
        height: 70,
      ),
    );
  }
}
