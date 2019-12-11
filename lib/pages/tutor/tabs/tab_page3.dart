import 'package:flutter/material.dart';
import 'package:flutter_app/components/inputs/my_text_field.dart';
import 'package:flutter_app/components/inputs/my_text_field_autocomplete.dart';
import 'package:flutter_app/components/inputs/textarea.dart';
import 'package:flutter_app/validates/validate.dart';

class TabPage3 extends StatefulWidget {
  final jsonBloc;
  final street;
  final complements;
  final neighborhood;

  const TabPage3({Key key, this.jsonBloc, this.street, this.complements, this.neighborhood}) : super(key: key);

  @override
  _TabPage3State createState() => _TabPage3State();
}

class _TabPage3State extends State<TabPage3> with AutomaticKeepAliveClientMixin<TabPage3> {

  var jsonBloc;
  TextEditingController controllerStreet = TextEditingController();
  TextEditingController controllerComplements = TextEditingController();
  TextEditingController controllerNeighborhood = TextEditingController();
  FocusNode myFocusNode = new FocusNode();

  @override
  void initState() {
    controllerComplements.text = widget.complements;
    controllerStreet.text = widget.street;
    controllerNeighborhood.text = widget.neighborhood;
    super.initState();
    jsonBloc = widget.jsonBloc;
  }

  void onSaved(values)  {
    jsonBloc.addValue(values['title'], values['value']);
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
                state: jsonBloc.getValue['state'],
                city: jsonBloc.getValue['city'],
                typeAheadController: controllerNeighborhood,
                title: "neighborhood",
                validator: Validate.validateAll,
                regex : r"^([a-zA-Z\u0080-\u024F]+(?:. |-| |'))*[a-zA-Z\u0080-\u024F]*$",
                returnText: 'Caracteres inválidos',
                hint: "Bairro",
                table: "Neighborhood",
              ),
              MyTextField(
                  controller: controllerStreet,
                  validate: (value) => Validate.validateAll(value,
                      r"^([a-zA-Z\u0080-\u024F]+(?:. |-| |'))*[a-zA-Z\u0080-\u024F]*$",
                      'Caracteres inválidos'),
                  icon: Icons.location_city,
                  hint: "Rua",
                  parentAction: onSaved,
                  title: 'street'
              ),
              TextArea(
                onSaved: onSaved,
                controllerComments: controllerComplements,
                labelText: "Complemento",
                title: "complement",
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