import 'package:flutter/material.dart';
import 'package:flutter_app/components/show_message_snackbar.dart';
import 'package:flutter_app/database/connect.dart';
import 'package:flutter_app/models/animal_medications.dart';
import 'package:flutter_app/models/medications.dart';
import 'package:flutter_app/models/tutors_incidents.dart';
import 'package:flutter_app/models/vet.dart';
import 'package:flutter_app/user_login.dart';

import '../colors.dart';
import 'my_bootom_sheet.dart';
import 'my_button.dart';
import 'show_modal_options.dart';

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
  dynamic list;
  bool refresh = false;
  DatabaseConnect db = DatabaseConnect();

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
          if(widget.suggestion == null || widget.suggestion == "") list = await db.getAllMedicationsRemoved();
          else list = await db.getAllMedicationsWhere(widget.selectValue, widget.suggestion);
        }else{
          if(widget.suggestion == null || widget.suggestion == "") list = await db.getAllMedications();
          else list = await db.getAllMedicationsWhere(widget.selectValue, widget.suggestion);
        }
        break;
      case 2:
        if(widget.selectValue == "Removidos"){
          if(widget.suggestion == null || widget.suggestion == "") list = await db.getAllAnimalsRemoved();
          else list = await db.getAllAnimalsWhere(widget.selectValue, widget.suggestion);
        }else{
          if(widget.suggestion == null || widget.suggestion == "") list = await db.getAllAnimals();
          else list = await db.getAllAnimalsWhere(widget.selectValue, widget.suggestion);
        }
        break;
      case 3:
        if(widget.indexName2 == 0){
          if(widget.selectValue == "Removidos"){
            if(widget.suggestion == null || widget.suggestion == "") list = await db.getAllUserRemoved();
            else list = await db.getAllUsersWhere(widget.selectValue, widget.suggestion);
          }else{
            if(widget.suggestion == null || widget.suggestion == "") list = await db.getAllUser();
            else list = await db.getAllUsersWhere(widget.selectValue, widget.suggestion);
          }
        } else {
          if(widget.selectValue == "Removidos"){
            if(widget.suggestion == null || widget.suggestion == "") list = await db.getAllTutorsRemoved();
            else list = await db.getAllTutorWhere(widget.selectValue, widget.suggestion);
          }else{
            if(widget.suggestion == null || widget.suggestion == "") list = await db.getAllTutors();
            else list = await db.getAllTutorWhere(widget.selectValue, widget.suggestion);
          }
        }
        break;
      case 4:
        if(widget.selectValue == "Removidos"){
          if(widget.suggestion == null || widget.suggestion == "") list = await db.getAllIncidentsRemoved();
          else list = await db.getAllIncidentsWhere(widget.selectValue, widget.suggestion);
        }else{
          if(widget.suggestion == null || widget.suggestion == "") list = await db.getAllIncidents();
          else list = await db.getAllIncidentsWhere(widget.selectValue, widget.suggestion);
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
      await Future.delayed(const Duration(milliseconds: 700));
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

  void dimissed(dynamicModel){
    Scaffold.of(context).hideCurrentSnackBar();
    lastRemoved = dynamicModel;
    if(dynamicModel.removed == 0) widget.remove(dynamicModel);
    else widget.add(dynamicModel);
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('${dynamicModel.name} removido.'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            if(dynamicModel.removed == 0) widget.remove(dynamicModel);
            else widget.add(dynamicModel);
            setState(() {

            });
          },
        ),
      ),
    );
  }

  void getById(id)async{
    DatabaseConnect db = DatabaseConnect();
    var dynamicModal;
    switch(widget.indexName){
      case 1:
        dynamicModal = await db.getMedications(id);
        break;
      case 2:
        dynamicModal = await db.getAnimal(id);
        dynamicModal.medicationsWidget = await createMedicationsWidget(id);
        break;
      case 4:
        dynamicModal = await db.getIncidents(id);
        break;
      case 3:
        if(widget.indexName2 == 0){
          dynamicModal = await db.getUser(id);
          Vet vet = Vet();
          if(dynamicModal != null && dynamicModal.levelsOfAccess == "VETERINARIO"){
            DatabaseConnect db = DatabaseConnect();
            vet = await db.getVet(dynamicModal.id);
            dynamicModal.setCrmv(vet.crmv);
          }
        }
        else{
          dynamicModal = await db.getTutor(id);
          if(dynamicModal != null) dynamicModal.nameIncidents =  await createIncidentsList(id);
        }
        break;
    }
    if(dynamicModal != null)ShowModalOptions.showOption(context, id, widget.showBottomSheet(dynamicModal));
  }

  Future<List> createMedicationsWidget(id) async {
    List<AnimalMedications> list = await db.getAllMedicationsByIdAnimal(id);
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
            subtitle: "Data: " + value.dateMedication,
            color: Colors.white,
          )
      );
    }
    return listWigdet;
  }


  Future<List> createIncidentsList(int idTutor) async {
    DatabaseConnect db = DatabaseConnect();
    List<Widget> listText = [];
    List<TutorsIncidents> list = await db.getAllIncidentsByIdTutor(idTutor);
    for(TutorsIncidents value in list){
      listText.add(Text(value.incident.name));
    }
    return listText;
  }

  Widget listBuilderADMIN(itens){
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 100),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itens.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(UniqueKey().toString()),
            onDismissed: (DismissDirection dir){
              dimissed(itens[index]);
            },
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete),
              alignment: Alignment.centerLeft,
            ),
            secondaryBackground: Container(
              color: Colors.red,
              child: Icon(Icons.delete),
              alignment: Alignment.centerRight,
            ),
            child: Container(
                height: widget.height,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        color: ColorsUsed.blueColor,
                        width: 10,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            getById(itens[index].id);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: getChildren(itens, index),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: LoginDatabase.levelsOfAccess == "USUARIO" ? false : true,
                        child: MyButton(
                          text: "Editar",
                          onPress: (){
                            getPage(Navigator.pushNamed(context, widget.navigation, arguments: itens[index].id));
                          },
                        ),
                      )
                    ],
                  ),
                )
            ),
          );
        }
    );
  }

  Widget listBuilder(itens){
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 100),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itens.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
                height: widget.height,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        color: ColorsUsed.blueColor,
                        width: 10,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            getById(itens[index].id);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: getChildren(itens, index),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: LoginDatabase.levelsOfAccess == "USUARIO" ? false : true,
                        child: MyButton(
                          text: "Editar",
                          onPress: (){
                            getPage(Navigator.pushNamed(context, widget.navigation, arguments: itens[index].id));
                          },
                        ),
                      )
                    ],
                  ),
                )
            );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: display(),
      builder: (context, snapshot) {
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
                return listBuilder(snapshot.data);
              }else{
                return listBuilderADMIN(snapshot.data);
              }
        }
      },
    );
  }
}
