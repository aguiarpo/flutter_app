import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/user_bloc.dart';
import 'package:flutter_app/components/buttons/my_button.dart';
import 'package:flutter_app/components/inputs/my_text_field.dart';
import 'package:flutter_app/components/others/show_message_snackbar.dart';
import 'package:flutter_app/services/client.dart';
import 'package:flutter_app/services/request/user_request.dart';
import 'package:flutter_app/validates/validate.dart';

class TabPage2 extends StatefulWidget {
  final ValueChanged<Map> parentAction;
  final UserBloc bloc;

  const TabPage2({Key key, this.parentAction, this.bloc}) : super(key: key);

  @override
  _TabPage2State createState() => _TabPage2State();
}

class _TabPage2State extends State<TabPage2> {
  final GlobalKey<FormState> _formKeyTab2 = GlobalKey<FormState>();
  String _code;
  bool disabledButton = false;

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
    try {
      var response;
      UserRequest loginRequest = UserRequest();
      disabledOrEnabledButton(true);
      response = await loginRequest.getToken(widget.bloc.getEmail, _code);
      disabledOrEnabledButton(false);
      var body;
      if(response == null){
        MySnackBar.message('Erro ao Conectar no Banco de Dados, tente novamente mais tarde', context: context);
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
                MySnackBar.message(body['fieldMessage'],context: context);
            break;
        }
      }
    }catch (e){
      UserAgentClient.client.close();
      MySnackBar.message("Erro",context: context);
    }
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
                  validate: (value) => Validate.validateAll(value, r'[0-9]{6}', 'Código inválido'),
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

