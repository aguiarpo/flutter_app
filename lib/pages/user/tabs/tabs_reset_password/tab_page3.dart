import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_text_field.dart';

class TabPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
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