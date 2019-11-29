import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_list.dart';
import 'package:flutter_app/components/my_list_ui.dart';
import 'package:flutter_app/database/repository/medications_repository.dart';
import 'components/bottom_sheet_medications.dart';

class PageViewListMedications extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PageViewListMedications();
  }
}

class _PageViewListMedications extends State<PageViewListMedications> with AutomaticKeepAliveClientMixin<PageViewListMedications>{
  String suggestion;
  String valueSelect;

  void removeMedications(medications) async{
    medications.removed = 1;
    await MedicationsRepository.updateMedication(medications);
  }

  void saveMedications(medication) async{
    medication.removed = 0;
    await MedicationsRepository.updateMedication(medication);
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
      selectList : ["Nome", "Removidos"],
      title: "Medicações",
      list: MyList(
        selectValue: valueSelect,
        suggestion: suggestion,
        navigation: '/editMedications',
        showBottomSheet: showMyBottomSheet,
        snackRemove: "Número",
        indexName: 1,
        height: 70,
        remove: removeMedications,
        add: saveMedications,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
