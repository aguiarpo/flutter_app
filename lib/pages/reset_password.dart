import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_tab_page_selector.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:flutter_app/colors.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<Widget> kIcons = <Widget>[
    ResetPasswordPage1(),
    ResetPasswordPage2(),
    ResetPasswordPage3(),
  ];

  Widget builderRaiseButtons(){
    return Container(
      padding: EdgeInsets.only(right: 30, left: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Visibility(
            visible: _tabController.index != 0,
            child: MaterialButton(
                minWidth: 100,
                height: 45,
                color: ColorsUsed.blueColor,
                child: Center(
                  child: Text('Anterior'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                onPressed: (){
                  if(_tabController.index == 0){

                  }else{
                    _tabController.animateTo( _tabController.index - 1);
                    setState(() {});
                  }
                },
              ),
          ),
            MaterialButton(
              minWidth: 100,
              height: 45,
              color: ColorsUsed.blueColor,
              child: Center(
                child: Text('Continuar'.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              onPressed: (){
                if(_tabController.length - 1 == _tabController.index){
                  Navigator.pop(context);
                }else{
                  _tabController.animateTo( _tabController.index + 1);
                  setState(() {});
                }
              },
            ),
        ],
      ),
    );
  }

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
          color: ColorsUsed.greenDarkColor, //change your color here
        ),
        title: Text("Reserva", style: TextStyle(
          fontFamily: 'Roboto', fontWeight: FontWeight.w400,
          color: ColorsUsed.greenDarkColor,
        ),
        ),
        backgroundColor: ColorsUsed.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: <Widget>[
            MyTabPageSelector(
              color: Colors.white,
              controller: _tabController,
              indicatorSize: 9,
              selectedColor: ColorsUsed.blueColor,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: _tabController.index == 1 ? 160 :
                      _tabController.index == 2 ? 210 : 110,
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
                  builderRaiseButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResetPasswordPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              MyTextField(
                icon: Icons.email,
                hint: "Email",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResetPasswordPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              MyTextField(
                icon: Icons.code,
                hint: "Código",
              ),
              GestureDetector(
                onTap: (){
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Email enviado, verifique se o email chegou ao seu destino'),
                    ),
                  );
                },
                child: Text("Enviar email novamente", style: TextStyle(
                  color: ColorsUsed.blueDarkColor,
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResetPasswordPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              MyTextField(
                icon: Icons.vpn_key,
                hint: "Senha",
              ),
              MyTextField(
                icon: Icons.mode_edit,
                hint: "Confirmar Senha",
              ),
            ],
          ),
        ),
      ),
    );
  }
}