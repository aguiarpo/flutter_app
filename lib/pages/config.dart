import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/colors.dart';

import 'login.dart';

class ConfigPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ColorsUsed.greenDarkColor, //change your color here
        ),
        title: Text("Configurações", style: TextStyle(
            fontFamily: 'Roboto', fontWeight: FontWeight.w400,
            color: ColorsUsed.greenDarkColor,
          ),
        ),
        backgroundColor: ColorsUsed.mainColor,
      ),
      body: Builder(
        builder: (context) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text("Configurações", style: TextStyle(color: ColorsUsed.greenDarkColor, fontSize: 30)),
                  ),
                  Container(
                        margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                        child: Divider(
                          height: 60,
                          color: ColorsUsed.terciaryColor,
                        )
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/editCont');
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10),
                        width: MediaQuery.of(context).size.width - 80,
                        decoration: BoxDecoration(
                          color:  ColorsUsed.terciaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text("Editar Conta", style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                  GestureDetector(
                    onTap: (){
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Tokens apagados com sucesso'),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30),
                      width: MediaQuery.of(context).size.width - 80,
                      decoration: BoxDecoration(
                        color:  ColorsUsed.terciaryColor,
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
                        color:  ColorsUsed.terciaryColor,
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
          );
        }
      ),
    );
  }
}
