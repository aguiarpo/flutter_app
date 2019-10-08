import 'package:flutter/material.dart';

Color mainColor = Color(0xff8CFFBA);

List<Map> widgetsVehicle = [{
  "Nome" : "Nome", "Número" : "1111", "CPF" : "CPF"
},
  {
    "Nome" : "Nome", "Número" : "1111", "CPF" : "CPF"
  },
  {
    "Nome" : "Nome", "Número" : "1111", "CPF" : "CPF"
  },
  {
    "Nome" : "Nome", "Número" : "1111", "CPF" : "CPF"
  },
  {
    "Nome" : "Nome", "Número" : "1111", "CPF" : "CPF"
  },
  {
    "Nome" : "Nome", "Número" : "1111", "CPF" : "CPF"
  },

  {
    "Nome" : "Nome", "Número" : "1111", "CPF" : "CPF"
  },
  {
    "Nome" : "Nome", "Número" : "1111", "CPF" : "CPF"
  },
  {
    "Nome" : "Nome", "Número" : "1111", "CPF" : "CPF"
  },
  {
    "Nome" : "Nome", "Número" : "1111", "CPF" : "CPF"
  },
  {
    "Nome" : "Nome", "Número" : "1111", "CPF" : "CPF"
  },
];


class PageViewListAnimals extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PageViewListAnimals();
  }
}

class _PageViewListAnimals extends State<PageViewListAnimals> {
  String title;

  @override
  void initState() {
    super.initState();
    title = "Animais";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.search,
                          color: Colors.grey,
                        ),
                        hintText: 'Pesquisar',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Select()
              ],
            ),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 60,),
              child: Text("$title", style: TextStyle(fontSize: 20),),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2, color: Colors.grey.shade200),
                ),
              ),
              margin: EdgeInsets.only(top: 110),
              child: SingleChildScrollView(
                child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 100),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: new EdgeInsets.fromLTRB(10, 0, 10, 0),
                          width: 25.0,
                          height: 90.0,
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            color: Colors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  color: Color(0xff179cbf),
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${widgetsVehicle[index]['Número']}", style: TextStyle(fontWeight: FontWeight.bold),),
                                        Text("${widgetsVehicle[index]['Nome']}"),
                                        Text("${widgetsVehicle[index]['CPF']}"),
                                      ],
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: (){},
                                  child: Text("Editar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),),
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  height: 90,
                                  color: Color(0xff179cbf),
                                )
                              ],
                            ),
                          )
                      );
                    }
                ),
              ),
            ),
          ],
        )
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
  ["Modelo", "Placa"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentLevel;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentLevel = _dropDownMenuItems[0].value;
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
      child: DropdownButton(
        style: TextStyle(color: Colors.grey),
        iconEnabledColor: Colors.grey,
        underline: SizedBox(),
        value: _currentLevel,
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

