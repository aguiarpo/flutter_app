import 'package:flutter/material.dart';
import 'package:flutter_app/database/repository/all_repository.dart';
import 'package:flutter_app/validates/validate.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../colors.dart';

class MyAutoComplete extends StatefulWidget {
  final ValueChanged parentAction;
  final typeAheadController;
  final String title;
  final regex;
  final returnText;
  final hint;
  final table;
  final focusNode;
  final Function validator;

  const MyAutoComplete({Key key, this.parentAction, this.typeAheadController, this.title, this.regex, this.returnText, this.hint, this.table, this.focusNode, this.validator}) : super(key: key);
  @override
  _MyAutoCompleteState createState() => _MyAutoCompleteState();
}

class _MyAutoCompleteState extends State<MyAutoComplete> {
  List suggestions;
  FocusNode myFocusNode;
  var _typeAheadController;


  @override
  void initState() {
    _typeAheadController = widget.typeAheadController;
    if(widget.focusNode == null) myFocusNode = new FocusNode();
    else myFocusNode = widget.focusNode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20, top: 5),
      child: TypeAheadFormField(
        onSaved: (value){
          Map values = {"title" : widget.title, "value" : value.trim()};
          widget.parentAction(values);
        },
        validator: (value) => widget.validator(value,
            widget.regex, widget.returnText),
        textFieldConfiguration: TextFieldConfiguration(
          focusNode: myFocusNode,
          controller: _typeAheadController,
          style: new TextStyle(color: Colors.grey),
          decoration: InputDecoration(
              prefixIcon: Container(
                margin: EdgeInsets.only(right: 20),
                padding: EdgeInsets.all(19),
                decoration: BoxDecoration(
                  color: ColorsUsed.greenDarkColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(Icons.person,
                  color: Colors.white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              labelText: widget.hint,
              labelStyle: TextStyle(
                  color: myFocusNode.hasFocus ? ColorsUsed.greenDarkColor : Colors.grey
              )
          ),
        ),
        suggestionsCallback: (pattern)async{
          if(pattern != "") suggestions = await AllRepository.getLike(widget.table, widget.hint, pattern);
          if(suggestions == null)suggestions = [];
          return suggestions;
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion),
          );
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        onSuggestionSelected: (suggestion) {
          this._typeAheadController.text = suggestion;
        },
      ),
    );
  }
}