import 'package:flutter/material.dart';
import 'package:flutter_app/database/connect.dart';
import 'package:flutter_app/pages/users/components/bottom_sheet_users.dart';
import 'package:flutter_app/components/my_list.dart';
import 'package:flutter_app/components/my_list_ui.dart';

class PageViewListUsers extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PageViewListUsers();
  }
}

class _PageViewListUsers extends State<PageViewListUsers> with AutomaticKeepAliveClientMixin<PageViewListUsers> {
  DatabaseConnect db = DatabaseConnect();
  String suggestion;
  String valueSelect;

  void removeUsers(user) async{
    user.removed = 1;
    int erro = await db.updateUser(user);
  }

  void saveUsers(user) async{
    user.removed = 0;
    await db.updateUser(user);
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
      selectList : ["Nome", "Email", "Removidos"],
      title: "Usuários",
      list: MyList(
        selectValue: valueSelect,
        suggestion: suggestion,
        navigation: '/editUsers',
        showBottomSheet: showMyBottomSheet,
        snackRemove: "Nome",
        indexName: 3,
        indexName2: 0,
        height: 70,
        remove: removeUsers,
        add: saveUsers,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
