import 'is_empty.dart';

abstract class ValidatorToken{
  static String validateToken(String value){
    String empty = ValidateIsEmpty.isEmpty(value);
    if (empty != null) return empty;
    value = value.trim();
    Pattern pattern =
        r'[0-9]{6}';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Código inválido';
    }
    return null;
  }
}