import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_list.dart';
import 'package:flutter_app/components/my_list_ui.dart';
import 'package:flutter_app/database/repository/tutor_repository.dart';
import 'package:flutter_app/pages/tutor/components/bottom_sheet_tutors.dart';

import '../../user_login.dart';

class PageViewListTutors extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PageViewListTutors();
  }
}

class _PageViewListTutors extends State<PageViewListTutors> with AutomaticKeepAliveClientMixin<PageViewListTutors>{
  String suggestion;
  String valueSelect;

  dynamic list = [];

  void removeTutor(tutor) async{
    tutor.removed = 1;
    await TutorRepository.updateTutor(tutor);
  }

  void saveTutor(tutor) async{
    tutor.removed = 0;
    tutor.edited = 1;
    await TutorRepository.updateTutor(tutor);
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
      selectList : LoginDatabase.levelsOfAccess == "USUARIO" ?  ["Nome"] : ["Nome", "CPF", "RG", "Removidos"],
      title: "Tutores",
      list: MyList(
        selectValue: valueSelect,
        suggestion: suggestion,
        navigation: '/editTutors',
        showBottomSheet: showMyBottomSheet,
        snackRemove: "Nome",
        indexName: 3,
        indexName2: 1,
        height: 70,
        remove: removeTutor,
        add: saveTutor,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}