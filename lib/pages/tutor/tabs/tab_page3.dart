import 'package:flutter/material.dart';
import 'package:flutter_app/components/inputs/my_text_field.dart';
import 'package:flutter_app/components/inputs/textarea.dart';
import 'package:flutter_app/validates/validate.dart';

class TabPage3 extends StatefulWidget {
  final jsonBloc;
  final street;
  final number;
  final complements;

  const TabPage3({Key key, this.jsonBloc, this.street, this.number, this.complements}) : super(key: key);

  @override
  _TabPage3State createState() => _TabPage3State();
}

class _TabPage3State extends State<TabPage3> with AutomaticKeepAliveClientMixin<TabPage3> {

  var jsonBloc;
  TextEditingController controllerNumber = TextEditingController();
  TextEditingController controllerStreet = TextEditingController();
  TextEditingController controllerComplements = TextEditingController();
  FocusNode myFocusNode = new FocusNode();

  @override
  void initState() {
    controllerComplements.text = widget.complements;
    if(widget.number != "null")controllerNumber.text = widget.number;
    controllerStreet.text = widget.street;
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
              MyTextField(
                controller: controllerNumber,
                type: TextInputType.number,
                validate: (value) => Validate.validateAll(value,
                    r"^([0-9.\-]+)*$", 'Caracteres inválidos'),
                parentAction: onSaved,
                title: 'number',
                icon: Icons.mode_edit,
                hint: "Número",
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