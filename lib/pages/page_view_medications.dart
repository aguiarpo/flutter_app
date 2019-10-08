import 'package:flutter/material.dart';

Color mainColor = Color(0xff8CFFBA);

class PageViewListMedications extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PageViewListMedications();
  }
}

class _PageViewListMedications extends State<PageViewListMedications> {
  String title;

  List<Map> itens = [{
    "Nome" : "Nome"
  },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
    {
      "Nome" : "Nome"
    },
  ];

  @override
  void initState() {
    super.initState();
    title = "Medicações";
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
                    itemCount: itens.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = itens[index];
                      return Dismissible(
                        key: Key(UniqueKey().toString()),
                        onDismissed: (DismissDirection dir){
                          setState(() => itens.removeAt(index));
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$index - ${item["Nome"]} removido.'),
                              action: SnackBarAction(
                                label: 'UNDO',
                                onPressed: () {
                                  setState(() => itens.insert(index, item));
                                },
                              ),
                            ),
                          );
                        },
                        background: Container(
                          color: Colors.red,
                          child: Icon(Icons.delete),
                          alignment: Alignment.centerLeft,
                        ),
                        // Background when swipping from right to left
                        secondaryBackground: Container(
                          color: Colors.red,
                          child: Icon(Icons.delete),
                          alignment: Alignment.centerRight,
                        ),
                        child: Container(
                            height: 70.0,
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
                                          Text("${itens[index]['Nome']}", style: TextStyle(fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ),
                                  ),
                                  MaterialButton(
                                    onPressed: (){},
                                    child: Text("Editar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),),
                                    padding: EdgeInsets.only(left: 10, right: 10),
                                    color: Color(0xff179cbf),
                                  )
                                ],
                              ),
                            )
                        ),
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

