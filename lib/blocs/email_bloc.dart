import 'dart:async';

class EmailBloc {
  final emailController = StreamController();
  EmailProvider emailProvider = new EmailProvider();

  Stream get getStream => emailController.stream;

  String get getEmail => emailProvider.email;

  String get getToken => emailProvider.token;

  int get getId => emailProvider.id;

  void updateEmail(String value) {
    emailProvider.updateEmail(value);
    emailController.sink.add(emailProvider
        .email);
  }

  void updateId(int value) {
    emailProvider.updateId(value);
    emailController.sink.add(emailProvider
        .email);
  }

  void updateToken(String value) {
    emailProvider.updateToken(value);
    emailController.sink.add(emailProvider
        .email);
  }

  void dispose() {
    emailController
        .close();
  }
}

class EmailProvider {
  String email = "";
  int id;
  String token = "";

  void updateEmail(String value){
    email = value;
  }

  void updateToken(String value){
    token = value;
  }

  void updateId(int value){
    id = value;
  }
}