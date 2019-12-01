import 'package:flutter/material.dart';
import 'package:flutter_app/components/inputs/my_text_field_autocomplete.dart';
import 'package:flutter_app/components/inputs/textarea.dart';
import 'package:flutter_app/validates/validate.dart';

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
  TextEditingController controllerVet = TextEditingController();
  TextEditingController controllerComments = TextEditingController();
  TextEditingController _typeAheadController = TextEditingController();
  FocusNode myFocusNode2 = new FocusNode();

  @override
  void initState() {
    super.initState();
    if(widget.comments != null)controllerComments.text = widget.comments;
    if(widget.vet != null)_typeAheadController.text = widget.vet;
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
              MyAutoComplete(
                parentAction: onSaved,
                typeAheadController: _typeAheadController,
                title: "crmv",
                validator: Validate.validateAllWithoutEmpty,
                regex : r"^[0-9]*$",
                returnText: 'Caracteres inválidos',
                hint: "Crmv",
                table: "Vet",
              ),
              TextArea(
                onSaved: onSaved,
                controllerComments: controllerComments,
                labelText: "Observações do animal",
                title: "comments",
              )
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