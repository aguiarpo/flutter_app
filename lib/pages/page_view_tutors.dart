import 'package:flutter/material.dart';
import 'package:flutter_app/components/autocomplete_textfield.dart';
import 'package:flutter_app/components/dropdown_button.dart';
import 'package:flutter_app/colors.dart';
import 'package:flutter_app/components/my_list.dart';

class PageViewListTutors extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PageViewListTutors();
  }
}

class _PageViewListTutors extends State<PageViewListTutors> {
  String title;
  List<String> listIndexNames = [];

  List<Map> list = [{
    "Nome" : "Nome", "CPF" : "CPF",
  },
    {
      "Nome" : "Nome", "CPF" : "CPF",
    },
    {
      "Nome" : "Nome", "CPF" : "CPF",
    },
    {
      "Nome" : "Nome", "CPF" : "CPF",
    },
    {
      "Nome" : "Nome", "CPF" : "CPF",
    },
    {
      "Nome" : "Nome", "CPF" : "CPF",
    },
    {
      "Nome" : "Nome", "CPF" : "CPF",
    },
    {
      "Nome" : "Nome", "CPF" : "CPF",
    },
    {
      "Nome" : "Nome", "CPF" : "CPF",
    },
    {
      "Nome" : "Nome", "CPF" : "CPF",
    },
    {
      "Nome" : "Nome", "CPF" : "CPF",
    },
    {
      "Nome" : "Nome", "CPF" : "CPF",
    },
    {
      "Nome" : "Nome", "CPF" : "CPF",
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
            child: Text("CPF: "),
          ),
          subtitle: Text("Cpf"),
        ),
      ),
      Container(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("RG: "),
          ),
          subtitle: Text("Rg"),
        ),
      ),
      Container(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Nome da mãe: "),
          ),
          subtitle: Text("Nome da mãe"),
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
            child: Text("Cidade: "),
          ),
          subtitle: Text("Cidade"),
        ),
      ),
      Container(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Bairro: "),
          ),
          subtitle: Text("Bairro"),
        ),
      ),
      Container(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Rua: "),
          ),
          subtitle: Text("Rua"),
        ),
      ),
      Container(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Número: "),
          ),
          subtitle: Text("Número"),
        ),
      ),
      Container(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Complemento: "),
          ),
          subtitle: Text("Complemento"),
        ),
      ),
      Container(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Profissão: "),
          ),
          subtitle: Text("Profissão"),
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
    title = "Tutores";
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
                  list: ["Nome", "CPF", "RG", "Removidos"],
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