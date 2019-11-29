import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/services/url.dart';

import 'client.dart';

abstract class AnimalRequest extends UserAgentClient{

  static Future postAnimal(data) async {
    var url = Url.name + 'v1/veterinario/animal';
    for(var value in data){
      await UserAgentClient.client.post(url, headers: {"Content-Type": "application/json"}, body: jsonEncode(value));
    }
  }

  static Future putAnimal(data) async {
    var url = Url.name + 'v1/veterinario/animal';
    for(var value in data){
      await UserAgentClient.client.put(url, headers: {"Content-Type": "application/json"}, body: jsonEncode(value));
    }
  }

  static Future deleteAnimal(data) async {
    for(var value in data){
      var url = Url.name + 'v1/veterinario/animal/' + value['code'].toString();
      await UserAgentClient.client.delete(url);
    }
  }
}