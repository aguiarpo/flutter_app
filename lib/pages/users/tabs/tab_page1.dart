import 'package:flutter/material.dart';
import 'package:flutter_app/components/dropdown_button.dart';
import 'package:flutter_app/components/my_text_field.dart';

class TabPage1 extends StatefulWidget {
  @override
  _TabPage1State createState() => _TabPage1State();
}

class _TabPage1State extends State<TabPage1> {
  String _valueSelect;

  @override
  void initState() {
    super.initState();
    _valueSelect = "Usuário";
  }

  void _changeSelect(String value){
    setState(() {
      _valueSelect = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: Select(
                    parentAction: _changeSelect,
                    list: [ "Usuário", "Veterinário", "Administrador"],
                    padding: EdgeInsets.only(left: 10, right: 10),
                    border: BoxDecoration(
                      border: Border.all(color: Colors.grey,),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              MyTextField(
                icon: Icons.person,
                hint: "Nome",
              ),
              MyTextField(
                icon: Icons.email,
                hint: "Email",
              ),
              Visibility(
                visible: _valueSelect == "Veterinário",
                child: MyTextField(
                  icon: Icons.person_pin,
                  hint: "Crmv",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}