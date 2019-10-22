import 'package:flutter/material.dart';
import 'package:flutter_app/colors.dart';
import 'package:flutter_app/components/my_text_field.dart';

class TabPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              MyTextField(
                icon: Icons.code,
                hint: "Código",
              ),
              GestureDetector(
                onTap: (){
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Email enviado, verifique se o email chegou ao seu destino'),
                    ),
                  );
                },
                child: Text("Enviar email novamente", style: TextStyle(
                  color: ColorsUsed.blueDarkColor,
                  fontSize: 15,
                  decoration: TextDecoration.underline,
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