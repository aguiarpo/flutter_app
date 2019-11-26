import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:flutter_app/database/connect.dart';
import 'package:flutter_app/icons/surca_icons.dart';
import 'package:flutter_app/models/medications.dart';
import 'package:flutter_app/validates/validator_user_login.dart';

class TabPage1 extends StatelessWidget {
  var jsonBloc;
  final validator;
  TabPage1({@required this.jsonBloc, this.validator});

  void onSaved(values)  {
    jsonBloc.addValue(values['title'], values['value']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyTextField(
              validate: validator,
              parentAction: onSaved,
              title: 'name',
              icon: Surca.vaccine,
              hint: "Nome",
            ),
          ],
        )
    );
  }
}
