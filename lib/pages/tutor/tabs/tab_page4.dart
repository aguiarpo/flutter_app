import 'package:flutter/material.dart';
import 'package:flutter_app/components/inputs/my_text_field.dart';
import 'package:flutter_app/validates/validate.dart';

class TabPage4 extends StatefulWidget {
  final jsonBloc;
  final profession;
  final telephone1;
  final telephone2;

  const TabPage4({Key key, this.jsonBloc, this.profession, this.telephone1, this.telephone2}) : super(key: key);

  @override
  _TabPage4State createState() => _TabPage4State();
}

class _TabPage4State extends State<TabPage4> with AutomaticKeepAliveClientMixin<TabPage4> {
  var jsonBloc;
  TextEditingController controllerProfession = TextEditingController();
  TextEditingController controllerTelephone1= TextEditingController();
  TextEditingController controllerTelephone2= TextEditingController();

  @override
  void initState() {
    super.initState();
    controllerProfession.text = widget.profession;
    controllerTelephone1.text = widget.telephone1;
    controllerTelephone2.text = widget.telephone2;
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
                controller: controllerProfession,
                validate: (value) => Validate.validateAll(value,
                    r"^([a-zA-Z\u0080-\u024F]+(?:. |-| |'))*[a-zA-Z\u0080-\u024F]*$",
                    'Caracteres inválidos'),
                icon: Icons.build,
                hint: "Profissão",
                parentAction: onSaved,
                title: 'profession',
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