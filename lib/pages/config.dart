import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

Color mainColor = Color(0xff8CFFBA);
const color = Color(0xff1A773F);
const color2 = Color(0xff4F816D);

class ConfigPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: color, //change your color here
        ),
        title: Text("Configurações", style: TextStyle(
            fontFamily: 'Roboto', fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
        backgroundColor: mainColor,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text("Configurações", style: TextStyle(color: color, fontSize: 30)),
              ),
              Container(
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                    child: Divider(
                      height: 60,
                      color: color2,
                    )
                ),
                GestureDetector(
                  onTap: (){},
                  child: Container(
                    margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10),
                    width: MediaQuery.of(context).size.width - 80,
                    decoration: BoxDecoration(
                      color: color2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text("Editar Conta", style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              GestureDetector(
                onTap: (){},
                child: Container(
                  margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30),
                  width: MediaQuery.of(context).size.width - 80,
                  decoration: BoxDecoration(
                    color: color2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text("Apagar Tokens", style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage()
                      ),
                      ModalRoute.withName("/")
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30),
                  width: MediaQuery.of(context).size.width - 80,
                  decoration: BoxDecoration(
                    color: color2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text("Sair", style: TextStyle(color: Colors.white),),
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
