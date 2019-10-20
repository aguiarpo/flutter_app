import 'package:flutter/material.dart';
import 'package:flutter_app/components/autocomplete_textfield.dart';
import 'package:flutter_app/components/dropdown_button.dart';
import 'package:flutter_app/components/my_list.dart';

class PageViewListIncidents extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PageViewListIncidents();
  }
}

class _PageViewListIncidents extends State<PageViewListIncidents> {
  String title;
  List<String> listIndexNames = [];

  List<Map> list = [{
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

  List<Widget> showBottomSheet(){
    return <Widget>[
      Container(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Nome: "),
          ),
          subtitle: Text("Nome"),
        ),
      ),
      Container(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Observações: "),
          ),
          subtitle: Text("Observações"),
        ),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    title = "Incidentes";
    _listIndexNamesFunction();
  }

  void _listIndexNamesFunction(){
    if(list[0] != null){
      var item = list[0];
      item.forEach((index, value){
        if(index != null) listIndexNames.add(index);
      });
    }
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
                    child: AutoComplete(),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Select(
                  list: ["Id", "Removidos"],
                )
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
                child: MyList(
                  list: list,
                  showBottomSheet: showBottomSheet,
                  snackRemove: "Nome",
                  indexName: listIndexNames,
                  height: 70,
                ),
              ),
            ),
          ],
        )
    );
  }

}