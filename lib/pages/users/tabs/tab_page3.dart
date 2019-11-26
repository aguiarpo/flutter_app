import 'package:flutter/material.dart';
import 'package:flutter_app/components/dropdown_button.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:flutter_app/validates/validator_user.dart';
import 'package:flutter_app/validates/validator_user_login.dart';

class TabPage3 extends StatefulWidget {
  final jsonBloc;
  final type;

  const TabPage3({Key key, this.jsonBloc, this.type}) : super(key: key);

  @override
  _TabPage3State createState() => _TabPage3State();
}

class _TabPage3State extends State<TabPage3> with AutomaticKeepAliveClientMixin<TabPage3> {
  var jsonBloc;
  Function validateCity;
  Function validateTelephone1;
  Function validateTelephone2;
  var myControllerTelephone1;
  var myControllerTelephone2;

  void onSaved(values)  {
    jsonBloc.addValue(values['title'], values['value']);
  }

  @override
  void initState() {
    super.initState();
    myControllerTelephone1 = TextEditingController();
    myControllerTelephone2 = TextEditingController();
    if(widget.type == 1){
      validateCity = ValidateUserLogin.validateCity;
      validateTelephone1 = ValidateUserLogin.validateTelephone;
      validateTelephone2 = ValidateUserLogin.validateTelephone;
    }else{
      validateCity = ValidateUser.validateCityEdit;
      validateTelephone1 = ValidateUser.validateTelephoneEdit;
      validateTelephone2 = ValidateUser.validateTelephoneEdit;
    }
    jsonBloc = widget.jsonBloc;
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
              Visibility(
                visible: widget.type == 1 && jsonBloc.getSelectValidator,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(bottom: 20, left: 30, top: 5),
                  child: Text("Escolha um estado", style: TextStyle(color: Colors.redAccent, fontSize: 12),),
                ),
              ),
              MyTextField(
                  validate: validateCity,
                  icon: Icons.location_city,
                  hint: "Cidade",
                  parentAction: onSaved,
                  title: 'city'
              ),
              MyTextField(
                  controller: myControllerTelephone1,
                  validate: validateTelephone1,
                  icon: Icons.phone,
                  hint: "Telefone",
                  parentAction: onSaved,
                  title: 'telephone1'
              ),
              MyTextField(
                  controller: myControllerTelephone2,
                  validate: validateTelephone2,
                  icon: Icons.phone,
                  hint: "Telefone",
                  parentAction: onSaved,
                  title: 'telephone2'
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