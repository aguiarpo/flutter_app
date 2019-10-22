import 'package:flutter/material.dart';

import 'multi_select.dart';
import 'my_button.dart';

class MyMultiSelect extends StatefulWidget {
  final String title;
  final List list;

  const MyMultiSelect({Key key, this.title, this.list}) : super(key: key);

  @override
  _MyMultiSelectState createState() => _MyMultiSelectState();
}

class _MyMultiSelectState extends State<MyMultiSelect> {
  List<String> selectedReportList = List();

  _showReportDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          //Here we will build the content of the dialog
          return AlertDialog(
            title: Text("Adicionar " + widget.title),
            content: MultiSelectChip(
              widget.list,
              onSelectionChanged: (selectedList) {
                setState(() {
                  selectedReportList = selectedList;
                });
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Adicionar"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: MyButton(
            text: widget.title,
            onPress: _showReportDialog,
          ),
        ),
        Text(selectedReportList.join(" , ")),
      ],
    );
  }
}
