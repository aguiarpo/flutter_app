import 'package:flutter/material.dart';
import 'package:rounded_modal/rounded_modal.dart';

class ShowModalOptions{
 static void showOption(context, int index, listTitles){
   showRoundedModalBottomSheet(
        radius: 10,
        context: context,
        builder: (context){
          return BottomSheet(
            enableDrag: false,
            onClosing: (){},
            builder: (context){
              return Container(
                child: SingleChildScrollView(
                  child: Wrap(
                    children: listTitles,
                  ),
                ),
              );
            },
          );
        });
  }
}