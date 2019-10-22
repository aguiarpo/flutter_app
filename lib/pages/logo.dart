import 'package:flutter/material.dart';

class PageInit extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: (){Navigator.pushReplacementNamed(context, "/login");},
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
