import 'package:flutter/material.dart';
import 'package:flutter_app/components/inputs/my_text_field.dart';
import 'package:flutter_app/icons/surca_icons.dart';
import 'package:flutter_app/validates/validate.dart';

class TabPage1 extends StatelessWidget {
  var jsonBloc;
  final name;
  TextEditingController myControllerName = TextEditingController();
  TabPage1({@required this.jsonBloc, this.name});

  void onSaved(values)  {
    jsonBloc.addValue(values['title'], values['value']);
  }

  @override
  Widget build(BuildContext context) {
    myControllerName.text = name;
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyTextField(
              controller: myControllerName,
              validate: (value) => Validate.validateAll(value,
                  r"^([a-zA-Z\u0080-\u024F]+(?:. |-| |'))*[a-zA-Z\u0080-\u024F]*$",
                  'Caracteres inválidos'),
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
