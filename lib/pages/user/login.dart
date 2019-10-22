import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_button.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:flutter_app/colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      automaticallyImplyLeading: false,
        title: Text("Registro de animais", style: TextStyle(color: ColorsUsed.greenDarkColor,
          fontFamily: 'Roboto', fontWeight: FontWeight.w400,),),
      backgroundColor: ColorsUsed.mainColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
                child: Column(
                  children: <Widget>[
                    MyTextField(
                      icon: Icons.email,
                      hint: "Email",
                    ),
                    MyTextField(
                      icon: Icons.vpn_key,
                      hint: "Senha",
                    ),
                    Padding(
                      padding: EdgeInsets.only(top : 30, left: 100, right: 100),
                      child: MyButton(
                        text: "Logar",
                        onPress: (){Navigator.pushReplacementNamed(context, "/home");},
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, "/resetPassword1");
                        },
                        child: Text("Esqueceu a senha?", style: TextStyle(
                            color: ColorsUsed.blueDarkColor,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, "/register");
                        },
                        child: Text("Não possui uma conta?", style: TextStyle(
                          color: ColorsUsed.blueDarkColor,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
        ),
      ),
      );
  }
}
