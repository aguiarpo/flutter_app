import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_bootom_sheet.dart';

List<Widget> showMyBottomSheet(){
  return <Widget>[
    MyBottomSheet(
      title: "Nome: ",
      subtitle: "Nome",
    ),
    MyBottomSheet(
      title: "Email: ",
      subtitle: "Email",
    ),
    MyBottomSheet(
      title: "Nível: ",
      subtitle: "Nível",
    ),
    MyBottomSheet(
      title: "Crmv: ",
      subtitle: "Crmv",
    ),
    MyBottomSheet(
      title: "Cidade: ",
      subtitle: "Cidade",
    ),
    MyBottomSheet(
      title: "Estado: ",
      subtitle: "Estado",
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
              child: Text("(47) 9999-0000"),
            ),
            Text("(47) 99999-0000"),
          ],
        ),
      ),
    ),
  ];
}