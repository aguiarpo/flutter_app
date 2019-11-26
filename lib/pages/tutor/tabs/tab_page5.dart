import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_text_field.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/database/connect.dart';

import '../../../colors.dart';

class TabPage5 extends StatefulWidget {
  final incidents;
  final jsonBloc;
  final incidentsWithTutor;

  const TabPage5({Key key, this.incidents, this.jsonBloc, this.incidentsWithTutor}) : super(key: key);

  @override
  _TabPage5State createState() => _TabPage5State();
}

class _TabPage5State extends State<TabPage5> with AutomaticKeepAliveClientMixin<TabPage5>{
  Map checkbox = {};
  var jsonBloc;
  var incidentsWithTutor;
  DatabaseConnect db = DatabaseConnect();

  void addIndexBloc(){
    Map values = {"title" : "incidents", "value" : checkbox};
    jsonBloc.addValue(values['title'], values['value']);
  }

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return listBuilder(widget.incidents);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}