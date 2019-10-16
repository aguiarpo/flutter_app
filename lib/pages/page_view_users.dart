import 'package:flutter/material.dart';
import 'package:flutter_app/components/dropdown_button.dart';
import 'package:flutter_app/colors.dart';
import 'package:flutter_app/components/my_button.dart';
import 'package:flutter_app/components/show_modal_options.dart';

class PageViewListUsers extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PageViewListUsers();
  }
}

class _PageViewListUsers extends State<PageViewListUsers> {
  String title;

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
            child: Text("Email: "),
          ),
          subtitle: Text("Email"),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border : Border(bottom: BorderSide(width: 1, color: Colors.grey)),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Nível: "),
          ),
          subtitle: Text("Veterinário"),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border : Border(bottom: BorderSide(width: 1, color: Colors.grey)),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Crmv: "),
          ),
          subtitle: Text("Crmv"),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border : Border(bottom: BorderSide(width: 1, color: Colors.grey)),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Cidade: "),
          ),
          subtitle: Text("Cidade"),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border : Border(bottom: BorderSide(width: 1, color: Colors.grey)),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("Estado: "),
          ),
          subtitle: Text("Estado"),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border : Border(bottom: BorderSide(width: 1, color: Colors.grey)),
        ),
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
                              Text("${itens[index]['Nome']}", style: TextStyle(fontWeight: FontWeight.bold),),
                              Text("${itens[index]['Email']}"),
                              Text((itens[index]['CRMV'] == null) ? "" : "${itens[index]['CRMV']}"),
                            ],
                          ),
                        ),
                      ),
                      MyButton(
                        text: "Editar",
                        onPress: (){Navigator.pushNamed(context, '/editUsers');},
                      )
                    ],
                  ),
                )
            ),
          );
        }
    );
  }

  Future<List> display() async {
    await Future.delayed(Duration(milliseconds: 700));
    return list;
  }

  @override
  void initState() {
    super.initState();
    title = "Usuários";
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
