import 'package:flutter/material.dart';

const mainColor = Color(0xff8CFFBA);
const color = Color(0xff1A773F);

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
        title: Text("Surca", style: TextStyle(color: Color(0xff1A773F),
        fontFamily: 'Roboto', fontWeight: FontWeight.w400,),),
      backgroundColor: mainColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                      child: TextField(
                        style: new TextStyle(color: Colors.grey),
                        decoration: InputDecoration(
                          prefixIcon: Container(
                            margin: EdgeInsets.only(right: 20),
                            padding: EdgeInsets.all(19),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(Icons.email,
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1),
                          ),
                            hintText: 'Email',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: TextField(
                        style: new TextStyle(color: Colors.grey),
                        decoration: InputDecoration(
                          prefixIcon: Container(
                            margin: EdgeInsets.only(right: 20),
                            padding: EdgeInsets.all(19),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(Icons.vpn_key,
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1),
                          ),
                          hintText: 'Senha',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top : 30, left: 100, right: 100),
                      child: MaterialButton(
                        minWidth: 100,
                        height: 45,
                        color: Color(0xff179CBF),
                        child: Center(
                          child: Text('Login'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        onPressed: (){Navigator.pushReplacementNamed(context, "/home");},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, "/resetPassword1");
                        },
                        child: Text("Esqueceu a senha?", style: TextStyle(
                            color: Color(0xff2C1871),
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
                          color: Color(0xff2C1871),
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
