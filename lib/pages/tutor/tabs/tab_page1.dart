import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_text_field.dart';

class TabPage1 extends StatefulWidget {
  final jsonBloc;
  final validateName;
  final validateMotherName;
  final validateCpf;
  final validateRG;

  const TabPage1({Key key, this.jsonBloc, this.validateName, this.validateMotherName, this.validateCpf, this.validateRG}) : super(key: key);
  @override
  _TabPage1State createState() => _TabPage1State();
}

class _TabPage1State extends State<TabPage1> with AutomaticKeepAliveClientMixin<TabPage1> {

  var jsonBloc;

  @override
  void initState() {
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
                validate: widget.validateName,
                parentAction: onSaved,
                title: 'name',
                icon: Icons.person,
                hint: "Nome",
              ),
              MyTextField(
                validate: widget.validateMotherName,
                parentAction: onSaved,
                title: 'motherName',
                icon: Icons.person,
                hint: "Nome da mãe",
              ),
              MyTextField(
                validate: widget.validateCpf,
                parentAction: onSaved,
                title: 'cpf',
                icon: Icons.person_pin,
                hint: "CPF",
              ),
              MyTextField(
                validate: widget.validateRG,
                parentAction: onSaved,
                title: 'rg',
                icon: Icons.person_pin,
                hint: "RG",
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