import 'package:flutter/material.dart';
import 'package:flutter_app/components/others/my_bootom_sheet.dart';
import 'package:flutter_app/models/incidents.dart';

import '../../../user_login.dart';

List<Widget> showMyBottomSheet(Incidents incidents){
  return <Widget>[
    MyBottomSheet(
      title: "Nome: ",
      subtitle: incidents.name,
    ),
    MyBottomSheet(
      title: "Observações: ",
      subtitle: incidents.comments != null ? incidents.comments : "",
    ),
    Visibility(
      visible: LoginDatabase.levelsOfAccess == "ADMIN",
      child: MyBottomSheet(
        title: "Criado por: ",
        subtitle: incidents.createdBy == null ? LoginDatabase.email : incidents.createdBy,
      ),
    ),
    Visibility(
      visible: LoginDatabase.levelsOfAccess == "ADMIN",
      child: MyBottomSheet(
        title: "Último a modificar: ",
        subtitle: incidents.lastModifiedBy == null ? LoginDatabase.email : incidents.lastModifiedBy,
      ),
    ),
  ];
}