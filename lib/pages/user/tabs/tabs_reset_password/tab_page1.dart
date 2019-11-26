import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/email_bloc.dart';
import 'package:flutter_app/components/my_button.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:flutter_app/validates/validator_user_login.dart';

class TabPage1 extends StatefulWidget {
  final ValueChanged<Map> parentAction;
  final EmailBloc bloc;

  const TabPage1({Key key, this.parentAction, this.bloc}) : super(key: key);

  @override
  _TabPage1State createState() => _TabPage1State();
}

class _TabPage1State extends State<TabPage1> {
  Map _email = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void onSaved(values){
    _email['email'] = values['value'];
    widget.bloc.updateEmail(values['value']);
  }

  void formSaved(){
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      Map list = {'page' : 1, 'value' : _email};
      widget.parentAction(list);
    }
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
            key: _formKey,
            child: Column(
              children: <Widget>[
                MyTextField(
                  validate: ValidateUserLogin.validateEmail,
                  parentAction: onSaved,
                  title: "email",
                  icon: Icons.email,
                  hint: "Email",
                ),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 20),
                  child: MyButton(
                    text: "Continuar",
                    onPress: formSaved,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
