class Incidents{
  int id;
  String name;
  String createdBy;
  String lastModifiedBy;
  String createdDate;
  String comments;
  int removed;
  int registered;
  int edited;

  Incidents();

  Incidents.fromMap(Map map){
    id = map['idColumn'];
    name = map['nameColumn'];
    createdBy = map['createdByColumn'];
    createdDate = map['createdDateColumn'];
    comments = map['commentsColumn'];
    lastModifiedBy = map['lastModifiedByColumn'];
    removed = map['removedColumn'];
    registered = map['registeredColumn'];
    edited = map['editedColumn'];
  }

  setValues(Map map){
    id = map['code'];
    name = map['name'];
    createdBy = map['createdBy'];
    createdDate = map['createdDate'];
    lastModifiedBy = map['lastModifiedBy'];
    comments = map['comments'];
    removed = 0;
    registered = 0;
    edited = 0;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nameColumn' : name,
      'createdByColumn': createdBy,
      'createdDateColumn': createdDate,
      'lastModifiedByColumn' : lastModifiedBy,
      'removedColumn' : removed,
      'commentsColumn' : comments,
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
    return "Incidents(id: $id, name: $name, comments: $comments, created_by: $createdBy, created_date: $createdDate, removed $removed)";
  }
}