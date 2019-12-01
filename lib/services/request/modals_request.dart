import 'dart:convert';

import '../client.dart';

class ModalsRequest extends UserAgentClient{
  static Future post(data, url) async {
    for(var value in data){
      await UserAgentClient.client.post(url, headers: {"Content-Type": "application/json"}, body: jsonEncode(value));
    }
  }

  static Future put(data, url) async {
    for(var value in data){
      await UserAgentClient.client.put(url, headers: {"Content-Type": "application/json"}, body: jsonEncode(value));
    }
  }

  static Future delete(data, url) async {
    for(var value in data){
      url += value['code'].toString();
      await UserAgentClient.client.delete(url);
    }
  }
}