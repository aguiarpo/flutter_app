import 'package:flutter/material.dart';
import 'package:flutter_app/components/inputs/my_text_field.dart';
import 'package:flutter_app/components/inputs/my_text_field_autocomplete.dart';
import 'package:flutter_app/database/repository/tutor_repository.dart';
import 'package:flutter_app/models/tutor.dart';
import 'package:flutter_app/validates/validate.dart';

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
    initConfigure();
    super.initState();
  }

  void initConfigure(){
    controllerName.text = widget.name;
    controllerMotherName.text = widget.motherName;
    controllerCpf.text = widget.cpf;
    _typeAheadController.text = widget.cpf;
    controllerRg.text = widget.rg;
    jsonBloc = widget.jsonBloc;
    addEventListener();
  }

  void addEventListener(){
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
                child: MyAutoComplete(
                  focusNode: myFocusNode,
                  parentAction: onSaved,
                  typeAheadController: _typeAheadController,
                  title: "cpf",
                  validator: Validate.validateAll,
                  regex : r"^([0-9]{2}[\.][0-9]{3}[\.][0-9]{3}[\/][0-9]{4}[-][0-9]{2})|([0-9]{3}[\.][0-9]{3}[\.][0-9]{3}[-][0-9]{2})$",
                  returnText: 'Formato invalído (123.123.123-12)',
                  hint: "Cpf",
                  table: "Tutores",
                ),
              ),
              MyTextField(
                controller: controllerName,
                validate: (value) => Validate.validateAll(value,
                    r"^(([A-Za-z]+[\-\']?)*([A-Za-z]+)?\s)+([A-Za-z]+[\-\']?)*([A-Za-z]+)?$",
                    'Caracteres inválidos'),
                parentAction: onSaved,
                title: 'name',
                icon: Icons.person,
                hint: "Nome do Tutor",
              ),
              MyTextField(
                  controller: controllerMotherName,
                  validate: (value) => Validate.validateAll(value,
                      r"^(([A-Za-z]+[\-\']?)*([A-Za-z]+)?\s)+([A-Za-z]+[\-\']?)*([A-Za-z]+)?$",
                      'Caracteres inválidos'),
                  parentAction: onSaved,
                  title: 'motherName',
                  icon: Icons.person,
                  hint: "Nome da mãe",
                ),
              Visibility(
                visible: widget.parentAction == null ? true : false,
                child: MyTextField(
                  controller: controllerCpf,
                  validate: (value) => Validate.validateAll(value,
                      r"^([0-9]{2}[\.][0-9]{3}[\.][0-9]{3}[\/][0-9]{4}[-][0-9]{2})|([0-9]{3}[\.][0-9]{3}[\.][0-9]{3}[-][0-9]{2})$",
                      'Formato invalído (123.123.123-12)'),
                  parentAction: onSaved,
                  title: 'cpf',
                  icon: Icons.person_pin,
                  hint: "CPF",
                ),
              ),
              MyTextField(
                controller: controllerRg,
                validate: (value) => Validate.validateAll(value,
                    r"^([0-9.\-]+)*$", 'Caracteres inválidos'),
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