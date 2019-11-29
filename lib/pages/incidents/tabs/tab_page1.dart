import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:flutter_app/icons/surca_icons.dart';
import 'package:flutter_app/validates/validator_incidents.dart';
import 'package:flutter_app/validates/validator_user_login.dart';

import '../../../colors.dart';

class TabPage1 extends StatefulWidget {
  var jsonBloc;
  final name;
  final comments;

  TabPage1({@required this.jsonBloc, this.name, this.comments});

  @override
  _TabPage1State createState() => _TabPage1State();
}

class _TabPage1State extends State<TabPage1> {
  var jsonBloc;
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerComments = TextEditingController();
  FocusNode myFocusNode = new FocusNode();

  void onSaved(values)  {
    jsonBloc.addValue(values['title'], values['value']);
  }


  @override
  void initState() {
    controllerName.text = widget.name;
    controllerComments.text = widget.comments;
    jsonBloc = widget.jsonBloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyTextField(
              controller: controllerName,
              validate: (value) => ValidateIncidents.validateName(value),
              parentAction: onSaved,
              title: 'name',
              icon: Surca.alert,
              hint: "Nome",
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: TextFormField(
                focusNode: myFocusNode,
                validator: ValidateUserLogin.validateComments,
                controller: controllerComments,
                onSaved: (value){
                  Map values = {"title" : "comments", "value" : value.trim()};
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
                  labelText: "Observações",
                    labelStyle: TextStyle(
                        color: myFocusNode.hasFocus ? ColorsUsed.greenDarkColor : Colors.grey
                    )
                ),
              ),
            ),
          ],
        )
    );
  }
}
