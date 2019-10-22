import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_bootom_sheet.dart';

import '../../../colors.dart';

List<Widget> showMyBottomSheet(){
  // bool castradorVisible = false;
  return <Widget>[
    MyBottomSheet(
      title: "Microchip: ",
      subtitle: "Microchip",
    ),
    MyBottomSheet(
      title: "Nascimento: ",
      subtitle: "Data",
    ),
    MyBottomSheet(
      title: "Raça: ",
      subtitle: "Raça",
    ),
    MyBottomSheet(
      title: "Espécie: ",
      subtitle: "Espécie",
    ),
    MyBottomSheet(
      title: "Microchipagem: ",
      subtitle: "Data",
    ),
    MyBottomSheet(
      title: "Altura: ",
      subtitle: "Cm",
    ),
    MyBottomSheet(
      title: "Observações: ",
      subtitle: "Observações",
    ),
    Container(
        decoration: BoxDecoration(
          color: ColorsUsed.terciaryColor,
          border : Border(bottom: BorderSide(width: 1, color: Colors.white,)),
        ),
        child: MyBottomSheet(
          title: "Castrador: ",
          subtitle: "Crmv",
          color: Colors.white,
        )
    ),
    Container(
        decoration: BoxDecoration(
          color: ColorsUsed.terciaryColor,
          border : Border(bottom: BorderSide(width: 1, color: Colors.white,)),
        ),
        child: MyBottomSheet(
          title: "Veterinário: ",
          subtitle: "Crmv",
          color: Colors.white,
        )
    ),
    Container(
        decoration: BoxDecoration(
          color: ColorsUsed.terciaryColor,
          border : Border(bottom: BorderSide(width: 1, color: Colors.white,)),
        ),
        child: MyBottomSheet(
          title: "Tutor: ",
          subtitle: "Cpf",
          color: Colors.white,
        )
    ),
  ];
}