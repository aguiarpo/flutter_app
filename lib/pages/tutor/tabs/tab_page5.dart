import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_multi_select.dart';

class TabPage5 extends StatefulWidget {
  @override
  _TabPage5State createState() => _TabPage5State();
}

class _TabPage5State extends State<TabPage5> {
  List<String> _list = [
    "Incidente1", "Incidente2"
  ];

  @override
  Widget build(BuildContext context) {
    return  MyMultiSelect(
      list: _list,
      title: "Incidentes",
    );
  }
}