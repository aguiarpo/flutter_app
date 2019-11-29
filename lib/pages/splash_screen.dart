import 'package:flutter/material.dart';
import 'package:flutter_app/database/repository/user_login_repository.dart';
import 'package:flutter_app/services/request_splash_screen.dart';

class SplashScreen  extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen > {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  startTime() async {
    List userList = [];
    userList = await UserLoginRepository.getAllContacts();
    Request request = Request();
    request.setNavigationContext(context);
    request.setScaffoldKey(_scaffoldKey);
    request.requestGetLogin(userList);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: InkWell(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(120),
            child: Image.asset('images/logo.png'),
          ),
        ),
      ),
    );
  }
}