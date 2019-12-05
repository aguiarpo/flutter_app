import 'package:flutter/material.dart';
import 'package:flutter_app/components/inputs/my_text_field_autocomplete.dart';
import 'package:flutter_app/components/inputs/select.dart';
import 'package:flutter_app/components/inputs/textarea.dart';
import 'package:flutter_app/validates/validate.dart';

class TabPage7 extends StatefulWidget {
  final jsonBloc;
  final vet;
  final comments;
  final genre;
  final castrated;

  const TabPage7({Key key, this.jsonBloc, this.vet, this.comments, this.genre, this.castrated}) : super(key: key);

  @override
  _TabPage7State createState() => _TabPage7State();
}

class _TabPage7State extends State<TabPage7> with AutomaticKeepAliveClientMixin<TabPage7>{
  DateTime date2;

  var jsonBloc;
  TextEditingController controllerVet = TextEditingController();
  TextEditingController controllerComments = TextEditingController();
  String controllerGenre;
  bool controllerCheck;
  TextEditingController _typeAheadController = TextEditingController();
  FocusNode myFocusNode2 = new FocusNode();

  @override
  void initState() {
    super.initState();
    jsonBloc = widget.jsonBloc;
    if(widget.comments != null)controllerComments.text = widget.comments;
    if(widget.vet != null)_typeAheadController.text = widget.vet;
    if(widget.genre != null)controllerGenre = widget.genre;
    else controllerGenre = "Fêmea";
    setSelectValue(controllerGenre);
    if(widget.castrated !=null)controllerCheck = widget.castrated;
    else controllerCheck = false;
    setCheckbox(controllerCheck);
  }

  void onSaved(values){
    jsonBloc.addValueAnimal(values['title'], values['value']);
  }

  void setSelectValue(String value){
    jsonBloc.addValueAnimal('genre', value);
  }

  void setCheckbox(value){
    controllerCheck = value;
    if(value) value = 1;
    else value = 0;
    jsonBloc.addValueAnimal('castrated', value);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              MyAutoComplete(
                parentAction: onSaved,
                typeAheadController: _typeAheadController,
                title: "crmv",
                validator: Validate.validateAllWithoutEmpty,
                regex : r"^[0-9]*$",
                returnText: 'Caracteres inválidos',
                hint: "Crmv",
                table: "Vet",
              ),
              TextArea(
                onSaved: onSaved,
                controllerComments: controllerComments,
                labelText: "Observações do animal",
                title: "comments",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, bottom: 10),
                child: Select(
                  value: controllerGenre,
                  title: "Gênero",
                  parentAction: setSelectValue,
                  list: ["Macho", "Fêmea"],
                  padding: EdgeInsets.only(left: 10, right: 10),
                  border: BoxDecoration(
                    border: Border.all(color: Colors.grey,),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 10),
                child: Row(
                  children: <Widget>[
                    Text("Animal castrado: ", style: TextStyle(color: Colors.grey),),
                    Checkbox(
                        value: controllerCheck,
                        onChanged: setCheckbox
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}