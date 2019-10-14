import 'package:flutter/material.dart';
import 'package:flutter_app/pages/animals/edit.dart';
import 'package:flutter_app/pages/animals/register.dart';
import 'package:flutter_app/pages/config.dart';
import 'package:flutter_app/pages/edit_cont.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/incidents/edit.dart';
import 'package:flutter_app/pages/incidents/register.dart';
import 'package:flutter_app/pages/login.dart';
import 'package:flutter_app/pages/medications/edit.dart';
import 'package:flutter_app/pages/medications/register.dart';
import 'package:flutter_app/pages/register.dart';
import 'package:flutter_app/pages/reset_password.dart';
import 'package:flutter_app/pages/tutor/edit.dart';
import 'package:flutter_app/pages/tutor/register.dart';
import 'package:flutter_app/pages/users/edit.dart';
import 'package:flutter_app/pages/users/register.dart';

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
    '/editIncidents' : (context) => EditIncidents(),
    '/editUsers' : (context) => EditUser(),
    '/editTutors' : (context) => EditTutors(),
    '/editAnimals' : (context) => EditAnimals(),
    '/registerMedications' : (context) => RegisterMedications(),
    '/registerIncidents' : (context) => RegisterIncidents(),
    '/registerAnimals' : (context) => RegisterAnimals(),
    '/registerUser' : (context) => RegisterUser(),
    '/registerTutors' : (context) => RegisterTutors(),
  },
)
);