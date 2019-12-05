import 'package:flutter/material.dart';
import 'package:flutter_app/colors.dart';
import 'package:flutter_app/components/buttons/my_config_button.dart';

class ConfigPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ConfigPageState();
  }
}

class _ConfigPageState extends State<ConfigPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                    MyConfigButton(
                      scaffoldKey: _scaffoldKey,
                      text: "Editar Conta",
                      navigation: '/editCont',
                    ),
                    MyConfigButton(
                      scaffoldKey: _scaffoldKey,
                      text: "Atualizar o Banco de Dados",
                      navigation: '/',
                    ),
                    MyConfigButton(
                      scaffoldKey: _scaffoldKey,
                      text: "Sair",
                      navigation: '/login',
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
