import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/json_bloc.dart';
import 'package:flutter_app/components/my_body_tabs.dart';
import 'package:flutter_app/components/my_scaffold_tabs.dart';
import 'package:flutter_app/database/connect.dart';
import 'package:flutter_app/models/animal_medications.dart';
import 'package:flutter_app/pages/animals/tabs/tab_page5.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page1.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page2.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page3.dart';
import 'package:flutter_app/pages/tutor/tabs/tab_page4.dart';
import 'package:flutter_app/pages/animals/tabs/tab_page8.dart';
import 'package:flutter_app/validates/validator_animals.dart';
import 'package:flutter_app/validates/validator_tutor.dart';
import 'package:flutter_app/validates/validator_user.dart';
import 'package:flutter_app/validates/validator_vet.dart';
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
  DatabaseConnect db = DatabaseConnect();
  List medications = [];
  Map dates = {};
  List list =[];

  List<Widget> kIcons(bloc){
    return <Widget>[
      TabPage1(
        validateName: ValidateUser.validateNameEdit,
        validateMotherName: ValidateUser.validateNameEdit,
        validateRG: ValidateTutor.validateRgEdit,
        validateCpf: ValidateTutor.validateCpfEdit,
        jsonBloc: bloc,
      ),
      TabPage2(
        validateCep: ValidateTutor.validateCepEdit,
        validateCity: ValidateUser.validateCityEdit,
        validateNeighborhood: ValidateUser.validateCityEdit,
        jsonBloc: bloc,
      ),
      TabPage3(
        validateStreet: ValidateUser.validateCityEdit,
        jsonBloc: bloc,
      ),
      TabPage4(
        validateProfession: ValidateUser.validateCityEdit,
        validateTelephone1: ValidateUser.validateTelephoneEdit,
        jsonBloc: bloc,
      ),
      TabPage5(
        validateName: ValidateUser.validateCityEdit,
        validateMicrochip: ValidateTutor.validateRgEdit,
        validateBreed: ValidateUser.validateCityEdit,
        jsonBloc: bloc,
      ),
      TabPage6(
        validateCoatColor: ValidateUser.validateCityEdit,
        validateSize: ValidateAnimals.validateSizeCmEdit,
        validateSpecies: ValidateUser.validateCityEdit,
        jsonBloc: bloc,
      ),
      TabPage7(
        validateCrmv: ValidateVet.validateCRMV2,
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

  Future display() async{
    var list2 = await db.getAllMedicationsByIdAnimal(id);
    for(AnimalMedications value in list2){
      medications.add(value.idMedication);
      dates[value.idMedication] = DateTime.parse(value.dateMedication);
    }
    list =  await db.getAllMedications();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(id == null)id = ModalRoute.of(context).settings.arguments;
    display();
    return MyScaffoldTabs(
      body: StreamBuilder<Object>(
          stream: bloc.getJSON,
          initialData: bloc.jsonProvider.values,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MyBodyTabs(
                id : id,
                requestNumber: 11,
                jsonSchemaBloc: bloc,
                kIcons: kIcons(bloc),
              );
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }
      ),
      title: "Editar",
    );
  }
}
