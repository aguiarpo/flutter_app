class Validate{

  static String isEmpty(String value){
    if (value.isEmpty) {
      return 'Campo Obrigatório';
    }
    return null;
  }

  static String validateAll(value, String regex, String returnText){
    String empty = isEmpty(value);
    if (empty != null) return empty;
    value = value.trim();
    RegExp regExp = RegExp(regex);
    if (!regExp.hasMatch(value)) {
      return returnText;
    }
    return null;
  }

  static String validateAllWithoutEmpty(value, String regex, String returnText){
    value = value.trim();
    if(value.length == 0) return null;
    RegExp regExp = RegExp(regex);
    if (!regExp.hasMatch(value)) {
      return returnText;
    }
    return null;
  }

  static String validateComments(String value) {
    value = value.trim();
    RegExp regExp = RegExp(
        r"^([a-zA-Z\u0080-\u024F]+(?:. |-| |'))*[a-zA-Z\u0080-\u024F]*$");
    if (!regExp.hasMatch(value)) {
      return 'Caracteres inválidos';
    }
    return null;
  }


  static String validatePassword(String value){
    String empty = isEmpty(value);
    if (empty != null) return empty;
    value = value.trim();
    if(value.length < 8) return "Senha deve conter no mínimo 8 caracteres";
    Pattern pattern =
        r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Senha deve conter no mínimo um número,\numa letra maiúscula e uma minúscula';
    }
    return null;
  }

  static String validatePassword2(String value){
    value = value.trim();
    if(value.length == 0) return null;
    if(value.length < 8) return "Senha deve conter no mínimo 8 caracteres";
    Pattern pattern =
        r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Senha deve conter no mínimo um número,\numa letra maiúscula e uma minúscula';
    }
    return null;
  }
}