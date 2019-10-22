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
                icon: Icons.mode_edit,
                hint: "Número",
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: TextField(
                  maxLines: 5,
                  style: new TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    hintText: "Complemento",
                  ),
                ),
              ),
              MyTextField(
                icon: Icons.build,
                hint: "Profissão",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
