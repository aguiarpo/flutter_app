class UserLogin{
  int id;
  String name;
  String email;
  String password;
  String levelsOfAccess;
  String state;
  String city;
  String telephone1;
  String telephone2;

  UserLogin();

  UserLogin.fromMap(Map map){
    id = map['idColumn'];
    name = map['nameColumn'];
    email = map['emailColumn'];
    password = map['passwordColumn'];
    city = map['cityColumn'];
    state = map['stateColumn'];
    telephone1 = map['telephone1Column'];
    telephone2 = map['telephone2Column'];
    levelsOfAccess = map['levelsOfAccessColumn'];
  }

  setValues(Map map){
    name = map['name'];
    email = map['email'];
    if(map['password'] != null)password = map['password'];
    city = map['city'];
    state = map['state'];
    telephone1 = map['telephone1'];
    telephone2 = map['telephone2'];
    levelsOfAccess = map['levelsOfAccess'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nameColumn' : name,
      'emailColumn': email,
      'passwordColumn': password,
      'levelsOfAccessColumn' : levelsOfAccess,
      'stateColumn' : state,
      'cityColumn' : city,
      'telephone1Column' : telephone1,
      'telephone2Column' : telephone2,
    };
    if(id != null){
      map['idColumn'] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "User(id: $id, name: $name, email: $email, password: $password,"
        " state: $state, city: $city, telephone: $telephone1, telephone: $telephone2, type: $levelsOfAccess)";
  }
}