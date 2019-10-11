import 'package:flutter/material.dart';
import 'package:flutter_app/pages/config.dart';
import 'package:flutter_app/pages/edit_cont.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/login.dart';
import 'package:flutter_app/pages/medications/edit.dart';
import 'package:flutter_app/pages/register.dart';
import 'package:flutter_app/pages/reset_password.dart';

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
    '/register' : (context) => Register(),
    '/editCont' : (context) => EditCont(),
    '/editMedications' : (context) => EditMedications(),
  },
)
);