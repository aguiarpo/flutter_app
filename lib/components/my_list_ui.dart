import 'package:flutter/material.dart';

import 'autocomplete_textfield.dart';
import 'dropdown_button.dart';

class MyListUI extends StatefulWidget {
  final Widget list;
  final String title;
  final List<String> selectList;
  final ValueChanged<String> parentAction;
  final ValueChanged<String> selectAction;

  const MyListUI({Key key, this.list, this.title, this.selectList, this.parentAction, this.selectAction}) : super(key: key);

  @override
  _MyListUIState createState() => _MyListUIState();
}

class _MyListUIState extends State<MyListUI> {
  String valueSelect;
  String suggestion;

  @override
  void initState() {
    super.initState();
    valueSelect = "Nome";
  }

  getSuggestion(String suggestion){
    widget.parentAction(suggestion);
  }

  setValue(value){
    valueSelect = value;
    widget.selectAction(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: AutoComplete(
                      select : valueSelect,
                      title : widget.title,
                      parentAction: getSuggestion,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Select(
                  title: "Nome",
                  parentAction: setValue,
                  list: widget.selectList,
                )
              ],
            ),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 60,),
              child: Text("${widget.title}", style: TextStyle(fontSize: 20),),
            ),
            Container(              decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 2, color: Colors.grey.shade200),
              ),
            ),
              margin: EdgeInsets.only(top: 110),
              child: SingleChildScrollView(
                child: widget.list,
              ),
            ),
          ],
        )
    );
  }
}
