import 'package:flutter/cupertino.dart';
import 'package:flutter_app/components/others/my_bootom_sheet.dart';
import 'package:flutter_app/models/medications.dart';

import '../../../user_login.dart';

List<Widget> showMyBottomSheet(Medications medications){
  return [
    MyBottomSheet(
      title: "Nome: ",
      subtitle: medications.name,
    ),
    Visibility(
      visible: LoginDatabase.levelsOfAccess == "ADMIN",
      child: MyBottomSheet(
        title: "Criado por: ",
        subtitle: medications.createdBy == null ? LoginDatabase.email : medications.createdBy,
      ),
    ),
    Visibility(
      visible: LoginDatabase.levelsOfAccess == "ADMIN",
      child: MyBottomSheet(
        title: "Último a modificar: ",
        subtitle: medications.lastModifiedBy == null ? LoginDatabase.email : medications.lastModifiedBy,
      ),
    ),
  ];
}