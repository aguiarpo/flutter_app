import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_bootom_sheet.dart';

List<Widget> showMyBottomSheet(){
  return <Widget>[
    MyBottomSheet(
      title: "Nome: ",
      subtitle: "Nome",
    ),
    MyBottomSheet(
      title: "Observações: ",
      subtitle: "Observações",
    )
  ];
}