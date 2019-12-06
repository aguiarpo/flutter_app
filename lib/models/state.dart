class State{
  int id;
  String name;

  State();

  State.fromMap(Map map){
    id = map['idColumn'];
    name = map['nameColumn'];
  }

  setValues(Map map){
    id = map['code'];
    name = map['name'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nameColumn' : name,
    };
    if(id != null){
      map['idColumn'] = id;
    }
    return map;
  }
}