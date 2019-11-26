import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_list.dart';
import 'package:flutter_app/components/my_list_ui.dart';
import 'package:flutter_app/database/connect.dart';

import 'components/bottom_sheet_incidents.dart';


class PageViewListIncidents extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PageViewListIncidents();
  }
}

class _PageViewListIncidents  extends State<PageViewListIncidents> with AutomaticKeepAliveClientMixin<PageViewListIncidents> {
  DatabaseConnect db = DatabaseConnect();
  String suggestion;
  String valueSelect;

  void removeIncidents(incidents) async{
    incidents.removed = 1;
    int erro = await db.updateIncidents(incidents);
  }

  void saveIncidents(incidents) async{
    incidents.removed = 0;
    await db.updateIncidents(incidents);
  }

  @override
  void initState() {
    valueSelect = "Nome";
    super.initState();
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
  Widget build(BuildContext context) {
    return MyListUI(
      selectAction: getSelect,
      parentAction: getSuggestion,
      selectList : ["Nome", "Removidos"],
      title: "Incidentes",
      list: MyList(
        selectValue: valueSelect,
        suggestion: suggestion,
        navigation: '/editIncidents',
        showBottomSheet: showMyBottomSheet,
        snackRemove: "Número",
        indexName: 4,
        height: 70,
        remove: removeIncidents,
        add: saveIncidents,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}