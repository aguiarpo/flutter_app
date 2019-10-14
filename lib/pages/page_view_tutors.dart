import 'package:flutter/material.dart';
import 'package:flutter_app/components/dropdown_button.dart';
import 'package:flutter_app/colors.dart';
import 'package:flutter_app/components/my_button.dart';

class PageViewListTutors extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PageViewListTutors();
  }
}

class _PageViewListTutors extends State<PageViewListTutors> {
  String title;

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
                height: 70,
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
                        child: GestureDetector(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${itens[index]['Nome']}", style: TextStyle(fontWeight: FontWeight.bold),),
                              Text("${itens[index]['CPF']}"),
                            ],
                          ),
                        ),
                      ),
                      MyButton(
                        text: "Editar",
                        onPress: (){Navigator.pushNamed(context, "/editTutors");},
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
    title = "Tutores";
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