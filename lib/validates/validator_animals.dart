import 'is_empty.dart';

abstract class ValidateAnimals{

  static String validateSizeCmEdit(String value) {
    value = value.trim();
    if(value.length == 0) return null;
    RegExp regExp = RegExp(
        r"^([A-Za-z]{,2})$");
    if (!regExp.hasMatch(value)) {
      return 'Caracteres inválidos: Exemplo PP, P, MM, M, EG';
    }
    return null;
  }
  static String validateSizeCm(String value) {
    String empty = ValidateIsEmpty.isEmpty(value);
    if (empty != null) return empty;
    value = value.trim();
    RegExp regExp = RegExp(
        r"^([A-Za-z]{,2})$");
    if (!regExp.hasMatch(value)) {
      return 'Caracteres inválidos: Exemplo PP, P, MM, M, EG';
    }
    return null;
  }


}