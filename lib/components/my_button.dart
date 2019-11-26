import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final Color color;

  const MyButton({Key key, this.text, this.onPress, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.only(left: 20,right: 20),
      minWidth: 100,
      height: 45,
      color: color == null ? ColorsUsed.blueColor : color,
      child: Center(
        child: Text(text.toUpperCase(),
          style: TextStyle(
              color: color == null ? Colors.white : Colors.black38,
              fontWeight: FontWeight.w500,
              fontFamily: "Roboto",
          ),
        ),
      ),
      onPressed: onPress,
    );
  }
}
