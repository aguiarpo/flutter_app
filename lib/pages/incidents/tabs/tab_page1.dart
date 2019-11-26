import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:flutter_app/icons/surca_icons.dart';

class TabPage1 extends StatefulWidget {
  var jsonBloc;
  final validator;
  TabPage1({@required this.jsonBloc, this.validator});

  @override
  _TabPage1State createState() => _TabPage1State();
}

class _TabPage1State extends State<TabPage1> {
  var jsonBloc;

  void onSaved(values)  {
    jsonBloc.addValue(values['title'], values['value']);
  }


  @override
  void initState() {
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
              validate: widget.validator,
              parentAction: onSaved,
              title: 'name',
              icon: Surca.alert,
              hint: "Nome",
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: TextFormField(
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
                  hintText: "Observações",
                ),
              ),
            ),
          ],
        )
    );
  }
}
