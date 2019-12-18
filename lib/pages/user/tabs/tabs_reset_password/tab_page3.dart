import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/user_bloc.dart';
import 'package:flutter_app/components/buttons/my_button.dart';
import 'package:flutter_app/components/inputs/my_text_field.dart';
import 'package:flutter_app/components/others/show_message_snackbar.dart';
import 'package:flutter_app/services/client.dart';
import 'package:flutter_app/services/request/user_request.dart';
import 'package:flutter_app/validates/validate.dart';

class TabPage3 extends StatefulWidget {
  final UserBloc bloc;

  const TabPage3({Key key, this.bloc}) : super(key: key);

  @override
  _TabPage3State createState() => _TabPage3State();
}

class _TabPage3State extends State<TabPage3> {
  final GlobalKey<FormState> _formKeyTab3 = GlobalKey<FormState>();
  Map _passwords = {};
  UserBloc _bloc;
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
        MySnackBar.message('Senhas não coincidem', context:  context);
      }
    }
  }

  void disabledOrEnabledButton(bool value){
    disabledButton = value;
    setState(() {});
  }

  void request() async{
    try {
      var response;
      UserRequest loginRequest = UserRequest();
      disabledOrEnabledButton(true);
      response = await loginRequest.setPassword(json.encode(_passwords),_bloc.getId.toString(), _bloc.getToken);
      disabledOrEnabledButton(false);
      if(response == null)
        MySnackBar.message('Erro ao Conectar no Banco de Dados, tente novamente mais tarde', context:  context);
      else{
        if(response.statusCode == 200){
          Navigator.pop(context, 'Senha atualizada com sucesso');
        }else{
          MySnackBar.message('Erro ao Conectar no Banco de Dados, tente novamente mais tarde', context:  context);
        }
      }
    }catch (e){
      UserAgentClient.client.close();
      MySnackBar.message("Erro", context:  context);
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
                  validate: Validate.validatePassword,
                  parentAction: onSaved,
                  title: 'password',
                  obscureText: true,
                  icon: Icons.vpn_key,
                  hint: "Senha",
                ),
                MyTextField(
                  parentAction: onSaved,
                  title: 'confirmPassword',
                  icon: Icons.mode_edit,
                  hint: "Confirmar Senha",
                  obscureText: true,
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
