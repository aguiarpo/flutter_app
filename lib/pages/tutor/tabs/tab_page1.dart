import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:flutter_app/database/repository/all_repository.dart';
import 'package:flutter_app/database/repository/tutor_repository.dart';
import 'package:flutter_app/models/tutor.dart';
import 'package:flutter_app/validates/validator_tutor.dart';
import 'package:flutter_app/validates/validator_user_login.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../colors.dart';

class TabPage1 extends StatefulWidget {
  final jsonBloc;
  final name;
  final motherName;
  final cpf;
  final rg;
  final Function incidentsWithTutor;
  final ValueChanged<Tutor> parentAction;

  const TabPage1({Key key, this.jsonBloc, this.name, this.motherName, this.cpf, this.rg, this.parentAction, this.incidentsWithTutor}) : super(key: key);
  @override
  _TabPage1State createState() => _TabPage1State();
}

class _TabPage1State extends State<TabPage1> with AutomaticKeepAliveClientMixin<TabPage1> {

  var jsonBloc;
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerMotherName = TextEditingController();
  TextEditingController controllerCpf = TextEditingController();
  TextEditingController controllerRg = TextEditingController();
  FocusNode myFocusNode = new FocusNode();
  TextEditingController _typeAheadController = TextEditingController();
  List suggestions;

  @override
  void initState(){
    controllerName.text = widget.name;
    controllerMotherName.text = widget.motherName;
    controllerCpf.text = widget.cpf;
    _typeAheadController.text = widget.cpf;
    controllerRg.text = widget.rg;
    super.initState();
    jsonBloc = widget.jsonBloc;
    myFocusNode.addListener(()async{
      if (!myFocusNode.hasFocus) {
        Tutor tutor = await TutorRepository.getTutorByCpf(_typeAheadController.text);
        if(tutor != null){
          if(widget.incidentsWithTutor != null){
            widget.incidentsWithTutor(tutor.id);
          }
          widget.parentAction(tutor);
          controllerName.text = tutor.name;
          controllerRg.text = tutor.rg;
          controllerMotherName.text = tutor.motherName;
        }
      }
    });
  }

  void onSaved(values)  {
    jsonBloc.addValue(values['title'], values['value']);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Visibility(
                visible: widget.parentAction == null ? false : true,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, bottom: 18),
                  child: GestureDetector(
                    child: TypeAheadFormField(
                      onSaved: (value){
                        Map values = {"title" : "cpf", "value" : value.trim()};
                        onSaved(values);
                      },
                      validator: ValidateTutor.validateCpf,
                      textFieldConfiguration: TextFieldConfiguration(
                        focusNode: myFocusNode,
                        controller: this._typeAheadController,
                        style: new TextStyle(color: Colors.grey),
                        decoration: InputDecoration(
                            prefixIcon: Container(
                              margin: EdgeInsets.only(right: 20),
                              padding: EdgeInsets.all(19),
                              decoration: BoxDecoration(
                                color: ColorsUsed.greenDarkColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Icon(Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1),
                            ),
                            labelText: "CPF",
                            labelStyle: TextStyle(
                                color: myFocusNode.hasFocus ? ColorsUsed.greenDarkColor : Colors.grey
                            )
                        ),
                      ),
                      suggestionsCallback: (pattern)async{
                        if(pattern != "") suggestions = await AllRepository.getLike("Tutores", "CPF", pattern);
                        if(suggestions == null)suggestions = [];
                        return suggestions;
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion),
                        );
                      },
                      transitionBuilder: (context, suggestionsBox, controller) {
                        return suggestionsBox;
                      },
                      onSuggestionSelected: (suggestion) async{
                        this._typeAheadController.text = suggestion;
                      },
                    ),
                  ),
                ),
              ),
              MyTextField(
                controller: controllerName,
                validate: ValidateUserLogin.validateName,
                parentAction: onSaved,
                title: 'name',
                icon: Icons.person,
                hint: "Nome",
              ),
              MyTextField(
                  controller: controllerMotherName,
                  validate: ValidateUserLogin.validateName,
                  parentAction: onSaved,
                  title: 'motherName',
                  icon: Icons.person,
                  hint: "Nome da mãe",
                ),
              Visibility(
                visible: widget.parentAction == null ? true : false,
                child: MyTextField(
                  controller: controllerCpf,
                  validate: ValidateTutor.validateCpf,
                  parentAction: onSaved,
                  title: 'cpf',
                  icon: Icons.person_pin,
                  hint: "CPF",
                ),
              ),
              MyTextField(
                controller: controllerRg,
                validate: ValidateTutor.validateRg,
                parentAction: onSaved,
                title: 'rg',
                icon: Icons.person_pin,
                hint: "RG",
              ),
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