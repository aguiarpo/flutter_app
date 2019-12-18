import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/json_bloc.dart';
import 'package:flutter_app/components/inputs/select.dart';
import 'package:flutter_app/components/inputs/my_text_field.dart';
import 'package:flutter_app/validates/validate.dart';

class TabPage2 extends StatefulWidget {
  final JsonBloc jsonBloc;
  var controllerState;
  var controllerCity;
  var controllerTelephone1;
  var controllerTelephone2;

  TabPage2({@required this.jsonBloc, this.controllerState, this.controllerCity, this.controllerTelephone1, this.controllerTelephone2});

  @override
  _TabPage2State createState() => _TabPage2State();
}

class _TabPage2State extends State<TabPage2> with AutomaticKeepAliveClientMixin<TabPage2> {
  JsonBloc jsonBloc;
  var myControllerTelephone1;
  var myControllerTelephone2;
  String controllerState;

  @override
  void initState() {
    super.initState();
    if(widget.controllerTelephone1 == null){
      myControllerTelephone1 = TextEditingController();
    }else{
      myControllerTelephone1 = widget.controllerTelephone1;
    }
    if(widget.controllerTelephone2 == null){
      myControllerTelephone2 = TextEditingController();
    }else{
      myControllerTelephone2 = widget.controllerTelephone2;
    }
    jsonBloc = widget.jsonBloc;
    if(widget.controllerState != null){
      controllerState = widget.controllerState;
    }else{
      controllerState = "SC";
    }
    setSelectValue(controllerState);
  }

  void onSaved(values){
    jsonBloc.addValue(values['title'], values['value']);
  }

  void setSelectValue(String value){
    jsonBloc.addValue('state', value);
    if(value == "SC" && myControllerTelephone1.text == "" && myControllerTelephone2.text == ""){
      myControllerTelephone1.text = '(47) ';
      myControllerTelephone2.text = '(47) ';
    }
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
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Select(
                    value: controllerState,
                    title: "Estado",
                    parentAction: setSelectValue,
                    list: [ "AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA",
                      "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ",
                      "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO",
                    ],
                    padding: EdgeInsets.only(left: 10, right: 10),
                    border: BoxDecoration(
                      border: Border.all(color: Colors.grey,),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              MyTextField(
                controller: widget.controllerCity,
                validate: (value) => Validate.validateAll(value,
                    r"^([a-zA-Z\u0080-\u024F]+(?:. |-| |'))*[a-zA-Z\u0080-\u024F]*$",
                    'Caracteres inválidos'),
                parentAction: onSaved,
                title: "city",
                icon: Icons.location_city,
                hint: "Cidade",
              ),
              MyTextField(
                controller: myControllerTelephone1,
                validate: (value) => Validate.validateAll(value,
                    r'\(\d{2}\)\s\d{4,5}-\d{4}',
                    'Formato do Telefone (47) 9999-0000\nou (47) 99999-0000'),
                parentAction: onSaved,
                title: "telephone1",
                icon: Icons.phone,
                hint: "Telefone",
              ),
              MyTextField(
                controller: myControllerTelephone2,
                validate: (value) => Validate.validateAllWithoutEmpty(value,
                    r'\(\d{2}\)\s\d{4,5}-\d{4}',
                    'Formato do Telefone (47) 9999-0000\nou (47) 99999-0000'),
                parentAction: onSaved,
                title: "telephone2",
                icon: Icons.phone,
                hint: "Telefone",
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
