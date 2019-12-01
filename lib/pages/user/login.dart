import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/buttons/my_button.dart';
import 'package:flutter_app/components/inputs/my_text_field.dart';
import 'package:flutter_app/colors.dart';
import 'package:flutter_app/components/others/show_message_snackbar.dart';
import 'package:flutter_app/components/others/timer.dart';
import 'package:flutter_app/database/repository/user_login_repository.dart';
import 'package:flutter_app/models/user_login.dart';
import 'package:flutter_app/services/client.dart';
import 'package:flutter_app/services/request/user_request.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();
  bool disabledButton = false;
  Map dataRequest = {};
  var disabledReset = false;

  _getPage(navigator) async{
    var response;
    response = await navigator;
    MySnackBar.message(response, scaffoldKey: _scaffoldKey);
  }

  void onSaved(values){
     dataRequest[values['title']] = values['value'];
  }

  void disabledOrEnabledButton(bool value){
    disabledButton = value;
    setState(() {});
  }

  void formSaved(){
    _formKeyLogin.currentState.save();
    request();
  }

  void request() async{
    var response;

    UserRequest user = UserRequest();
    user.setClient(dataRequest['email'], dataRequest['password']);

    try{
      disabledOrEnabledButton(true);
      response = await user.getLogin();
      disabledOrEnabledButton(false);
      if(response == null){
        MySnackBar.message('Erro ao Logar', scaffoldKey: _scaffoldKey);
      }else{
        switch(response.statusCode){
          case 200:
            await saveUser(response);
            Navigator.pushReplacementNamed(context, "/");
            break;
          default:
            MySnackBar.message('Email ou senha inválida',scaffoldKey: _scaffoldKey);
            break;
        }
      }
    }catch(exception){
      UserAgentClient.client.close();
      disabledOrEnabledButton(false);
      MySnackBar.message('Erro',scaffoldKey: _scaffoldKey);
    }
  }

  Future saveUser(response) async {
    try{
      var body;
      body = json.decode(response.body);
      UserLogin user = UserLogin();
      user.setValues(body);
      user.password = dataRequest['password'];
      await UserLoginRepository.truncateContacts();
      var saved = await UserLoginRepository.saveContact(user);
      if(saved != null)
        Navigator.pushReplacementNamed(context, "/home");
      else
        MySnackBar.message('Erro', scaffoldKey: _scaffoldKey);
    }catch (e){
      MySnackBar.message('Erro', scaffoldKey: _scaffoldKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
            child: Form(
              key: _formKeyLogin,
              child: Column(
                children: <Widget>[
                  MyTextField(
                    parentAction: onSaved,
                    title: 'email',
                    icon: Icons.email,
                    hint: "Email",
                  ),
                  MyTextField(
                    obscureText: true,
                    parentAction: onSaved,
                    title: 'password',
                    icon: Icons.vpn_key,
                    hint: "Senha",
                  ),
                  Padding(
                      padding: EdgeInsets.only(top : 30, left: 100, right: 100),
                      child: MyButton(
                        text: "Logar",
                        color: disabledButton ? Colors.black12 : null,
                        onPress: disabledButton ? (){} : formSaved,
                      )
                  ),
                  Visibility(
                    visible: !disabledReset,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: GestureDetector(
                        onTap: ()async {
                          disabledReset = true;
                          await _getPage(Navigator.pushNamed(context, "/resetPassword1"));
                          Timer(new Duration(minutes: 5), () {
                            disabledReset = false;
                            setState(() {});
                          });
                        },
                        child: Text("Esqueceu a senha?", style: TextStyle(
                          color: ColorsUsed.blueDarkColor,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: disabledReset,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: MyTimer(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: GestureDetector(
                      onTap: () =>_getPage(Navigator.pushNamed(context, "/register")),
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
      ),
    );
  }
}

