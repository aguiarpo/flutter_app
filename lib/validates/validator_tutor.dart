import 'is_empty.dart';

abstract class ValidateTutor{

  static String validateRgEdit(String value) {
    value = value.trim();
    if(value.length == 0) return null;
    RegExp regExp = RegExp(
        r"^([0-9.\-]+)\w+");
    if (!regExp.hasMatch(value)) {
      return 'Caracteres inválidos';
    }
    return null;
  }

  static String validateRg(String value) {
    String empty = ValidateIsEmpty.isEmpty(value);
    if (empty != null) return empty;
    value = value.trim();
    RegExp regExp = RegExp(
        r"^([0-9.\-]+)\w+");
    if (!regExp.hasMatch(value)) {
      return 'Caracteres inválidos';
    }
    return null;
  }

  static String validateCpfEdit(String value) {
    value = value.trim();
    if(value.length == 0) return null;
    RegExp regExp = RegExp(
        r"^([0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}[-]?[0-9]{2})$");
    if (!regExp.hasMatch(value)) {
      return 'Caracteres inválidos';
    }
    return null;
  }

  static String validateCpf(String value) {
    String empty = ValidateIsEmpty.isEmpty(value);
    if (empty != null) return empty;
    value = value.trim();
    if(value.length == 0) return null;
    RegExp regExp = RegExp(
        r"^([0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}[-]?[0-9]{2})$");
    if (!regExp.hasMatch(value)) {
      return 'Caracteres inválidos';
    }
    return null;
  }

  static String validateCepEdit(String value) {
    value = value.trim();
    if(value.length == 0) return null;
    RegExp regExp = RegExp(
        r"^([0-9]{5}-[\d]{3})$");
    if (!regExp.hasMatch(value)) {
      return 'Caracteres inválidos: 00000-000';
    }
    return null;
  }

  static String validateCep(String value) {
    String empty = ValidateIsEmpty.isEmpty(value);
    if (empty != null) return empty;
    value = value.trim();
    if(value.length == 0) return null;
    RegExp regExp = RegExp(
        r"^([0-9]{5}-[\d]{3})$");
    if (!regExp.hasMatch(value)) {
      return 'Caracteres inválidos: 00000-000';
    }
    return null;
  }
}