import 'package:flutter/material.dart';
import 'package:flutter_app/colors.dart';

// ignore: must_be_immutable
class MyTextField extends StatefulWidget {
  IconData icon;
  String hint;

  MyTextField({Key key, this.icon, this.hint}) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  IconData _icon;
  String _hint;

  @override
  void initState(){
    _hint = widget.hint;
    _icon = widget.icon;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      child: TextField(
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
