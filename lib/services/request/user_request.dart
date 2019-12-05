import 'dart:async';
import 'package:flutter_app/services/url.dart';
import 'package:flutter_app/user_login.dart';
import 'package:http/http.dart' as http;

import '../client.dart';


class UserRequest extends UserAgentClient{

  Future getLogin() async {
     var response = await UserAgentClient.client.get(Url.name + 'v1/user/usuario/login').timeout(const Duration(seconds: 2));
      return response;
  }

  Future getAll() async {
    String requestName;
    if(LoginDatabase.levelsOfAccess == "ADMIN"){
      requestName = Url.name + 'v1/admin/all';
    }else{
      requestName = Url.name + 'v1/user/all';
    }
    var response = await UserAgentClient.client.get(requestName);
    return response;
  }

  Future setUserLogin(user) async{
    var url = Url.name + 'v1/user/usuario';
    var response = await UserAgentClient.client.put(url,headers: {"Content-Type": "application/json"}, body: user);
    return response;
  }

  Future addUser(user) async {
    var url = Url.name + 'v1/login/usuario';
    var response = await http.post(url,headers: {"Content-Type": "application/json"}, body: user);
    return response;
  }

  Future addToken(data) async {
    var url = Url.name + 'v1/login/recuperarSenha';
    var response = await http.post(url,headers: {"Content-Type": "application/json"}, body: data);
    return response;
  }

  Future getToken(email, token)async{
    var url = Url.name + 'v1/login/recuperarSenha/' + token + "/" + email;
    var response = await http.get(url);
    return response;
  }

  Future setPassword(user, code, token) async {
    var url = Url.name + 'v1/login/recuperarSenha/' + code + "/" + token;
    var response = await http.put(url, headers: {"Content-Type": "application/json"}, body: user);
    return response;
  }
}