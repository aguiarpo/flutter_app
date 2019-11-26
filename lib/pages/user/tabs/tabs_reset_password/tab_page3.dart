import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/email_bloc.dart';
import 'package:flutter_app/components/my_button.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:flutter_app/services/login_request.dart';
import 'package:flutter_app/validates/validator_user_login.dart';

class TabPage3 extends StatefulWidget {
  final EmailBloc bloc;

  const TabPage3({Key key, this.bloc}) : super(key: key);

  @override
  _TabPage3State createState() => _TabPage3State();
}

class _TabPage3State extends State<TabPage3> {
  final GlobalKey<FormState> _formKeyTab3 = GlobalKey<FormState>();
  Map _passwords = {};
  EmailBloc _bloc;
  bool disabledButton = false;

  @override
  void initState(){
    super.initState();
    _bloc = widget.bloc;
  }



  void onSaved(values){
   _passwords[values['title']] = values['value'];
  }

  void formSaved(){
    if(_formKeyTab3.currentState.validate()){
      _formKeyTab3.currentState.save();
      if(_passwords['password'] == _passwords['confirmPassword']){
        request();
      }else{
        errorMessage('Senhas não coincidem');
      }
    }
  }

  void disabledOrEnabledButton(bool value){
    disabledButton = value;
    setState(() {});
  }

  void errorMessage(String text){
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void request() async{
    var response;
    LoginRequest loginRequest = LoginRequest();
    disabledOrEnabledButton(true);
    response = await loginRequest.setPassword(json.encode(_passwords),_bloc.getId.toString(), _bloc.getToken);
    disabledOrEnabledButton(false);
    if(response == null) errorMessage('Erro ao Conectar no Banco de Dados, tente novamente mais tarde');
    else{
      if(response.statusCode == 200){
        Navigator.pop(context, 'Senha atualizada com sucesso');
      }else{
        errorMessage('Erro ao Conectar no Banco de Dados, tente novamente mais tarde');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKeyTab3,
            child: Column(
              children: <Widget>[
                MyTextField(
                  validate: ValidateUserLogin.validatePassword,
                  parentAction: onSaved,
                  title: 'password',
                  icon: Icons.vpn_key,
                  hint: "Senha",
                ),
                MyTextField(
                  parentAction: onSaved,
                  title: 'confirmPassword',
                  icon: Icons.mode_edit,
                  hint: "Confirmar Senha",
                ),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 30),
                  child: MyButton(
                    color: disabledButton ? Colors.black12 : null,
                    text: "Continuar",
                    onPress: disabledButton ? (){} : formSaved,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
