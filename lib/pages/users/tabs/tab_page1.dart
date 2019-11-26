import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/dropdown_button.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:flutter_app/validates/validator_user.dart';
import 'package:flutter_app/validates/validator_user_login.dart';

class TabPage1 extends StatefulWidget {
  final jsonBloc;
  final type;

  const TabPage1({Key key, this.jsonBloc, this.type}) : super(key: key);

  @override
  _TabPage1State createState() => _TabPage1State();
}

class _TabPage1State extends State<TabPage1> with AutomaticKeepAliveClientMixin<TabPage1>{
  var jsonBloc;
  Function validateName;
  Function validateEmail;
  Function validatePassword;

  @override
  void initState() {
    super.initState();
    if(widget.type == 1){
      validateName = ValidateUserLogin.validateName;
      validateEmail = ValidateUserLogin.validateEmail;
      validatePassword = ValidateUserLogin.validatePassword;
    }else{
      validateName = ValidateUser.validateNameEdit;
      validateEmail = ValidateUser.validateEmailEdit;
      validatePassword = ValidateUser.validatePasswordEdit;
    }
    jsonBloc = widget.jsonBloc;
  }

  void onSaved(values)  {
    jsonBloc.addValue(values['title'], values['value']);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              MyTextField(
                parentAction: onSaved,
                title: 'name',
                validate: validateName,
                icon: Icons.person,
                hint: "Nome",
              ),
              MyTextField(
                validate: validateEmail,
                icon: Icons.email,
                hint: "Email",
                parentAction: onSaved,
                title: 'email',
              ),
              Visibility(
                visible: widget.type == 0,
                child: Column(
                  children: <Widget>[
                    MyTextField(
                      obscureText: true,
                      validate: validatePassword,
                      icon: Icons.vpn_key,
                      hint: "Senha",
                      parentAction: onSaved,
                      title: 'password',
                    ),
                    MyTextField(
                      obscureText: true,
                      icon: Icons.mode_edit,
                      hint: "Confirmar Senha",
                      parentAction: onSaved,
                      title: 'confirmPassword',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}