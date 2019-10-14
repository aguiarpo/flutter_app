import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_button.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:flutter_app/icons/surca_icons.dart';

import '../../colors.dart';

class RegisterIncidents extends StatefulWidget {
  @override
  _RegisterIncidentsState createState() => _RegisterIncidentsState();
}

class _RegisterIncidentsState extends State<RegisterIncidents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ColorsUsed.greenDarkColor, //change your color here
        ),
        title: Text("Editar", style: TextStyle(
          fontFamily: 'Roboto', fontWeight: FontWeight.w400,
          color: ColorsUsed.greenDarkColor,
        ),
        ),
        backgroundColor: ColorsUsed.mainColor,
      ),
      body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MyTextField(
                icon: Surca.incident,
                hint: "Nome",
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
              Padding(
                padding: EdgeInsets.only(top : 30, left: 100, right: 100),
                child: MyButton(
                  text: "Cadastrar",
                  onPress: (){Navigator.pop(context);},
                ),
              )
            ],
          )
      ),
    );
  }
}
