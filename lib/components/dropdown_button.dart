import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Select extends StatefulWidget {
  final ValueChanged<String> parentAction;
  EdgeInsetsGeometry padding;
  Decoration border;
  List<String> list = [];
  Select({Key key, this.list, this.border, this.padding, this.parentAction}) : super(key: key);

  @override
  _Select createState() => new _Select();
}

class _Select extends State<Select> {
  EdgeInsetsGeometry _padding;
  Decoration _border;
  List<String> _list;

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _value;

  @override
  void initState() {
    _padding = widget.padding;
    _border = widget.border;
    _list = widget.list;
    _dropDownMenuItems = getDropDownMenuItems();
    _value = _dropDownMenuItems[0].value;
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
    return new Container(
      padding: _padding,
      decoration: _border,
      child: DropdownButton(
        style: TextStyle(color: Colors.grey),
        iconEnabledColor: Colors.grey,
        underline: SizedBox(),
        value: _value,
        items: _dropDownMenuItems,
        onChanged: changedDropDownItem,
      ),
    );
  }

  void changedDropDownItem(String value) {
    setState(() {
      _value = value;
    });
    if(widget.parentAction != null) widget.parentAction(value);
  }

}
