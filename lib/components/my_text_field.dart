import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/colors.dart';

// ignore: must_be_immutable
class MyTextField extends StatefulWidget {
  Function validate;
  IconData icon;
  String hint;
  final String title;
  final ValueChanged<Map> parentAction;
  final obscureText;
  final TextEditingController controller;
  final type;

  MyTextField({Key key, this.icon, this.hint, this.parentAction, this.title,
  this.validate, this.obscureText, this.controller, this.type}) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  IconData _icon;
  String _hint;
  bool _obscureText;
  TextEditingController myController = TextEditingController();
  var _type;

  @override
  void initState(){
    _obscureText = widget.obscureText;
    _hint = widget.hint;
    _icon = widget.icon;
    _type = widget.type;
    if(widget.controller != null) myController = widget.controller;
    super.initState();
  }

  @override
  void dispose(){
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      child: TextFormField(
        keyboardType: _type,
        controller: myController,
        obscureText: _obscureText == null ? false : true,
        onSaved: (value){
          if(widget.parentAction != null){
            myController.text = value.trim();
            Map values = {"title" : widget.title, "value" : value.trim()};
            widget.parentAction(values);
          }
        },
        validator: widget.validate,
        style: new TextStyle(color: Colors.grey),
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: EdgeInsets.only(right: 20),
            padding: EdgeInsets.all(19),
            decoration: BoxDecoration(
              color: ColorsUsed.greenDarkColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(_icon,
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          hintText: _hint,
        ),
      ),
    );
  }
}
