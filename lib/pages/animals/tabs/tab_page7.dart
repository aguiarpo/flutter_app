import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_text_field.dart';

class TabPage7 extends StatefulWidget {
  @override
  _TabPage7State createState() => _TabPage7State();
}

class _TabPage7State extends State<TabPage7> {
  DateTime date2;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              MyTextField(
                icon: Icons.person,
                hint: "Veterinário(Crmv)",
              ),
              MyTextField(
                icon: Icons.person,
                hint: "Castrador(Crmv)",
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
                    hintText: "Observações",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}