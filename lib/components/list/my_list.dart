import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/others/show_message_snackbar.dart';
import 'package:flutter_app/database/repository/animal_medications_repository.dart';
import 'package:flutter_app/database/repository/animal_repository.dart';
import 'package:flutter_app/database/repository/incidents_repository.dart';
import 'package:flutter_app/database/repository/medications_repository.dart';
import 'package:flutter_app/database/repository/tutor_incidents_repository.dart';
import 'package:flutter_app/database/repository/tutor_repository.dart';
import 'package:flutter_app/models/animal_medications.dart';
import 'package:flutter_app/models/tutors_incidents.dart';
import 'package:flutter_app/user_login.dart';
import 'package:intl/intl.dart';

import '../others/my_bootom_sheet.dart';
import '../others/show_modal_options.dart';
import 'list_builder.dart';

// ignore: must_be_immutable
class MyList extends StatefulWidget {
  final Function showBottomSheet;
  final String snackRemove;
  final int indexName;
  final int indexName2;
  final double height;
  final String navigation;
  final String suggestion;
  final ValueChanged remove;
  final ValueChanged add;
  final selectValue;

  const MyList({Key key,this.showBottomSheet, this.snackRemove, this.indexName, this.height,
  this.navigation, this.remove, this.add, this.indexName2, this.suggestion, this.selectValue}) : super(key: key);

  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {

  var lastSuggestion;
  var lastValueSelect;
  var lastRemoved;
  List list;
  bool refresh = false;

  @override
  void initState() {
    super.initState();
  }

  getPage(navigator) async{
    var response;
    response = await navigator;
    MySnackBar.message(response,context: context);
  }

  Future getModals() async{
    dynamic list = [];
    switch(widget.indexName){
      case 1:
        if(widget.selectValue == "Removidos"){
          if(widget.suggestion == null || widget.suggestion == "") list = await MedicationsRepository.getAllMedicationsRemoved();
          else list = await MedicationsRepository.getAllMedicationsWhere(widget.selectValue, widget.suggestion);
        }else{
          if(widget.suggestion == null || widget.suggestion == "") list = await MedicationsRepository.getAllMedications();
          else list = await MedicationsRepository.getAllMedicationsWhere(widget.selectValue, widget.suggestion);
        }
        break;
      case 2:
        if(widget.selectValue == "Removidos"){
          if(widget.suggestion == null || widget.suggestion == "") list = await AnimalRepository.getAllAnimalsRemoved();
          else list = await AnimalRepository.getAllAnimalsWhere(widget.selectValue, widget.suggestion);
        }else{
          if(widget.suggestion == null || widget.suggestion == "") list = await AnimalRepository.getAllAnimals();
          else list = await AnimalRepository.getAllAnimalsWhere(widget.selectValue, widget.suggestion);
        }
        break;
      case 3:
          if(widget.selectValue == "Removidos"){
            if(widget.suggestion == null || widget.suggestion == "") list = await TutorRepository.getAllTutorsRemoved();
            else list = await TutorRepository.getAllTutorWhere(widget.selectValue, widget.suggestion);
          }else{
            if(widget.suggestion == null || widget.suggestion == "") list = await TutorRepository.getAllTutors();
            else list = await TutorRepository.getAllTutorWhere(widget.selectValue, widget.suggestion);
          }
        break;
      case 4:
        if(widget.selectValue == "Removidos"){
          if(widget.suggestion == null || widget.suggestion == "") list = await IncidentsRepository.getAllIncidentsRemoved();
          else list = await IncidentsRepository.getAllIncidentsWhere(widget.selectValue, widget.suggestion);
        }else{
          if(widget.suggestion == null || widget.suggestion == "") list = await IncidentsRepository.getAllIncidents();
          else list = await IncidentsRepository.getAllIncidentsWhere(widget.selectValue, widget.suggestion);
        }
        break;
    }
    return list;
  }

  @override
  void deactivate() {
    refresh = true;
    super.deactivate();
  }

  Future display() async {
    if(list == null || lastSuggestion != widget.suggestion || lastValueSelect != widget.selectValue || refresh){
      await Future.delayed(Duration(seconds: 1));
      list = await getModals();
      lastSuggestion = widget.suggestion;
      lastValueSelect = widget.selectValue;
      refresh = false;
      return list;
    }else{
      return list;
    }
  }

  List<Widget> getChildren(list, value){
    switch(widget.indexName){
      case 1:
      case 4:
        return [
          Text("${list[value].name}", style: TextStyle(fontWeight: FontWeight.w600),)
        ];
      case 3:
        if(widget.indexName2 == 0){
          return [
            Text("${list[value].name}", style: TextStyle(fontWeight: FontWeight.w600),),
            Text("${list[value].email}", style: TextStyle(fontWeight: FontWeight.w600),)
          ];
        }
        if(LoginDatabase.levelsOfAccess == "USUARIO"){
          return [
            Text("${list[value].name}", style: TextStyle(fontWeight: FontWeight.w600),),
          ];
        }else{
          return [
            Text("${list[value].name}", style: TextStyle(fontWeight: FontWeight.w600),),
            Text("${list[value].cpf}", style: TextStyle(fontWeight: FontWeight.w600),)
          ];
        }
        break;
      case 2:
        return [
          Text("${list[value].name}", style: TextStyle(fontWeight: FontWeight.w600),),
          Text("${list[value].microchipNumber}", style: TextStyle(fontWeight: FontWeight.w600),)
        ];
        break;
    }
    return [];
  }

  void dimissed(dynamicModel, index){
    Scaffold.of(context).hideCurrentSnackBar();
    lastRemoved = dynamicModel;
    if(dynamicModel.removed == 0) widget.remove(dynamicModel);
    else widget.add(dynamicModel);
    list.removeAt(index);
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('${dynamicModel.name} removido.'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            if(dynamicModel.removed == 0)  widget.remove(dynamicModel);
            else widget.add(dynamicModel);
            refresh = true;
            setState(() {});
          },
        ),
      ),
    );
  }

  void getById(id)async{
    var dynamicModal = await dynamicModalGet(id);
    if(dynamicModal != null)ShowModalOptions.showOption(context, id, widget.showBottomSheet(dynamicModal));
  }

  Future dynamicModalGet(id)async{
    var dynamicModal;
    switch(widget.indexName){
      case 1:
        dynamicModal = await MedicationsRepository.getMedications(id);
        break;
      case 2:
        dynamicModal = await AnimalRepository.getAnimal(id);
        dynamicModal.medicationsWidget = await createMedicationsWidget(id);
        break;
      case 4:
        dynamicModal = await IncidentsRepository.getIncidents(id);
        break;
      case 3:
        dynamicModal = await TutorRepository.getTutor(id);
        if(dynamicModal != null) dynamicModal.nameIncidents =  await createIncidentsList(id);
        break;
    }
    return dynamicModal;
  }

  Future<List> createMedicationsWidget(id) async {
    List<AnimalMedications> list = await AnimalMedicationRepository.getAllMedicationsByIdAnimal(id);
    List<Widget> listWigdet = [];
    listWigdet.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text("Medicações", style: TextStyle(color: Colors.white, fontSize: 17),),),
      ),
    );
    for(AnimalMedications value in list){
      listWigdet.add(
          MyBottomSheet(
            title: "Nome: " + value.medications.name,
            subtitle: "Data: " + DateFormat("dd-MM-yyyy").format( DateTime.parse(value.dateMedication)).toString(),
            color: Colors.white,
          )
      );
    }
    return listWigdet;
  }


  Future<List> createIncidentsList(int idTutor) async {
    List<Widget> listText = [];
    List<TutorsIncidents> list = await TutorIncidentRepository.getAllIncidentsByIdTutor(idTutor);
    for(TutorsIncidents value in list){
      listText.add(Text(value.incident.name));
    }
    return listText;
  }

  Future editClick(id)async{
      var modal = await dynamicModalGet(id);
      if(widget.indexName == 3 && modal != null){
        modal.incidents = await IncidentsRepository.getAllIncidents();
        List incidents = await TutorIncidentRepository.getAllIncidentsByIdTutor(id);
        for(TutorsIncidents value in incidents){
          modal.incidentsWithTutors.add(value.idIncidents);
        }
      }
      if(widget.indexName == 2 && modal != null){
        modal.tutor = await TutorRepository.getTutorByIdAnimal(modal.id);
        var list2 = await AnimalMedicationRepository.getAllMedicationsByIdAnimal(id);
        for(AnimalMedications value in list2){
          modal.medications.add(value.idMedication);
          modal.dates[value.idMedication] = DateTime.parse(value.dateMedication);
        }
        modal.list =  await MedicationsRepository.getAllMedications();
      }
      if(modal != null)getPage(Navigator.pushNamed(context, widget.navigation, arguments: modal));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: display(),
      builder: (context, snapshot) {
        if(lastSuggestion != widget.suggestion || lastValueSelect != widget.selectValue || refresh){
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            );
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
              if(LoginDatabase.levelsOfAccess == "USUARIO"){
                return ListBuilder.listBuilder(snapshot.data, widget.height, getById, getChildren, editClick);
              }else{
                return ListBuilder.listBuilderADMIN(snapshot.data, widget.height, dimissed, getById, getChildren, editClick);
              }
          }
        }else{
          if(LoginDatabase.levelsOfAccess == "USUARIO"){
            return ListBuilder.listBuilder(snapshot.data, widget.height, getById, getChildren, editClick);
          }else{
            return ListBuilder.listBuilderADMIN(snapshot.data, widget.height, dimissed, getById, getChildren, editClick);
          }
        }
      },
    );
  }
}
