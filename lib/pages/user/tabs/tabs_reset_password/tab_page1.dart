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
                icon: Icons.email,
                hint: "Email",
              ),
            ],
          ),
        ),
      ),
    );
  }
}