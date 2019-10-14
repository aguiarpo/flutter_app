import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/dropdown_button.dart';
import 'package:flutter_app/components/my_button.dart';
import 'package:flutter_app/components/my_tab_page_selector.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:flutter_app/colors.dart';

class RegisterTutors extends StatefulWidget {
  const RegisterTutors({Key key}) : super(key: key);

  @override
  _EditUser createState() => _EditUser();
}

class _EditUser extends State<RegisterTutors> with SingleTickerProviderStateMixin {
  TabController _tabController;

  var kIcons = <Widget>[
    RegisterPage1(),
    RegisterPage2(),
    RegisterPage3(),
    RegisterPage4(),
  ];


  Widget builderRaiseButtons(){
    return Container(
      padding: EdgeInsets.only(right: 30, left: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Visibility(
              visible: _tabController.index != 0,
              child: MyButton(
                text: "Anterior",
                onPress: (){
                  if(_tabController.index == 0){

                  }else{
                    _tabController.animateTo( _tabController.index - 1);
                    setState(() {});
                  }
                },
              )
          ),
          MyButton(
            text: "Continuar",
            onPress: (){
              if(_tabController.length - 1 == _tabController.index){
                Navigator.pop(context);
              }else{
                _tabController.animateTo( _tabController.index + 1);
                setState(() {});
              }
            },
          )
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
                    height: _tabController.index == 3 ? 310 : 420,
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
                icon: Icons.person,
                hint: "Nome da mãe",
              ),
              MyTextField(
                icon: Icons.person_pin,
                hint: "CPF",
              ),
              MyTextField(
                icon: Icons.person_pin,
                hint: "RG",
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
                hint: "CEP",
              ),
              MyTextField(
                icon: Icons.location_city,
                hint: "Bairro",
              ),
              MyTextField(
                icon: Icons.location_city,
                hint: "Rua",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              MyTextField(
                icon: Icons.mode_edit,
                hint: "Número",
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: TextField(
                  maxLines: 5,
                  style: new TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    hintText: "Complemento",
                  ),
                ),
              ),
              MyTextField(
                icon: Icons.build,
                hint: "Profissão",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterPage4 extends StatelessWidget {
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
                    list: [ "Incidente1", "Incidente2"],
                    padding: EdgeInsets.only(left: 10, right: 10),
                    border: BoxDecoration(
                      border: Border.all(color: Colors.grey,),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
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

