import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:flutter_app/validates/validator_user_login.dart';

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
                validate: ValidateUserLogin.validateCity,
                icon: Icons.build,
                hint: "Profissão",
                parentAction: onSaved,
                title: 'profession',
              ),
              MyTextField(
                controller: controllerTelephone1,
                validate: ValidateUserLogin.validateTelephone,
                icon: Icons.phone,
                hint: "Telefone",
                parentAction: onSaved,
                title: 'telephone1',
              ),
              MyTextField(
                controller: controllerTelephone2,
                validate: ValidateUserLogin.validateTelephone2,
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