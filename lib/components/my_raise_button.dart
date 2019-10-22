import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_button.dart';

class MyRaiseButton extends StatelessWidget {
  final tabController;
  final ValueChanged<int> parentAction;

  const MyRaiseButton({Key key, this.tabController, this.parentAction}) : super(key: key);

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
                text: "Anterior",
                onPress: (){
                  if(tabController.index == 0){

                  }else{
                    parentAction(tabController.index - 1);
                  }
                },
              )
          ),
          MyButton(
            text: "Continuar",
            onPress: (){
              if(tabController.length - 1 == tabController.index){
                Navigator.pop(context);
              }else{
                parentAction(tabController.index + 1);
              }
            },
          )
        ],
      ),
    );
  }
}
