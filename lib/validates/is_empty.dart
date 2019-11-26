abstract class ValidateIsEmpty{
  static String isEmpty(String value){
    if (value.isEmpty) {
      return 'Campo Obrigatório';
    }
    return null;
  }
}