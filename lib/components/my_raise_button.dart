import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_button.dart';

class MyRaiseButton extends StatelessWidget {
  final tabController;
  final color;
  final ValueChanged<int> continueButton;
  final ValueChanged<Map> backButton;

  const MyRaiseButton({Key key, this.tabController, this.continueButton, this.backButton,
  this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 30, left: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Visibility(
              visible: tabController.index != 0,
              child: MyButton(
                color: color,
                text: "Anterior",
                onPress: () => backButton({'page' : tabController.index - 1, 'currentPage' : tabController.index}),
              )
          ),
          MyButton(
            color: color,
            text: "Continuar",
            onPress: () => continueButton(tabController.index + 1),
          )
        ],
      ),
    );
  }
}
