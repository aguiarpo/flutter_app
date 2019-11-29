import 'package:flutter_app/models/user.dart';
import 'package:sqflite/sqflite.dart';
import '../columns_names.dart';
import '../connect.dart';

abstract class UserRepository{
  static Future<User> saveUser(User user) async {
    Database dbContact = await DatabaseConnect.internal().db;
    user.id = await dbContact.insert(userTable, user.toMap());
    return user;
  }

  static Future<int> truncateUsers() async {
    Database dbContact = await DatabaseConnect.internal().db;
    return await dbContact.delete(userTable);
  }
}