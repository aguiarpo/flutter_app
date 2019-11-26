import 'package:flutter/cupertino.dart';
import 'package:flutter_app/components/my_bootom_sheet.dart';
import 'package:flutter_app/models/medications.dart';

List<Widget> showMyBottomSheet(Medications medications){
  return [
    MyBottomSheet(
      title: "Nome: ",
      subtitle: medications.name,
    )
  ];
}