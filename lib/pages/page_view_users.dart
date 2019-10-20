import 'package:flutter/material.dart';
import 'package:flutter_app/components/autocomplete_textfield.dart';
import 'package:flutter_app/components/dropdown_button.dart';
import 'package:flutter_app/colors.dart';
import 'package:flutter_app/components/my_button.dart';
import 'package:flutter_app/components/my_list.dart';
import 'package:flutter_app/components/show_modal_options.dart';

class PageViewListUsers extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PageViewListUsers();
  }
}

class _PageViewListUsers extends State<PageViewListUsers> {
  String title;
  List<String> listIndexNames = [];

  List<Map> list = [{
    "Nome" : "Nome", "Email" : "Email", "CRMV" : "CRMV"
  },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : null
    },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : "CRMV"
    },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : "CRMV"
    },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : "CRMV"
    },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : "CRMV"
    },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : "CRMV"
    },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : null
    },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : null
    },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : "CRMV"
    },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : "CRMV"
    },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : "CRMV"
    },
    {
      "Nome" : "Nome", "Email" : "Email", "CRMV" : "CRMV"
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
            child: Text("Email: "),
          ),
          subtitle: Text("Email"),
        ),
      ),
      Container(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Nível: "),
          ),
          subtitle: Text("Veterinário"),
        ),
      ),
      Container(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Crmv: "),
          ),
          subtitle: Text("Crmv"),
        ),
      ),
      Container(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Cidade: "),
          ),
          subtitle: Text("Cidade"),
        ),
      ),
      Container(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Estado: "),
          ),
          subtitle: Text("Estado"),
        ),
      ),
      Container(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Telefones: "),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text("(47) 9999-0000"),
              ),
              Text("(47) 99999-0000"),
            ],
          ),
        ),
      ),
    ];
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
  void initState() {
    super.initState();
    title = "Usuários";
    _listIndexNamesFunction();
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
                  list : ["Nome", "Email", "Removidos"],
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
                  height: 90,
                ),
              ),
            ),
          ],
        )
    );
  }
}
