import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_list.dart';
import 'package:flutter_app/components/my_list_ui.dart';
import 'package:flutter_app/database/connect.dart';
import 'package:flutter_app/models/animal.dart';
import 'package:flutter_app/pages/animals/components/bottom_sheet_animals.dart';
import 'package:flutter_app/user_login.dart';

class PageViewListAnimals extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PageViewListAnimals();
  }
}

class _PageViewListAnimals extends State<PageViewListAnimals> with AutomaticKeepAliveClientMixin<PageViewListAnimals> {
  DatabaseConnect db = DatabaseConnect();
  String suggestion;
  String valueSelect;

  dynamic list = [];

  void removeAnimal(animal) async{
    animal.removed = 1;
    int erro = await db.updateAnimal(animal);
  }

  void saveAnimal(animal) async{
    animal.removed = 0;
    await db.updateAnimal(animal);
  }

  getSuggestion(String suggestion){
    this.suggestion = suggestion;
    setState(() {});
  }

  getSelect(String value){
    this.valueSelect = value;
    setState(() {});
  }

  @override
  void initState() {
    valueSelect = "Nome";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyListUI(
      selectAction: getSelect,
      parentAction: getSuggestion,
      selectList :LoginDatabase.levelsOfAccess == "USUARIO"
          ? ["Nome", "Microchip", "Espécie", "Raça"] : ["Nome", "Microchip", "Espécie", "Raça", "Removidos"],
      title: "Animais",
      list: MyList(
        selectValue: valueSelect,
        suggestion: suggestion,
        navigation: '/editAnimals',
        showBottomSheet: showMyBottomSheet,
        snackRemove: "Nome",
        indexName: 2,
        height: 90,
        remove: removeAnimal,
        add: saveAnimal,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
