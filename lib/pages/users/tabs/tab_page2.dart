import 'package:flutter/material.dart';
import 'package:flutter_app/components/dropdown_button.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:flutter_app/validates/validator_vet.dart';

class TabPage2 extends StatefulWidget {
  final jsonBloc;
  final level;

  const TabPage2({Key key, this.jsonBloc, this.level}) : super(key: key);
  @override
  _TabPage2State createState() => _TabPage2State();
}

class _TabPage2State extends State<TabPage2>  with AutomaticKeepAliveClientMixin<TabPage2>{
  var jsonBloc;
  var level;
  var initialLevel;
  var valueSelect;

  void onSaved(values)  {
    jsonBloc.addValue(values['title'], values['value']);
  }

  @override
  void initState() {
    jsonBloc = widget.jsonBloc;
    if(widget.level == null){
      _changeSelect('USUARIO');
    }else{
      level = widget.level;
      initialLevel = level;
      _changeSelect(level);
    }
    super.initState();
  }

  void _changeSelect(String value){
    switch(value){
      case "Usuário":
      case "USUARIO":
        valueSelect = "Usuário";
        level = "USUARIO";
        break;
      case "Veterinário":
      case "VETERINARIO":
        valueSelect = "Veterinário";
        level = "VETERINARIO";
        break;
      case "Administrador":
      case "ADMIN":
        valueSelect = "Administrador";
        level = "ADMIN";
        break;
    }
    jsonBloc.addValue('levelsOfAccess', level);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: Select(
                    parentAction: _changeSelect,
                    title: "Tipo de Acesso",
                    value: valueSelect,
                    list: [ "Usuário", "Veterinário", "Administrador"],
                    padding: EdgeInsets.only(left: 10, right: 10),
                    border: BoxDecoration(
                      border: Border.all(color: Colors.grey,),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: level == "VETERINARIO",
                child: MyTextField(
                  validate:(value){
                    return ValidateVet.validateCRMV(value, level, initialLevel);
                  },
                  parentAction: onSaved,
                  title: 'crmv',
                  icon: Icons.person_pin,
                  hint: "Crmv",
                ),
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