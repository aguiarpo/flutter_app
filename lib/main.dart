import 'package:flutter/material.dart';
import 'package:flutter_app/pages/config.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/login.dart';
import 'package:flutter_app/pages/reset_password_page1.dart';

void main() => runApp(MaterialApp(
  title: 'Registro de animais',
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primarySwatch: Colors.blue,
    fontFamily: "Roboto"
  ),
  initialRoute: '/',
  routes: {
    '/': (context) => LoginPage(),
    '/home': (context) => HomePage(),
    '/config' : (context) => ConfigPage(),
    '/resetPassword1' : (context) => ResetPassword(),
  },
)
);