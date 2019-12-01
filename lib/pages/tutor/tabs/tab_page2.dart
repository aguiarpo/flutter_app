import 'package:flutter/material.dart';
import 'package:flutter_app/components/inputs/select.dart';
import 'package:flutter_app/components/inputs/my_text_field.dart';
import 'package:flutter_app/validates/validate.dart';

class TabPage2 extends StatefulWidget {
  final jsonBloc;
  final neighborhood;
  final state;
  final city;
  final cep;

  const TabPage2({Key key, this.jsonBloc, this.neighborhood, this.state, this.city, this.cep}) : super(key: key);

  @override
  _TabPage2State createState() => _TabPage2State();
}

class _TabPage2State extends State<TabPage2> with AutomaticKeepAliveClientMixin<TabPage2>{

  var jsonBloc;
  TextEditingController controllerCep = TextEditingController();
  TextEditingController controllerCity = TextEditingController();
  TextEditingController controllerNeighborhood = TextEditingController();
  String state;

  @override
  void initState() {
    super.initState();
    controllerCity.text = widget.city;
    controllerCep.text = widget.cep;
    controllerNeighborhood.text = widget.neighborhood;
    state = widget.state;
    jsonBloc = widget.jsonBloc;
    if(state != null)setSelectValue(state);
  }

  void onSaved(values)  {
    jsonBloc.addValue(values['title'], values['value']);
  }

  void setSelectValue(String value){
    jsonBloc.addValue('state', value);
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
                controller: controllerNeighborhood,
                validate: (value) => Validate.validateAll(value,
                    r"^([a-zA-Z\u0080-\u024F]+(?:. |-| |'))*[a-zA-Z\u0080-\u024F]*$",
                    'Caracteres inválidos'),
                icon: Icons.location_city,
                hint: "Bairro",
                parentAction: onSaved,
                title: 'neighborhood'
              ),
              MyTextField(
                controller: controllerCity,
                  validate: (value) => Validate.validateAll(value,
                      r"^([a-zA-Z\u0080-\u024F]+(?:. |-| |'))*[a-zA-Z\u0080-\u024F]*$",
                      'Caracteres inválidos'),
                  icon: Icons.location_city,
                  hint: "Cidade",
                  parentAction: onSaved,
                  title: 'city'
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