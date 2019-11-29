import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/email_bloc.dart';
import 'package:flutter_app/colors.dart';
import 'package:flutter_app/components/my_button.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:flutter_app/services/user_request.dart';
import 'package:flutter_app/validates/validator_token.dart';

class TabPage2 extends StatefulWidget {
  final ValueChanged<Map> parentAction;
  final EmailBloc bloc;

  const TabPage2({Key key, this.parentAction, this.bloc}) : super(key: key);

  @override
  _TabPage2State createState() => _TabPage2State();
}

class _TabPage2State extends State<TabPage2> {
  final GlobalKey<FormState> _formKeyTab2 = GlobalKey<FormState>();
  String _code;
  bool disabledButton = false;
  ValidatorToken validator;

  void onSaved(values){
    _code = values['value'];
  }

  void formSaved(){
    if(_formKeyTab2.currentState.validate()){
      _formKeyTab2.currentState.save();
      request();
    }
  }

  void request() async{
    var response;
    UserRequest loginRequest = UserRequest();
    disabledOrEnabledButton(true);
    response = await loginRequest.getToken(widget.bloc.getEmail, _code);
    disabledOrEnabledButton(false);
    var body;
    if(response == null){
      errorMessage('Erro ao Conectar no Banco de Dados, tente novamente mais tarde');
    }else{
      body = json.decode(response.body);
      switch(response.statusCode){
        case 200:
          widget.bloc.updateToken(_code);
          widget.bloc.updateId(body['user']['code']);
          Map list = {'page' : 2};
          widget.parentAction(list);
          break;
        case 404:
          body = json.decode(response.body);
          if(body['title'] == 'Resource Not Found')
            if(body['fieldMessage'] != null)
              errorMessage(body['fieldMessage']);
          break;
      }
    }
  }

  void errorMessage(String text){
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void disabledOrEnabledButton(bool value){
    disabledButton = value;
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKeyTab2,
            child: Column(
              children: <Widget>[
                MyTextField(
                  validate: ValidatorToken.validateToken,
                  type: TextInputType.number,
                  parentAction: onSaved,
                  title: 'code',
                  icon: Icons.code,
                  hint: "Código",
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

