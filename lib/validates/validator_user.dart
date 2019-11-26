import 'is_empty.dart';

abstract class ValidateUser{

  static String validateNameEdit(String value) {
    value = value.trim();
    if(value.length == 0) return null;
    RegExp regExp = RegExp(
        r"^(([A-Za-z]+[\-\']?)*([A-Za-z]+)?\s)+([A-Za-z]+[\-\']?)*([A-Za-z]+)?$");
    if (!regExp.hasMatch(value)) {
      return 'Caracteres inválidos';
    }
    return null;
  }

  static String validateCityEdit(String value) {
    value = value.trim();
    if(value.length == 0) return null;
    RegExp regExp = RegExp(
        r"^([a-zA-Z\u0080-\u024F]+(?:. |-| |'))*[a-zA-Z\u0080-\u024F]*$");
    if (!regExp.hasMatch(value)) {
      return 'Caracteres inválidos';
    }
    return null;
  }

  static String validateEmailEdit(String value){
    value = value.trim();
    if(value.length == 0) return null;
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email Inválido';
    }
    return null;
  }

  static String validatePasswordEdit(String value){
    value = value.trim();
    if(value.length == 0) return null;
    if(value.length < 8) return "Senha deve conter no mínimo 8 caracteres";
    Pattern pattern =
        r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Senha deve conter no mínimo um número,\numa letra maiúscula e uma minúscula';
    }
    return null;
  }

  static String validateTelephoneEdit(String value){
    value = value.trim();
    if(value.length == 0) return null;
    Pattern pattern =
        r'\(\d{2}\)\s\d{4,5}-\d{4}';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Formato do Telefone (47) 9999-0000\nou (47) 99999-0000';
    }
    return null;
  }
}