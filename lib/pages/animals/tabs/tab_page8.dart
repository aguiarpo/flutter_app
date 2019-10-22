import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_multi_select.dart';

class TabPage8 extends StatefulWidget {
  @override
  _TabPage8State createState() => _TabPage8State();
}

class _TabPage8State extends State<TabPage8> {
  List<String> _list = [
    "Medicação1", "Medicação2"
  ];

  @override
  Widget build(BuildContext context) {
    return MyMultiSelect(
      list: _list,
      title: "Medicações",
    );
  }
}