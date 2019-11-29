import 'package:flutter_app/database/connect.dart';
import 'package:flutter_app/models/user_login.dart';
import 'package:sqflite/sqflite.dart';

import '../../user_login.dart';
import '../columns_names.dart';

abstract class UserLoginRepository{
  static Future<UserLogin> saveContact(UserLogin user) async {
    Database dbContact = await DatabaseConnect.internal().db;
    user.id = await dbContact.insert(userLoginTable, user.toMap());
    return user;
  }

  static Future<int> getNumber() async {
    Database dbContact = await DatabaseConnect.internal().db;
    return Sqflite.firstIntValue(await dbContact.rawQuery("SELECT COUNT(*) FROM $userLoginTable"));
  }

  static Future<List> getAllContacts() async {
    Database dbContact = await DatabaseConnect.internal().db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $userLoginTable");
    List<UserLogin> listContact = List();
    for(Map m in listMap){
      listContact.add(UserLogin.fromMap(m));
    }
    return listContact;
  }

  static Future<int> truncateContacts() async {
    Database dbContact = await DatabaseConnect.internal().db;
    return await dbContact.delete(userLoginTable);
  }

  static Future<int> updateContact(UserLogin contact) async {
    Database dbContact = await DatabaseConnect.internal().db;
    return await dbContact.update(userLoginTable,
        contact.toMap(),
        where: "$idColumn = ?",
        whereArgs: [contact.id]);
  }

  static Future<int> deleteContact(int id) async {
    Database dbContact = await DatabaseConnect.internal().db;
    return await dbContact.delete(userLoginTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  static Future<UserLogin> getContactEmail() async {
    Database dbContact = await DatabaseConnect.internal().db;
    List<Map> maps = await dbContact.query(userLoginTable,
        columns: [idColumn, nameColumn, emailColumn, cityColumn, stateColumn, passwordColumn, telephoneColumn1, telephoneColumn2],
        where: "$emailColumn = ?",
        whereArgs: [LoginDatabase.email]);
    if(maps.length > 0){
      return UserLogin.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<UserLogin> getContact(int id) async {
    Database dbContact = await DatabaseConnect.internal().db;
    List<Map> maps = await dbContact.query(userLoginTable,
        columns: [idColumn, nameColumn, emailColumn, cityColumn, stateColumn, passwordColumn, telephoneColumn1, telephoneColumn2],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if(maps.length > 0){
      return UserLogin.fromMap(maps.first);
    } else {
      return null;
    }
  }

}