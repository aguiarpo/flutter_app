import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_bootom_sheet.dart';

List<Widget> showMyBottomSheet(){
  return <Widget>[
    MyBottomSheet(
      title: "Nome: ",
      subtitle: "Nome",
    ),
    MyBottomSheet(
      title: "CPF: ",
      subtitle: "Cpf",
    ),
    MyBottomSheet(
      title: "RG: ",
      subtitle: "Rg",
    ),
    MyBottomSheet(
      title: "Nome da mãe: ",
      subtitle: "Nome da mãe",
    ),
    MyBottomSheet(
      title: "Estado: ",
      subtitle: "Estado",
    ),
    MyBottomSheet(
      title: "Cidade: ",
      subtitle: "Cidade",
    ),
    MyBottomSheet(
      title: "Bairro: ",
      subtitle: "Bairro",
    ),
    MyBottomSheet(
      title: "Rua: ",
      subtitle: "Rua",
    ),
    MyBottomSheet(
      title: "Número: ",
      subtitle: "Número",
    ),
    MyBottomSheet(
      title: "Complemento: ",
      subtitle: "Complemnto",
    ),
    MyBottomSheet(
      title: "Profissão: ",
      subtitle: "Profissão",
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