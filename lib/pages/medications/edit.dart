import 'package:flutter/material.dart';
import 'package:flutter_app/components/style_text_field.dart';
import 'package:flutter_app/icons/surca_icons.dart';
import 'package:flutter_app/colors.dart';

class EditMedications extends StatefulWidget {
  @override
  _EditMedicationsState createState() => _EditMedicationsState();
}

class _EditMedicationsState extends State<EditMedications> {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(

                margin: EdgeInsets.only(bottom: 5),
                child: Text("Medicação", style: TextStyle(fontSize: 20, color: ColorsUsed.secundaryColor),),
              ),
              MyTextField(
                icon: Surca.vaccine,
                hint: "Nome",
              )
            ],
          )
      ),
    );
  }
}
