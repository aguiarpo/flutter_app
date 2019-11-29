import 'package:flutter/material.dart';
import 'package:flutter_app/components/autocomplete_textfield.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:flutter_app/database/repository/all_repository.dart';
import 'package:flutter_app/validates/validator_vet.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../colors.dart';

class TabPage7 extends StatefulWidget {
  final jsonBloc;
  final vet;
  final comments;

  const TabPage7({Key key, this.jsonBloc, this.vet, this.comments}) : super(key: key);

  @override
  _TabPage7State createState() => _TabPage7State();
}

class _TabPage7State extends State<TabPage7> with AutomaticKeepAliveClientMixin<TabPage7>{
  DateTime date2;

  var jsonBloc;
  List suggestions;
  TextEditingController controllerVet = TextEditingController();
  TextEditingController controllerComments = TextEditingController();
  TextEditingController _typeAheadController = TextEditingController();
  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode2 = new FocusNode();

  @override
  void initState() {
    controllerComments.text = widget.comments;
    _typeAheadController.text = widget.vet;
    super.initState();
    jsonBloc = widget.jsonBloc;
  }

  void onSaved(values){
    jsonBloc.addValueAnimal(values['title'], values['value']);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TypeAheadFormField(
                  onSaved: (value){
                    Map values = {"title" : "crmv", "value" : value.trim()};
                    onSaved(values);
                  },
                  validator: ValidateVet.validateCRMV,
                  textFieldConfiguration: TextFieldConfiguration(
                    focusNode: myFocusNode,
                      controller: this._typeAheadController,
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
                      hintText: "Crmv",
                      labelText: "Crmv",
                      labelStyle: TextStyle(
                          color: myFocusNode.hasFocus ? ColorsUsed.greenDarkColor : Colors.grey
                      )
                    ),
                  ),
                  suggestionsCallback: (pattern)async{
                    if(pattern != "") suggestions = await AllRepository.getLike("Vet", "Crmv", pattern);
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
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: TextFormField(
                  focusNode: myFocusNode2,
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
                          color: myFocusNode2.hasFocus ? ColorsUsed.greenDarkColor : Colors.grey
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