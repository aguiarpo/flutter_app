import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_bootom_sheet.dart';
import 'package:flutter_app/models/animal.dart';
import 'package:flutter_app/user_login.dart';

import '../../../colors.dart';

List<Widget> showMyBottomSheet(animal){
  // bool castradorVisible = false;
  return <Widget>[
    MyBottomSheet(
      title: "Nome: ",
      subtitle: animal.name,
    ),
    MyBottomSheet(
      title: "Microchip: ",
      subtitle: animal.microchipNumber,
    ),
    MyBottomSheet(
      title: "Nascimento: ",
      subtitle: animal.birthDate,
    ),
    MyBottomSheet(
      title: "Raça: ",
      subtitle: animal.breed,
    ),
    MyBottomSheet(
      title: "Espécie: ",
      subtitle: animal.species,
    ),
    MyBottomSheet(
      title: "Microchipagem: ",
      subtitle: animal.dateMicrochip,
    ),
    MyBottomSheet(
      title: "Altura: ",
      subtitle: animal.sizeCm.toString(),
    ),
    Visibility(
      visible: LoginDatabase.levelsOfAccess != "USUARIO",
      child: MyBottomSheet(
        title: "Observações: ",
        subtitle: animal.comments == null ? "" : animal.comments,
      ),
    ),
    Visibility(
      visible: LoginDatabase.levelsOfAccess != "USUARIO",
      child: Container(
          decoration: BoxDecoration(
            color: ColorsUsed.terciaryColor,
            border : Border(bottom: BorderSide(width: 1, color: Colors.white,)),
          ),
          child: MyBottomSheet(
            title: "Veterinário: ",
            subtitle: animal.vet.crmv == null ? "" : animal.vet.crmv,
            color: Colors.white,
          )
      ),
    ),
    Container(
        decoration: BoxDecoration(
          color: ColorsUsed.terciaryColor,
          border : Border(bottom: BorderSide(width: 1, color: Colors.white,)),
        ),
        child: MyBottomSheet(
          title: "Tutor: ",
          subtitle: LoginDatabase.levelsOfAccess == "USUARIO" ? animal.tutor.name == null ? "" : animal.tutor.name : animal.tutor.cpf == null ? "" : animal.tutor.cpf,
          color: Colors.white,
        )
    ),
    Container(
        decoration: BoxDecoration(
          color: ColorsUsed.terciaryColor,
          border : Border(bottom: BorderSide(width: 1, color: Colors.white,)),
        ),
        child: Column(
          children: animal.medicationsWidget
        )
    ),
  ];
}