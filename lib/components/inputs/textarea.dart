import 'package:flutter/material.dart';
import 'package:flutter_app/validates/validate.dart';

import '../../colors.dart';

class TextArea extends StatelessWidget {
  var controllerComments;
  FocusNode myFocusNode = new FocusNode();
  ValueChanged onSaved;
  String labelText;
  String title;

  TextArea({Key key, this.controllerComments, this.title, this.labelText, this.onSaved}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      child: TextFormField(
        focusNode: myFocusNode,
        validator: Validate.validateComments,
        controller: controllerComments,
        onSaved: (value){
          Map values = {"title" : title, "value" : value.trim()};
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
            labelText: labelText,
            labelStyle: TextStyle(
                color: myFocusNode.hasFocus ? ColorsUsed.greenDarkColor : Colors.grey
            )
        ),
      ),
    );
  }
}
