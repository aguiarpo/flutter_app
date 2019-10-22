import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_list.dart';
import 'package:flutter_app/components/my_list_ui.dart';
import 'package:flutter_app/pages/animals/components/bottom_sheet_animals.dart';

class PageViewListAnimals extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PageViewListAnimals();
  }
}

class _PageViewListAnimals extends State<PageViewListAnimals> {
  String title;
  List<String> listIndexNames = [];

  List<Map> list = [{
    "Nome" : "Nome", "Número" : "1111", "CPF" : "CPF"
  },
    {
      "Nome" : "Nome", "Número" : "1111", "CPF" : "CPF"
    },
    {
      "Nome" : "Nome", "Número" : "1111", "CPF" : "CPF"
    },
    {
      "Nome" : "Nome", "Número" : "1111", "CPF" : "CPF"
    },
    {
      "Nome" : "Nome", "Número" : "1111", "CPF" : "CPF"
    },
    {
      "Nome" : "Nome", "Número" : "1111", "CPF" : "CPF"
    },

    {
      "Nome" : "Nome", "Número" : "1111", "CPF" : "CPF"
    },
    {
      "Nome" : "Nome", "Número" : "1111", "CPF" : "CPF"
    },
    {
      "Nome" : "Nome", "Número" : "1111", "CPF" : "CPF"
    },
    {
      "Nome" : "Nome", "Número" : "1111", "CPF" : "CPF"
    },
    {
      "Nome" : "Nome", "Número" : "1111", "CPF" : "CPF"
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
    title = "Animais";
    _listIndexNamesFunction();
  }

  @override
  Widget build(BuildContext context) {
    return MyListUI(
      selectList : ["Nome", "Microchip", "Espécie", "Raça", "Removidos"],
      title: "Animais",
      list: MyList(
        navigation: '/editAnimals',
        list: list,
        showBottomSheet: showMyBottomSheet,
        snackRemove: "Nome",
        indexName: listIndexNames,
        height: 90,
      ),
    );
  }
}
