import 'package:flutter/material.dart';
import 'package:flutter_app/pages/config.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/login.dart';

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
  },
)
);