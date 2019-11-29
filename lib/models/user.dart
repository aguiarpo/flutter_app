class User{
  int id;
  String name;
  String email;
  String crmv;
  String levelsOfAccess;
  String state;
  String city;
  String telephone1;
  String telephone2;
  String createdBy;
  String createdDate;
  int removed;
  int registered;
  int edited;

  User();

  User.fromMap(Map map){
    id = map['idColumn'];
    name = map['nameColumn'];
    email = map['emailColumn'];
    city = map['cityColumn'];
    state = map['stateColumn'];
    telephone1 = map['telephone1Column'];
    telephone2 = map['telephone2Column'];
    levelsOfAccess = map['levelsOfAccessColumn'];
    createdBy = map['createdByColumn'];
    createdDate = map['createdDateColumn'];
    removed = map['removedColumn'];
    registered = map['registeredColumn'];
    edited = map['editedColumn'];
  }

  setCrmv(String crmv){
    this.crmv = crmv;
  }

  setValues(Map map){
    id = map['code'];
    name = map['name'];
    email = map['email'];
    city = map['city'];
    state = map['state'];
    telephone1 = map['telephone1'];
    telephone2 = map['telephone2'];
    levelsOfAccess = map['levelsOfAccess'];
    createdBy = map['createdBy'];
    createdDate = map['createdDate'];
    removed = 0;
    registered = 0;
    edited = 0;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nameColumn' : name,
      'emailColumn': email,
      'levelsOfAccessColumn' : levelsOfAccess,
      'stateColumn' : state,
      'cityColumn' : city,
      'telephone1Column' : telephone1,
      'telephone2Column' : telephone2,
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
    return "User(id: $id, name: $name, email: $email, "
        " state: $state, city: $city, telephone: $telephone1, telephone: $telephone2, type: $levelsOfAccess)";
  }
}