import 'package:flutter/material.dart';
import 'package:flutter_app/components/inputs/my_text_field.dart';
import 'package:flutter_app/validates/validate.dart';

class TabPage4 extends StatefulWidget {
  final jsonBloc;
  final telephone1;
  final telephone2;
  final number;

  const TabPage4({Key key, this.jsonBloc, this.telephone1, this.telephone2, this.number}) : super(key: key);

  @override
  _TabPage4State createState() => _TabPage4State();
}

class _TabPage4State extends State<TabPage4> with AutomaticKeepAliveClientMixin<TabPage4> {
  var jsonBloc;
  TextEditingController controllerTelephone1= TextEditingController();
  TextEditingController controllerTelephone2= TextEditingController();
  TextEditingController controllerNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
    controllerTelephone1.text = widget.telephone1;
    controllerTelephone2.text = widget.telephone2;
    if(widget.number != "null")controllerNumber.text = widget.number;
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
                controller: controllerNumber,
                type: TextInputType.number,
                validate: (value) => Validate.validateAll(value,
                    r"^([0-9.\-]+)*$", 'Caracteres inválidos'),
                parentAction: onSaved,
                title: 'number',
                icon: Icons.mode_edit,
                hint: "Número",
              ),
              MyTextField(
                controller: controllerTelephone1,
                validate: (value) => Validate.validateAll(value,
                    r'\(\d{2}\)\s\d{4,5}-\d{4}',
                    'Formato do Telefone (47) 9999-0000\nou (47) 99999-0000'),
                icon: Icons.phone,
                hint: "Telefone",
                parentAction: onSaved,
                title: 'telephone1',
              ),
              MyTextField(
                controller: controllerTelephone2,
                validate: (value) => Validate.validateAllWithoutEmpty(value,
                    r'\(\d{2}\)\s\d{4,5}-\d{4}',
                    'Formato do Telefone (47) 9999-0000\nou (47) 99999-0000'),
                icon: Icons.phone,
                hint: "Telefone",
                parentAction: onSaved,
                title: 'telephone2',
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