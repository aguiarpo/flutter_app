import 'is_empty.dart';

abstract class ValidateVet{

  static String validateCRMV(String value) {
    String empty = ValidateIsEmpty.isEmpty(value);
    if (empty != null) return empty;
    value = value.trim();
    RegExp regExp = RegExp(
        r"^([0-9])?$");
    if (!regExp.hasMatch(value) && value.length > 19) {
      return 'Caracteres inválidos';
    }
    return null;
  }
}