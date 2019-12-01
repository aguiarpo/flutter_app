import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Select extends StatefulWidget {
  final ValueChanged<String> parentAction;
  final String title;
  EdgeInsetsGeometry padding;
  Decoration border;
  List<String> list = [];
  final value;
  Select({Key key, this.list, this.border, this.padding, this.parentAction, this.title, this.value}) : super(key: key);

  @override
  _Select createState() => new _Select();
}

class _Select extends State<Select> {
  EdgeInsetsGeometry _padding;
  Decoration _border;
  List<String> _list;
  String _title;

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _value;

  @override
  void initState() {
    _value = widget.value;
    _title = widget.title;
    _padding = widget.padding;
    _border = widget.border;
    _list = widget.list;
    _dropDownMenuItems = getDropDownMenuItems();
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String value in _list) {
      items.add(new DropdownMenuItem(
          value: value,
          child:Text(value),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Visibility(
          visible: _title == "" ? false : true,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text("$_title :", style: TextStyle(color: Colors.grey),),
          ),
        ),
        new Container(
          padding: _padding,
          decoration: _border,
          child: DropdownButton(
            style: TextStyle(color: Colors.grey),
            iconEnabledColor: Colors.grey,
            underline: SizedBox(),
            hint: Text(_title),
            value: _value,
            items: _dropDownMenuItems,
            onChanged: changedDropDownItem,
          ),
        ),
      ],
    );
  }

  void changedDropDownItem(String value) {
    setState(() {
      _value = value;
    });
    if(widget.parentAction != null) widget.parentAction(value);
  }

}
