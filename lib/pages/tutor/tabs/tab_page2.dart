import 'package:flutter/material.dart';
import 'package:flutter_app/components/inputs/my_text_field_autocomplete.dart';
import 'package:flutter_app/components/inputs/select.dart';
import 'package:flutter_app/components/inputs/my_text_field.dart';
import 'package:flutter_app/validates/validate.dart';

class TabPage2 extends StatefulWidget {
  final jsonBloc;
  final state;
  final city;
  final cep;
  final profession;

  const TabPage2({Key key, this.jsonBloc, this.state, this.city, this.cep, this.profession}) : super(key: key);

  @override
  _TabPage2State createState() => _TabPage2State();
}

class _TabPage2State extends State<TabPage2> with AutomaticKeepAliveClientMixin<TabPage2>{

  var jsonBloc;
  TextEditingController controllerCep = TextEditingController();
  TextEditingController controllerCity = TextEditingController();
  TextEditingController controllerProfession = TextEditingController();
  String state;

  @override
  void initState() {
    super.initState();
    controllerCity.text = widget.city;
    controllerProfession.text = widget.profession;
    controllerCep.text = widget.cep;
    state = widget.state;
    jsonBloc = widget.jsonBloc;
    if(state != null)setSelectValue(state);
  }

  void onSaved(values)  {
    jsonBloc.addValue(values['title'], values['value']);
  }

  void setSelectValue(String value){
    state = value;
    jsonBloc.addValue('state', value);
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
                    title: "Estado",
                    value: state,
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
              MyAutoComplete(
                change: (d){
                  jsonBloc.addValue('city', controllerCity.text);
                },
                parentAction: onSaved,
                state: state,
                typeAheadController: controllerCity,
                title: "city",
                validator: Validate.validateAll,
                regex : r"^([a-zA-Z\u0080-\u024F]+(?:. |-| |'))*[a-zA-Z\u0080-\u024F]*$",
                returnText: 'Caracteres inválidos',
                hint: "Cidade",
                table: "City",
              ),
              MyTextField(
                controller: controllerCep,
                validate: (value) => Validate.validateAll(value,
                    r"^([0-9]{5}-[\d]{3})$",
                    'Caracteres inválidos: 00000-000'),
                icon: Icons.location_city,
                hint: "CEP",
                parentAction: onSaved,
                title: 'cep'
              ),
              MyTextField(
                controller: controllerProfession,
                validate: (value) => Validate.validateAll(value,
                    r"^([a-zA-Z\u0080-\u024F]+(?:. |-| |'))*[a-zA-Z\u0080-\u024F]*$",
                    'Caracteres inválidos'),
                icon: Icons.build,
                hint: "Profissão",
                parentAction: onSaved,
                title: 'profession',
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