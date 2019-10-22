import 'package:flutter/material.dart';

import 'autocomplete_textfield.dart';
import 'dropdown_button.dart';

class MyListUI extends StatefulWidget {
  final Widget list;
  final String title;
  final List<String> selectList;

  const MyListUI({Key key, this.list, this.title, this.selectList}) : super(key: key);

  @override
  _MyListUIState createState() => _MyListUIState();
}

class _MyListUIState extends State<MyListUI> {
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
                    child: AutoComplete(),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Select(
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
