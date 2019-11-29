import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:flutter_app/validates/validator_tutor.dart';
import 'package:flutter_app/validates/validator_user_login.dart';

import '../../../colors.dart';

class TabPage3 extends StatefulWidget {
  final jsonBloc;
  final street;
  final number;
  final complements;

  const TabPage3({Key key, this.jsonBloc, this.street, this.number, this.complements}) : super(key: key);

  @override
  _TabPage3State createState() => _TabPage3State();
}

class _TabPage3State extends State<TabPage3> with AutomaticKeepAliveClientMixin<TabPage3> {

  var jsonBloc;
  TextEditingController controllerNumber = TextEditingController();
  TextEditingController controllerStreet = TextEditingController();
  TextEditingController controllerComplements = TextEditingController();
  FocusNode myFocusNode = new FocusNode();

  @override
  void initState() {
    controllerComplements.text = widget.complements;
    if(widget.number != "null")controllerNumber.text = widget.number;
    controllerStreet.text = widget.street;
    super.initState();
    jsonBloc = widget.jsonBloc;
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
              MyTextField(
                  controller: controllerStreet,
                  validate: ValidateUserLogin.validateCity,
                  icon: Icons.location_city,
                  hint: "Rua",
                  parentAction: onSaved,
                  title: 'street'
              ),
              MyTextField(
                controller: controllerNumber,
                type: TextInputType.number,
                validate: ValidateTutor.validateRg,
                parentAction: onSaved,
                title: 'number',
                icon: Icons.mode_edit,
                hint: "Número",
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: TextFormField(
                  validator: ValidateUserLogin.validateComments,
                  controller: controllerComplements,
                  focusNode: myFocusNode,
                  onSaved: (value){
                    Map values = {"title" : "complement", "value" : value.trim()};
                    onSaved(values);
                  },
                  maxLines: 5,
                  style: new TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    labelText: "Complemento",
                      labelStyle: TextStyle(
                          color: myFocusNode.hasFocus ? ColorsUsed.greenDarkColor : Colors.grey
                      )
                  ),
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