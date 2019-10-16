import 'package:flutter/material.dart';

class ShowModalOptions{
 static void showOption(context, int index, listTitles){
    showModalBottomSheet(
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