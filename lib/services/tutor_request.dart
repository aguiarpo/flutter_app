import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/services/url.dart';

import 'client.dart';

abstract class TutorRequest extends UserAgentClient{

  static Future postTutor(data) async {
    var url = Url.name + 'v1/veterinario/tutor';
    for(var value in data){
      await UserAgentClient.client.post(url, headers: {"Content-Type": "application/json"}, body: jsonEncode(value));
    }
  }

  static Future putTutor(data) async {
    var url = Url.name + 'v1/veterinario/tutor';
    for(var value in data){
      await UserAgentClient.client.put(url, headers: {"Content-Type": "application/json"}, body: jsonEncode(value));
    }
  }

  static Future deleteTutor(data) async {
    for(var value in data){
      var url = Url.name + 'v1/veterinario/tutor/' + value['code'].toString();
      await UserAgentClient.client.delete(url);
    }
  }
}