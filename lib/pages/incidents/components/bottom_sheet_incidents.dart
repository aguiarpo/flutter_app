import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_bootom_sheet.dart';
import 'package:flutter_app/models/incidents.dart';

List<Widget> showMyBottomSheet(Incidents incidents){
  return <Widget>[
    MyBottomSheet(
      title: "Nome: ",
      subtitle: incidents.name,
    ),
    MyBottomSheet(
      title: "Observações: ",
      subtitle: incidents.comments != null ? incidents.comments : "",
    )
  ];
}