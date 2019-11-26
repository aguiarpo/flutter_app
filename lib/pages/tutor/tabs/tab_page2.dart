import 'package:flutter/material.dart';
import 'package:flutter_app/components/dropdown_button.dart';
import 'package:flutter_app/components/my_text_field.dart';

class TabPage2 extends StatefulWidget {
  final jsonBloc;
  final validateCep;
  final validateNeighborhood;
  final validateCity;

  const TabPage2({Key key, this.jsonBloc, this.validateCep, this.validateNeighborhood, this.validateCity}) : super(key: key);

  @override
  _TabPage2State createState() => _TabPage2State();
}

class _TabPage2State extends State<TabPage2> with AutomaticKeepAliveClientMixin<TabPage2>{

  var jsonBloc;
  var myControllerTelephone1;
  var myControllerTelephone2;

  @override
  void initState() {
    super.initState();
    myControllerTelephone1 = TextEditingController();
    myControllerTelephone2 = TextEditingController();
    jsonBloc = widget.jsonBloc;
  }

  void onSaved(values)  {
    jsonBloc.addValue(values['title'], values['value']);
  }

  void setSelectValue(String value){
    if(jsonBloc.getSelectValidator) jsonBloc.updateSelect(false);
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
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: Select(
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
                validate: widget.validateCep,
                icon: Icons.location_city,
                hint: "CEP",
                parentAction: onSaved,
                title: 'cep'
              ),
              MyTextField(
                validate: widget.validateNeighborhood,
                icon: Icons.location_city,
                hint: "Bairro",
                parentAction: onSaved,
                title: 'neighborhood'
              ),
              MyTextField(
                  validate: widget.validateCity,
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