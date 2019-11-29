import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/services/url.dart';

import 'client.dart';

abstract class IncidentsRequest extends UserAgentClient{

  static Future postIncidents(List data) async {
    var url = Url.name + 'v1/admin/incidentes';
    for(var value in data){
      await UserAgentClient.client.post(url, headers: {"Content-Type": "application/json"}, body: jsonEncode(value));
    }
  }

  static Future putIncidents(data) async {
    var url = Url.name + 'v1/admin/incidentes';
    for(var value in data){
      await UserAgentClient.client.post(url, headers: {"Content-Type": "application/json"}, body: jsonEncode(value));
    }
  }

  static Future deleteIncidents(data) async {
    for(var value in data){
      var url = Url.name + 'v1/admin/incidentes/' + value['code'].toString();
      await UserAgentClient.client.delete(url);
    }
  }
}