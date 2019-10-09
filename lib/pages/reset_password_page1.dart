import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color mainColor = Color(0xff8CFFBA);
const color = Color(0xff1A773F);
const color2 = Color(0xff66D994);

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> with SingleTickerProviderStateMixin {
  TabController _tabController;

  static const kIcons = <Icon>[
    Icon(Icons.event),
    Icon(Icons.home),
    Icon(Icons.android),
    Icon(Icons.alarm),
    Icon(Icons.face),
    Icon(Icons.language),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: kIcons.length,
      initialIndex: 0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: color, //change your color here
        ),
        title: Text("Reserva", style: TextStyle(
          fontFamily: 'Roboto', fontWeight: FontWeight.w400,
          color: color,
        ),
        ),
        backgroundColor: mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TabPageSelector(
              controller: _tabController,
              color: Color(0xff179cbf),
            ),
            Expanded(
              child: IconTheme(
                data: IconThemeData(
                  size: 128.0,
                  color: Theme.of(context).accentColor,
                ),
                child: TabBarView(
                  controller: _tabController,
                  children: kIcons,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Visibility(
                      visible: _tabController.index != 0,
                      child: RaisedButton(
                          child: Text('Anterior'),
                          onPressed: () {
                            if(_tabController.index == 0){

                            }else{
                              _tabController.animateTo( _tabController.index - 1);
                              setState(() {});
                            }
                          }
                      ),
                    ),
                  RaisedButton(
                      child: _tabController.length - 1 == _tabController.index ?
                      Text('Enviar') : Text('Continuar'),
                      onPressed: () {
                        // ignore: unrelated_type_equality_checks
                        if(_tabController.indexIsChanging == 1){
                        }else{
                          _tabController.animateTo(_tabController.index + 1);
                          setState(() {});
                        }
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
