import 'package:flutter/material.dart';
import 'package:flutter_app/components/inputs/my_text_field.dart';
import 'package:flutter_app/components/inputs/textarea.dart';
import 'package:flutter_app/icons/surca_icons.dart';
import 'package:flutter_app/validates/validate.dart';

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
              validate: (value) => Validate.validateAll(value,
                  r"^([a-zA-Z\u0080-\u024F]+(?:. |-| |'))*[a-zA-Z\u0080-\u024F]*$",
                  'Caracteres inválidos'),
              parentAction: onSaved,
              title: 'name',
              icon: Surca.alert,
              hint: "Nome",
            ),
            TextArea(
              onSaved: onSaved,
              controllerComments: controllerComments,
              labelText: "Observações",
              title: "comments",
            )
          ],
        )
    );
  }
}
