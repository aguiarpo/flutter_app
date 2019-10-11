import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/dropdown_button.dart';
import 'package:flutter_app/components/my_tab_page_selector.dart';
import 'package:flutter_app/components/style_text_field.dart';
import 'package:flutter_app/colors.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> with SingleTickerProviderStateMixin {
  TabController _tabController;

  var kIcons = <Widget>[
    RegisterPage1(),
    RegisterPage2()
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
                    height: 420,
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

class RegisterPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              MyTextField(
                icon: Icons.person,
                hint: "Nome",
              ),
              MyTextField(
                icon: Icons.email,
                hint: "Email",
              ),
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

class RegisterPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: Select(
                    list: [ "AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA",
                      "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ",
                      "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO",
                    ],
                    padding: EdgeInsets.only(left: 10, right: 10),
                    border: BoxDecoration(
                      border: Border.all(color: Colors.grey,),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              MyTextField(
                icon: Icons.location_city,
                hint: "Cidade",
              ),
              MyTextField(
                icon: Icons.phone,
                hint: "Telefone",
              ),
              MyTextField(
                icon: Icons.phone,
                hint: "Telefone",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
