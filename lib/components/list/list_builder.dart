import 'package:flutter/material.dart';
import 'package:flutter_app/components/buttons/my_button.dart';

import '../../colors.dart';
import '../../user_login.dart';

abstract class ListBuilder {

  static Widget listBuilderADMIN(itens, height, Function dimissed, Function getById,
      Function getChildren, Function editClick){

    return ListView.builder(
        padding: EdgeInsets.only(bottom: 100),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itens.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(UniqueKey().toString()),
            onDismissed: (DismissDirection dir){
              dimissed(itens[index], index);
            },
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete),
              alignment: Alignment.centerLeft,
            ),
            secondaryBackground: Container(
              color: Colors.red,
              child: Icon(Icons.delete),
              alignment: Alignment.centerRight,
            ),
            child: Container(
                height: height,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        color: ColorsUsed.blueColor,
                        width: 10,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            getById(itens[index].id);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: getChildren(itens, index),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: LoginDatabase.levelsOfAccess == "USUARIO" ? false : true,
                        child: MyButton(
                          text: "Editar",
                          onPress: ()async => await editClick(itens[index].id),
                        ),
                      )
                    ],
                  ),
                )
            ),
          );
        }
    );
  }

  static Widget listBuilder(itens, height, Function getById,
      Function getChildren, Function editClick){
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 100),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itens.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              height: height,
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      color: ColorsUsed.blueColor,
                      width: 10,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          getById(itens[index].id);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: getChildren(itens, index),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: LoginDatabase.levelsOfAccess == "USUARIO" ? false : true,
                      child: MyButton(
                        text: "Editar",
                        onPress: ()async => await editClick(itens[index].id),
                      ),
                    )
                  ],
                ),
              )
          );
        }
    );
  }
}