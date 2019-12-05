import 'dart:convert';

import '../client.dart';

class ModalsRequest extends UserAgentClient{
  static Future post(data, url) async {
    for(var value in data){
      value = jsonEncode(value);
      await UserAgentClient.client.post(url, headers: {"Content-Type": "application/json"}, body: value);
    }
  }

  static Future put(data, url) async {
    for(var value in data){
      value = jsonEncode(value);
      await UserAgentClient.client.put(url, headers: {"Content-Type": "application/json"}, body: value);
    }
  }

  static Future delete(data, url) async {
    for(var value in data){
      url += value['code'].toString();
      await UserAgentClient.client.delete(url);
    }
  }
}