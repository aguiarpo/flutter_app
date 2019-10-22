import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_text_field.dart';

class TabPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              MyTextField(
                icon: Icons.person,
                hint: "Nome",
              ),
              MyTextField(
                icon: Icons.person,
                hint: "Nome da mãe",
              ),
              MyTextField(
                icon: Icons.person_pin,
                hint: "CPF",
              ),
              MyTextField(
                icon: Icons.person_pin,
                hint: "RG",
              ),
            ],
          ),
        ),
      ),
    );
  }
}