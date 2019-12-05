import 'package:flutter/material.dart';
import 'package:flutter_app/database/repository/all_repository.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AutoComplete extends StatefulWidget {
  final select;
  final title;
  final ValueChanged<String> parentAction;

  const AutoComplete({Key key,this.select, this.title, this.parentAction}) : super(key: key);
  @override
  _AutoCompleteState createState() => _AutoCompleteState();
}

class _AutoCompleteState extends State<AutoComplete> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  List suggestions = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: this._formKey,
      child: TypeAheadFormField(
        textFieldConfiguration: TextFieldConfiguration(
          onSubmitted: (s){
            this._typeAheadController.text = this._typeAheadController.text;
            widget.parentAction(this._typeAheadController.text);
            },
            controller: this._typeAheadController,
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(Icons.search,
                color: Colors.grey,
              ),
              hintText: 'Pesquisar',
            )
        ),
        suggestionsCallback: (pattern)async{
          if(pattern == "")widget.parentAction(pattern);
          else{
            suggestions = await AllRepository.getLike(widget.title, widget.select, pattern);
          }
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
          widget.parentAction(suggestion);
        },
      ),
    );
  }
}
