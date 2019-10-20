import 'package:flutter/material.dart';
import 'package:flutter_app/components/autocomplete_textfield.dart';
import 'package:flutter_app/components/dropdown_button.dart';
import 'package:flutter_app/colors.dart';
import 'package:flutter_app/components/my_list.dart';

class PageViewListAnimals extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PageViewListAnimals();
  }
}

class _PageViewListAnimals extends State<PageViewListAnimals> {
  String title;
  List<String> listIndexNames = [];

  List<Map> list = [{
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

  void _listIndexNamesFunction(){
      if(list[0] != null){
        var item = list[0];
        item.forEach((index, value){
          if(index != null) listIndexNames.add(index);
        });
      }
  }

  List<Widget> showBottomSheet(){
    // bool castradorVisible = false;
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
            child: Text("Microchip: "),
          ),
          subtitle: Text("Microchip"),
        ),
      ),
      Container(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Nascimento: "),
          ),
          subtitle: Text("Data"),
        ),
      ),
      Container(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Raça: "),
          ),
          subtitle: Text("Raça"),
        ),
      ),
      Container(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Cor da pelagem: "),
          ),
          subtitle: Text("Cor"),
        ),
      ),
      Container(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Espécie: "),
          ),
          subtitle: Text("Espécie"),
        ),
      ),
      Container(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Microchipagem: "),
          ),
          subtitle: Text("Data"),
        ),
      ),
      Container(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Altura: "),
          ),
          subtitle: Text("Cm"),
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
      Container(
          decoration: BoxDecoration(
            color: ColorsUsed.terciaryColor,
            border : Border(bottom: BorderSide(width: 1, color: Colors.white,)),
          ),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text("Castrador: ", style: TextStyle(color: Colors.white),),
            ),
            subtitle: Text("Crmv", style: TextStyle(color: Colors.white)),
          ),
        ),
      Container(
        decoration: BoxDecoration(
          color: ColorsUsed.terciaryColor,
          border : Border(bottom: BorderSide(width: 1, color: Colors.white,)),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Veterinário: ", style: TextStyle(color: Colors.white),),
          ),
          subtitle: Text("Crmv", style: TextStyle(color: Colors.white)),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: ColorsUsed.terciaryColor,
          border : Border(bottom: BorderSide(width: 1, color: Colors.white,)),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Tutor: ", style: TextStyle(color: Colors.white),),
          ),
          subtitle: Text("CPF", style: TextStyle(color: Colors.white)),
        ),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    title = "Animais";
    _listIndexNamesFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: AutoComplete(),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),Select(
                        padding: EdgeInsets.only(left: 10),
                        list: ["Nome", "Microchip", "Espécie", "Raça", "Removidos"],
                    ),
                ],
              ),
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
