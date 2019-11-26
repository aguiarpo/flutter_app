class Medications{
  int id;
  String name;
  String createdBy;
  String createdDate;
  int removed;
  int registered;
  int edited;

  Medications();

  Medications.fromMap(Map map){
    id = map['idColumn'];
    name = map['nameColumn'];
    createdBy = map['createdByColumn'];
    createdDate = map['createdDateColumn'];
    removed = map['removedColumn'];
    registered = map['registeredColumn'];
    edited = map['editedColumn'];
  }

  setValues(Map map){
    id = map['code'];
    name = map['name'];
    createdBy = map['createdBy'];
    createdDate = map['createdDate'];
    removed = 0;
    registered = 0;
    edited = 0;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nameColumn' : name,
      'createdByColumn': createdBy,
      'createdDateColumn': createdDate,
      'removedColumn' : removed,
      'registeredColumn' : registered,
      'editedColumn' : edited,
    };
    if(id != null){
      map['idColumn'] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Medications(id: $id, name: $name, created_by: $createdBy, created_date: $createdDate, removed $removed)";
  }
}