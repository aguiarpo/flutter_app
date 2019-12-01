import 'package:flutter/material.dart';
import 'package:flutter_app/database/connect.dart';


class TabPage9 extends StatefulWidget {
  final incidents;
  final jsonBloc;
  final incidentsWithTutor;

  const TabPage9({Key key, this.incidents, this.jsonBloc, this.incidentsWithTutor}) : super(key: key);

  @override
  _TabPage9State createState() => _TabPage9State();
}

class _TabPage9State extends State<TabPage9> with AutomaticKeepAliveClientMixin<TabPage9>{
  Map checkbox = {};
  var jsonBloc;
  var incidentsWithTutor;
  DatabaseConnect db = DatabaseConnect();
  bool refresh;

  void addIndexBloc(){
    Map values = {"title" : "incidents", "value" : checkbox};
    jsonBloc.addValue(values['title'], values['value']);
  }

  @override
  void initState() {
    super.initState();
    refresh = false;
    incidentsWithTutor = widget.incidentsWithTutor;
    jsonBloc = widget.jsonBloc;
  }

  Widget listBuilder(itens){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
          padding: EdgeInsets.only(bottom: 100),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itens.length,
          itemBuilder: (BuildContext context, int index) {
            if(!incidentsWithTutor.contains(itens[index].id) && checkbox[index] == null)checkbox[index] = {"id" : itens[index].id, "value" : false};
            else if(checkbox[index] == null) checkbox[index] = {"id" : itens[index].id, "value" : true};
            addIndexBloc();
            return Container(
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.0, color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0)),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    CheckboxListTile(
                      title: Text(itens[index].name),
                      onChanged: (bool value) {
                        setState(() {
                          checkbox[index] = {"id" : itens[index].id, "value" : value};
                        });
                        addIndexBloc();
                      },
                      value: checkbox[index]['value'],
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }

  Future display()async{
    if(refresh == false){
      await Future.delayed(Duration(seconds: 1));
      refresh = true;
      return widget.incidents;
    }else{
      return widget.incidents;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text("Incientes do Tutor", style: TextStyle(fontSize: 15),),
            ),
          ),
          FutureBuilder(
          future: display(),
            builder: (context, snapshot) {
              if(refresh == false){
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
              }else{
                return listBuilder(snapshot.data);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}