import 'package:flutter/material.dart';
import 'package:flutter_app/components/dropdown_button.dart';
import 'package:flutter_app/colors.dart';
import 'package:flutter_app/components/my_button.dart';
import 'package:flutter_app/components/show_modal_options.dart';

class PageViewListAnimals extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PageViewListAnimals();
  }
}

class _PageViewListAnimals extends State<PageViewListAnimals> {
  String title;

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

  List<Widget> showBottomSheet(){
    // bool castradorVisible = false;
    return <Widget>[
      Container(
        decoration: BoxDecoration(
          border : Border(bottom: BorderSide(width: 1, color: Colors.grey)),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Nome: "),
          ),
          subtitle: Text("Nome"),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border : Border(bottom: BorderSide(width: 1, color: Colors.grey)),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Microchip: "),
          ),
          subtitle: Text("Microchip"),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border : Border(bottom: BorderSide(width: 1, color: Colors.grey)),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Nascimento: "),
          ),
          subtitle: Text("Data"),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border : Border(bottom: BorderSide(width: 1, color: Colors.grey)),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Raça: "),
          ),
          subtitle: Text("Raça"),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border : Border(bottom: BorderSide(width: 1, color: Colors.grey)),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Cor da pelagem: "),
          ),
          subtitle: Text("Cor"),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border : Border(bottom: BorderSide(width: 1, color: Colors.grey)),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Espécie: "),
          ),
          subtitle: Text("Espécie"),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border : Border(bottom: BorderSide(width: 1, color: Colors.grey)),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Microchipagem: "),
          ),
          subtitle: Text("Data"),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border : Border(bottom: BorderSide(width: 1, color: Colors.grey)),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Altura: "),
          ),
          subtitle: Text("Cm"),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border : Border(bottom: BorderSide(width: 1, color: Colors.grey)),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Observações: "),
          ),
          subtitle: Text("Observações"),
        ),
      ),
      InkWell(
        child: Container(
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
      ),
    ];
  }

  Future<List> display() async {
    await Future.delayed(Duration(milliseconds: 700));
    return list;
  }

  Widget listBuilder(itens){
    return ListView.builder(
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
                        color: ColorsUsed.blueColor,
                        width: 10,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ShowModalOptions.showOption(context, index, showBottomSheet());
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${itens[index]['Número']}", style: TextStyle(fontWeight: FontWeight.bold),),
                              Text("${itens[index]['Nome']}"),
                              Text("${itens[index]['CPF']}"),
                            ],
                          ),
                        ),
                      ),
                      MyButton(
                        text: "Editar",
                        onPress: (){Navigator.pushNamed(context, '/editAnimals');},
                      )
                    ],
                  ),
                )
            ),
          );
        }
    );
  }

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
                Select(
                  list: ["Nome", "Microchip", "Espécie", "Raça", "Removidos"],
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
                child: FutureBuilder(
                  future: display(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting: return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                      default:
                        if (snapshot.hasError)
                          return new Text('Error: ${snapshot.error}');
                        else
                          return listBuilder(snapshot.data);
                    }
                  },
                ),
              ),
            ),
          ],
        )
    );
  }
}
