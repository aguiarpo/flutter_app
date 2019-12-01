import 'package:flutter/material.dart';
import 'package:flutter_app/components/others/my_bootom_sheet.dart';
import 'package:flutter_app/user_login.dart';
import 'package:intl/intl.dart';


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
      subtitle: DateFormat("dd-MM-yyyy").format( DateTime.parse(animal.birthDate)).toString(),
    ),
    MyBottomSheet(
      title: "Porte: ",
      subtitle: animal.sizeCm,
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
      title: "Microchipagem data: ",
      subtitle: DateFormat("dd-MM-yyyy").format( DateTime.parse(animal.dateMicrochip)).toString(),
    ),
    Visibility(
      visible: LoginDatabase.levelsOfAccess != "USUARIO",
      child: MyBottomSheet(
        title: "Observações: ",
        subtitle: animal.comments == null ? "" : animal.comments,
      ),
    ),
    Visibility(
      visible: LoginDatabase.levelsOfAccess == "ADMIN",
      child: MyBottomSheet(
        title: "Criado por: ",
        subtitle: animal.createdBy == null ? LoginDatabase.email : animal.createdBy,
      ),
    ),
    Visibility(
      visible: LoginDatabase.levelsOfAccess == "ADMIN",
      child: MyBottomSheet(
        title: "Último a modificar: ",
        subtitle: animal.lastModifiedBy == null ? LoginDatabase.email : animal.lastModifiedBy,
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