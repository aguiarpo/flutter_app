import 'is_empty.dart';

abstract class ValidateVet{

  static String validateCRMV(String value, String level, initialLevel) {
    if(level != initialLevel){
      return ValidateIsEmpty.isEmpty(value);
    }
    value = value.trim();
    if(value.length == 0) return null;
    RegExp regExp = RegExp(
        r"^([0-9]{20})?$");
    if (!regExp.hasMatch(value)) {
      return 'Caracteres inválidos';
    }
    return null;
  }

  static String validateCRMV3(String value) {
    value = value.trim();
    if(value.length == 0) return null;
    RegExp regExp = RegExp(
        r"^([0-9]{20})?$");
    if (!regExp.hasMatch(value)) {
      return 'Caracteres inválidos';
    }
    return null;
  }

  static String validateCRMV2(String value) {
    value = value.trim();
    if(value.length == 0) return null;
    RegExp regExp = RegExp(
        r"^([0-9]{20})?$");
    if (!regExp.hasMatch(value)) {
      return 'Caracteres inválidos';
    }
    return null;
  }
}