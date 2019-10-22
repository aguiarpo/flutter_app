import 'package:flutter/material.dart';

import '../colors.dart';
import 'my_button.dart';
import 'show_modal_options.dart';

// ignore: must_be_immutable
class MyList extends StatefulWidget {
  final List<Map> list;
  final Function showBottomSheet;
  final String snackRemove;
  final List<String> indexName;
  final double height;
  final String navigation;


  const MyList({Key key, this.list, this.showBottomSheet, this.snackRemove, this.indexName, this.height,
  this.navigation}) : super(key: key);

  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {

  @override
  void initState() {
    super.initState();
  }

  Future<List> display() async {
    await Future.delayed(Duration(milliseconds: 700));
    return widget.list;
  }

  List<Widget> _textIndexName(index){
    List<Widget> listNames = [];
    List<String> listWidget;
    int count = 0;
    if(widget.indexName.isNotEmpty){
      listWidget = widget.indexName;
      listWidget.forEach((value){
        if(widget.list[index][value] != null){
          if(count == 0)listNames.add(Text("${widget.list[index][value]}", style: TextStyle(fontWeight: FontWeight.w600),));
          else listNames.add(Text("${widget.list[index][value]}"));
          count++;
        }
      });
    }
    return listNames;
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
                  content: Text('${widget.snackRemove} - ${item[widget.snackRemove]} removido.'),
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
            secondaryBackground: Container(
              color: Colors.red,
              child: Icon(Icons.delete),
              alignment: Alignment.centerRight,
            ),
            child: Container(
                height: widget.height,
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
                            ShowModalOptions.showOption(context, index, widget.showBottomSheet());
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _textIndexName(index),
                          ),
                        ),
                      ),
                      MyButton(
                        text: "Editar",
                        onPress: (){Navigator.pushNamed(context, widget.navigation);},
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
  Widget build(BuildContext context) {
    return FutureBuilder(
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
    );
  }
}
