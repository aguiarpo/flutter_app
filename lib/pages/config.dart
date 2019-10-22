import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/colors.dart';

import 'user/login.dart';

class ConfigPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ConfigPageState();
  }
}

class _ConfigPageState extends State<ConfigPage> {

  @override
  void initState(){
    super.initState();
  }

  // ignore: non_constant_identifier_names
  Widget MyContainer(text, navigation){
    return GestureDetector(
      onTap: (){
        if(text == "Sair"){
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginPage()
              ),
              ModalRoute.withName("/login")
          );
        } else Navigator.pushNamed(context, navigation);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10, bottom: 20),
        width: MediaQuery.of(context).size.width - 80,
        decoration: BoxDecoration(
          color:  ColorsUsed.terciaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(text, style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }

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
                        margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 20, bottom: 20),
                        color: ColorsUsed.terciaryColor,
                        height: 1,
                    ),
                    MyContainer("Editar Conta", '/editCont'),
                    MyContainer("Sair", '/login'),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
