import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/user_bloc.dart';
import 'package:flutter_app/components/buttons/my_button.dart';
import 'package:flutter_app/components/inputs/my_text_field.dart';
import 'package:flutter_app/validates/validate.dart';

class TabPage1 extends StatefulWidget {
  final ValueChanged<Map> parentAction;
  final UserBloc bloc;

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
                  validate: (value) => Validate.validateAll(value,
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                      'Email Inválido'),
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
