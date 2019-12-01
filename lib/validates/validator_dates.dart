abstract class ValidateDates{
  static String validateDate(date, dateNull){
    if(dateNull == null && date == null) return "Campo Obrigatório";
    if(date == null)return null;
    final dateNow = DateTime.now();
    final difference = dateNow.difference(date).inDays;
    if(difference < 0)return "Data precisa estar no presente ou no passado";
    else return null;
  }

  static String validateDate2(date){
    if(date == null) return "Campo Obrigatório";
    final dateNow = DateTime.now();
    final difference = dateNow.difference(date).inDays;
    if(difference < 0)return "Data precisa estar no presente ou no passado";
    return null;
  }
}