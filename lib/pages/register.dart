import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_tab_page_selector.dart';

Color mainColor = Color(0xff8CFFBA);
const color = Color(0xff1A773F);
const color2 = Color(0xff66D994);

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
              color: Color(0xff179CBF),
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
            color: Color(0xff179CBF),
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
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: <Widget>[
            MyTabPageSelector(
              color: Colors.white,
              controller: _tabController,
              indicatorSize: 9,
              selectedColor: Color(0xff179cbf),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 350,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: TextField(
                  style: new TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    prefixIcon: Container(
                      margin: EdgeInsets.only(right: 20),
                      padding: EdgeInsets.all(19),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    hintText: 'Nome',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: TextField(
                  style: new TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    prefixIcon: Container(
                      margin: EdgeInsets.only(right: 20),
                      padding: EdgeInsets.all(19),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(Icons.email,
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    hintText: 'Email',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: TextField(
                  style: new TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    prefixIcon: Container(
                      margin: EdgeInsets.only(right: 20),
                      padding: EdgeInsets.all(19),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(Icons.vpn_key,
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    hintText: 'Senha',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: TextField(
                  style: new TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    prefixIcon: Container(
                      margin: EdgeInsets.only(right: 20),
                      padding: EdgeInsets.all(19),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(Icons.mode_edit,
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    hintText: 'Confirmar senha',
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
                  child: Select(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: TextField(
                  style: new TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    prefixIcon: Container(
                      margin: EdgeInsets.only(right: 20),
                      padding: EdgeInsets.all(19),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(Icons.location_city,
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    hintText: 'Cidade',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: TextField(
                  style: new TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    prefixIcon: Container(
                      margin: EdgeInsets.only(right: 20),
                      padding: EdgeInsets.all(19),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    hintText: 'Telefone',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: TextField(
                  style: new TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    prefixIcon: Container(
                      margin: EdgeInsets.only(right: 20),
                      padding: EdgeInsets.all(19),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    hintText: 'Telefone',
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

class Select extends StatefulWidget {
  Select({Key key}) : super(key: key);

  @override
  _Select createState() => new _Select();
}

class _Select extends State<Select> {

  List levelsOfAccess =
  ["SC", "RJ"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentLevel;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentLevel = null;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String levelOfAccess in levelsOfAccess) {
      items.add(new DropdownMenuItem(
          value: levelOfAccess,
          child: new Text(levelOfAccess)
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(right: 10, left: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton(
        hint: Text("Estado"),
        style: TextStyle(color: Colors.grey),
        iconEnabledColor: Colors.grey,
        underline: SizedBox(),
        value: _currentLevel == null ? null : _currentLevel,
        items: _dropDownMenuItems,
        onChanged: changedDropDownItem,
      ),
    );
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentLevel = selectedCity;
    });
  }

}
