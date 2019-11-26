import 'is_empty.dart';

abstract class ValidateMedication{

  static String validateName(String value) {
    String empty = ValidateIsEmpty.isEmpty(value);
    if (empty != null) return empty;
    value = value.trim();
    RegExp regExp = RegExp(
        r"^([a-zA-Z\u0080-\u024F]+(?:. |-| |'))*[a-zA-Z\u0080-\u024F]*$");
    if (!regExp.hasMatch(value)) {
      return 'Caracteres inválidos';
    }
    return null;
  }

  static String validateName2(String value) {
    value = value.trim();
    if(value.length == 0) return null;
    RegExp regExp = RegExp(
        r"^([a-zA-Z\u0080-\u024F]+(?:. |-| |'))*[a-zA-Z\u0080-\u024F]*$");
    if (!regExp.hasMatch(value)) {
      return 'Caracteres inválidos';
    }
    return null;
  }
}