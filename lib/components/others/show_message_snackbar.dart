import 'package:flutter/material.dart';

abstract class MySnackBar{
  static void message(String text,{scaffoldKey, context}) {
    if (text != null && text != "") {
      if (context == null) {
        scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(text)),
        );
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)),);
      }
    }
  }
}