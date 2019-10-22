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
                icon: Icons.email,
                hint: "Email",
              ),
              MyTextField(
                icon: Icons.vpn_key,
                hint: "Senha",
              ),
              MyTextField(
                icon: Icons.mode_edit,
                hint: "Confirmar Senha",
              ),
            ],
          ),
        ),
      ),
    );
  }
}