import 'package:flutter/material.dart';

class MyBottomSheet extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;

  const MyBottomSheet({Key key, this.title, this.subtitle, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(title, style: TextStyle(color: color),),
        ),
        subtitle: Text(subtitle, style: TextStyle(color: color),),
      ),
    );
  }
}
