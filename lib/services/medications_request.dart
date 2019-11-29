import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/services/url.dart';

import 'client.dart';

abstract class MedicationsRequest extends UserAgentClient{

  static Future postMedications(data) async {
    var url = Url.name + 'v1/veterinario/medicacoes';
    for(var value in data){
      await UserAgentClient.client.post(url, headers: {"Content-Type": "application/json"}, body: jsonEncode(value));
    }
  }

  static Future putMedications(data) async {
    var url = Url.name + 'v1/veterinario/medicacoes';
    for(var value in data){
      await UserAgentClient.client.post(url, headers: {"Content-Type": "application/json"}, body: jsonEncode(value));
    }
  }

  static Future deleteMedications(data) async {
    for(var value in data){
      var url = Url.name + 'v1/veterinario/medicacoes/' + value['code'].toString();
      await UserAgentClient.client.delete(url);
    }
  }
}