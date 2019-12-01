import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/json_bloc.dart';
import 'package:flutter_app/components/tabs/my_body_tabs.dart';
import 'package:flutter_app/components/tabs/my_scaffold_tabs.dart';
import 'package:flutter_app/models/animal.dart';
import 'package:flutter_app/pages/animals/tabs/tab_page5.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page1.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page2.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page3.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page4.dart';
import 'package:flutter_app/pages/animals/tabs/tab_page8.dart';
import 'tabs/tab_page6.dart';
import 'tabs/tab_page7.dart';
import 'tabs/tab_page5.dart';

class EditAnimals extends StatefulWidget {
  const EditAnimals({Key key}) : super(key: key);

  @override
  _EditUser createState() => _EditUser();
}

class _EditUser extends State<EditAnimals> {
  var bloc = JsonBloc();
  int id;
  var level;
  List medications = [];
  Map dates = {};
  List list =[];
  Animal animal;

  List<Widget> kIcons(bloc){
    return <Widget>[
      TabPage1(
        parentAction: getTutor,
        name: animal.tutor.name,
        motherName: animal.tutor.motherName,
        cpf: animal.tutor.cpf,
        rg: animal.tutor.rg,
        jsonBloc: bloc,
      ),
      TabPage2(
        cep: animal.tutor.cep,
        city: animal.tutor.city,
        neighborhood: animal.tutor.neighborhood,
        state: animal.tutor.state,
        jsonBloc: bloc,
      ),
      TabPage3(
        complements: animal.tutor.complements,
        number: animal.tutor.number.toString(),
        street: animal.tutor.street,
        jsonBloc: bloc,
      ),
      TabPage4(
        profession: animal.tutor.profession,
        telephone1: animal.tutor.telephone1,
        telephone2: animal.tutor.telephone2,
        jsonBloc: bloc,
      ),
      TabPage5(
        date : animal.birthDate,
        name: animal.name,
        microchip : animal.microchipNumber,
        breed: animal.breed,
        jsonBloc: bloc,
      ),
      TabPage6(
        date : animal.dateMicrochip,
        coatColor: animal.coatColor,
        size: animal.sizeCm,
        species: animal.species,
        jsonBloc: bloc,
      ),
      TabPage7(
        comments: animal.comments,
        vet: animal.vet.crmv,
        jsonBloc: bloc,
      ),
      TabPage8(
        id: id,
        medications : medications,
        dates : dates,
        list : list,
        jsonBloc: bloc,
      ),
    ];
  }

  void getTutor(tutor){
    animal.tutor = tutor;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(animal == null)animal = ModalRoute.of(context).settings.arguments;
    id = animal.id;
    list = animal.list;
    medications = animal.medications;
    dates = animal.dates;
    return MyScaffoldTabs(
      body: MyBodyTabs(
        id : id,
        requestNumber: 11,
        jsonSchemaBloc: bloc,
        kIcons: kIcons(bloc),
      ),
      title: "Editar",
    );
  }
}
