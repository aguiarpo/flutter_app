import 'package:http_auth/http_auth.dart' as http;

import '../user_login.dart';

class UserAgentClient{
  static var client;

  UserAgentClient(){
    if(client == null && LoginDatabase.email != null){
      setClient(LoginDatabase.email, LoginDatabase.password);
    }
  }

  void setClient(email, password){
    client =  http.BasicAuthClient(email, password);
  }
}
