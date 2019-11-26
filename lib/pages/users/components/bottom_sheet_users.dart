import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_bootom_sheet.dart';
import 'package:flutter_app/database/connect.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/models/vet.dart';

List<Widget> showMyBottomSheet(User user){
  return <Widget>[
    MyBottomSheet(
      title: "Nome: ",
      subtitle: user.name,
    ),
    MyBottomSheet(
      title: "Email: ",
      subtitle: user.email,
    ),
    MyBottomSheet(
      title: "Nível: ",
      subtitle: user.levelsOfAccess,
    ),
    Visibility(                                                                                                                     
      visible: user.levelsOfAccess == "VETERINARIO",
      child: MyBottomSheet(
        title: "Crmv: ",
        subtitle: user.crmv == null ? "" : user.crmv,
      ),
    ),
    MyBottomSheet(
      title: "Cidade: ",
      subtitle: user.city,
    ),
    MyBottomSheet(
      title: "Estado: ",
      subtitle: user.state,
    ),
    Container(
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text("Telefones: "),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(user.telephone1),
            ),
            Text(user.telephone2 == null ? "" : user.telephone2),
          ],
        ),
      ),
    ),
  ];
}