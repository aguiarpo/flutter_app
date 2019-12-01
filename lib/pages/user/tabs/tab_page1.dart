import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/json_bloc.dart';
import 'package:flutter_app/components/inputs/my_text_field.dart';
import 'package:flutter_app/validates/validate.dart';

class TabPage1 extends StatefulWidget {
  final JsonBloc jsonBloc;
  final bool emailVisible;
  final controllerName;
  final validatePassword;

  TabPage1({@required this.jsonBloc, this.emailVisible, this.controllerName, this.validatePassword});

  @override
  _TabPage1State createState() => _TabPage1State();
}

class _TabPage1State extends State<TabPage1> with AutomaticKeepAliveClientMixin<TabPage1> {
  JsonBloc jsonBloc;
  bool _emailVisible;

  @override
  void initState() {
    super.initState();
    _emailVisible = widget.emailVisible;
    jsonBloc = widget.jsonBloc;
  }

  void onSaved(values){
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
                  controller: widget.controllerName,
                  validate: (value) => Validate.validateAll(value,
                      r"^(([A-Za-z]+[\-\']?)*([A-Za-z]+)?\s)+([A-Za-z]+[\-\']?)*([A-Za-z]+)?$",
                      'Caracteres inválidos'),
                  parentAction: onSaved,
                  title: 'name',
                  icon: Icons.person,
                  hint: "Nome",
                ),
                Visibility(
                  visible: _emailVisible,
                  child: MyTextField(
                    validate: (value) => Validate.validateAll(value,
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                        'Email Inválido'),
                    parentAction: onSaved,
                    title: 'email',
                    icon: Icons.person,
                    hint: "Email",
                  ),
                ),
                MyTextField(
                  obscureText: true,
                  validate: widget.validatePassword,
                  parentAction: onSaved,
                  title: 'password',
                  icon: Icons.person,
                  hint: "Senha",
                ),
                MyTextField(
                  obscureText: true,
                  parentAction: onSaved,
                  title: 'confirmPassword',
                  icon: Icons.person,
                  hint: "Confirmar Senha",
                ),
              ]
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}


