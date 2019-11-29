import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/components/show_message_snackbar.dart';
import 'package:flutter_app/database/repository/all_repository.dart';
import 'package:flutter_app/database/repository/incidents_repository.dart';
import 'package:flutter_app/database/repository/medications_repository.dart';
import 'package:flutter_app/database/repository/user_login_repository.dart';
import 'package:flutter_app/models/medications.dart';
import 'package:flutter_app/models/user_login.dart';
import 'package:flutter_app/services/client.dart';
import 'package:flutter_app/services/incidents_request.dart';
import 'package:flutter_app/services/medications_request.dart';
import 'package:flutter_app/services/refresh_db_backend.dart';

import '../user_login.dart';
import 'user_request.dart';

class Request{

  List _userList;
  BuildContext _navigationContext;
  UserRequest _user = UserRequest();
  GlobalKey _scaffoldKey;

  void setNavigationContext(BuildContext context){
    _navigationContext = context;
  }

  void setScaffoldKey(GlobalKey scaffoldKey){
    _scaffoldKey = scaffoldKey;
  }

  requestGetLogin(List userList) async {
    _userList = userList;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none && userList != null){
      setLoginDatabase(_userList[0]);
      navigatePage('/home');
    }
    else if (connectivityResult == ConnectivityResult.none && userList == null) navigatePage('/login');
    else request();
  }

  request() async{
    var response;
    var responseMedications;
    try{
      if(_userList.isNotEmpty){
        UserLogin userLogin = _userList[0];
        setLoginDatabase(userLogin);
        _user.setClient(userLogin.email, userLogin.password);
        response = await _user.getLogin();
        await responseVerify(response, responseMedications, userLogin);
      }
      await Future.delayed(const Duration(seconds: 2));
      navigation(response);
    }catch(exception){
      UserAgentClient.client.close();
      if(_userList == null) navigatePage('/login');
      else navigatePage('/home');
    }
  }

  Future responseVerify(response,responseBody, userLogin) async {
    if(response != null) {
      if (response.statusCode == 200) {
        saveLoginDatabase(userLogin, response);
        MySnackBar.message("Atualizando Banco de Dados", scaffoldKey: _scaffoldKey);
        await requestSaveAll();
        responseBody = await _user.getAll();
        await saveAllValuesDatabase(responseBody);
      }else{
        navigatePage("/login");
      }
    }else{
      navigatePage("/home");
    }
  }

  void saveLoginDatabase(userLogin, response) async {
    UserLogin userRefresh = UserLogin();
    userRefresh.setValues(json.decode(response.body));
    userRefresh.password = userLogin.password;
    setLoginDatabase(userRefresh);
    await UserLoginRepository.truncateContacts();
    await UserLoginRepository.saveContact(userRefresh);
  }

  Future saveAllValuesDatabase(responseMedications) async {
    Map valuesBody = json.decode(responseMedications.body);
    await AllRepository.truncateAll();
    await AllRepository.saveAll(valuesBody);
}

  Future requestSaveAll()async{
    switch(LoginDatabase.levelsOfAccess){
      case "ADMIN":
        await RefreshDb.refreshMedications();
        await RefreshDb.refreshIncidents();
        await RefreshDb.refreshTutors();
        await RefreshDb.refreshAnimals();
        await RefreshDb.refreshAnimalsSave();
        await RefreshDb.refreshAnimalsDelete();
        break;
      case "USUARIO":
        break;
      case "VETERINARIO":
        break;
    }
  }

  void setLoginDatabase(UserLogin userLogin){
    LoginDatabase.email = userLogin.email;
    LoginDatabase.password = userLogin.password;
    LoginDatabase.name = userLogin.name;
    LoginDatabase.city = userLogin.city;
    LoginDatabase.state = userLogin.state;
    LoginDatabase.levelsOfAccess = userLogin.levelsOfAccess;
    LoginDatabase.telephone1 = userLogin.telephone1;
    LoginDatabase.telephone2 = userLogin.telephone2;
  }

  void navigation(response){
    if(response == null){
      navigatePage("/login");
    }else{
      if(response.statusCode == 200)navigatePage("/home");
      else navigatePage("/login");
    }
  }

  void navigatePage(page){
    Navigator.pushReplacementNamed(_navigationContext, page);
  }
}
