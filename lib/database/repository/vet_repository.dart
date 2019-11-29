import 'package:flutter_app/models/vet.dart';
import 'package:sqflite/sqflite.dart';

import '../columns_names.dart';
import '../connect.dart';

abstract class VetRepository{

  static Future<Vet> saveVet(Vet vet) async {
    Database dbContact = await DatabaseConnect.internal().db;
    if(vet.userId  != null)await dbContact.insert(userTable, vet.user.toMap());
    vet.id = await dbContact.insert(vetTable, vet.toMap());
    return vet;
  }

  static Future<Vet> saveOnlyVet(Vet vet) async {
    Database dbContact = await DatabaseConnect.internal().db;
    vet.id = await dbContact.insert(vetTable, vet.toMap());
    return vet;
  }

  static Future<int> updateVet(Vet vet) async {
    Database dbContact = await DatabaseConnect.internal().db;
    return await dbContact.update(vetTable, vet.toMap(), where: "$idColumn = ?", whereArgs: [vet.id]);
  }

  static Future<Vet> getVet(int id) async {
    Database dbContact = await DatabaseConnect.internal().db;
    List<Map> maps = await dbContact.query(vetTable,
        columns: [idColumn, crmvColumn, idUserColumn],
        where: "$idUserColumn == ?",
        whereArgs: [id]);
    if(maps.length > 0){
      return Vet.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<Vet> getVetByCrmv(String crmv) async {
    Database dbContact = await DatabaseConnect.internal().db;
    List<Map> maps = await dbContact.query(vetTable,
        columns: [idColumn, crmvColumn, idUserColumn],
        where: "$crmvColumn == ?",
        whereArgs: [crmv]);
    if(maps.length > 0){
      return Vet.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<int> truncateVets() async {
    Database dbContact = await DatabaseConnect.internal().db;
    return await dbContact.delete(vetTable);
  }
}