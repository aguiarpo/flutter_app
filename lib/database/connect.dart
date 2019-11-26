
import 'package:flutter_app/models/animal.dart';
import 'package:flutter_app/models/animal_medications.dart';
import 'package:flutter_app/models/incidents.dart';
import 'package:flutter_app/models/medications.dart';
import 'package:flutter_app/models/tutor.dart';
import 'package:flutter_app/models/tutors_incidents.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/models/user_login.dart';
import 'package:flutter_app/models/vet.dart';
import 'package:flutter_app/user_login.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


final String userLoginTable = "userLogin";
final String vetTable = "vet";
final String medicationsTable = "medications";
final String incidentsTable = 'incidents';
final String userTable = "user";
final String tutorTable = "tutor";
final String animalTable = "animal";
final String tutorIncidentsTable = "incidentsTutor";
final String animalMedicationsTable = "animalMedications";

final String idColumn = "idColumn";
final String idIncidentsColumn = "idIncidentsColumn";
final String idTutorColumn = "idTutorColumn";
final String idUserColumn = "idUserColumn";
final String crmvColumn = "crmvColumn";
final String nameColumn = "nameColumn";
final String emailColumn = "emailColumn";
final String passwordColumn = "passwordColumn";
final String telephoneColumn1 = "telephone1Column";
final String telephoneColumn2 = "telephone2Column";
final String stateColumn = "stateColumn";
final String cityColumn = "cityColumn";
final String levelsOfAccessColumn = "levelsOfAccessColumn";
final String createdByColumn = "createdByColumn";
final String createdDateColumn  = "createdDateColumn";
final String lastModifiedByColumn  = "lastModifiedByColumn";
final String lastModifiedDateColumn = "lastModifiedDateColumn";
final String removedColumn = 'removedColumn';
final String registeredColumn = 'registeredColumn';
final String editedColumn = 'editedColumn';
final String commentsColumn = "commentsColumn";
final String motherNameColumn = "motherNameColumn";
final String streetColumn = "streetColumn";
final String cpfColumn = "cpfColumn";
final String rgColumn = "rgColumn";
final String numberColumn = "numberColumn";
final String neighborhoodColumn = "neighborhoodColumn";
final String complementColumn = "complementColumn";
final String cepColumn = "cepColumn";
final String professionColumn = "professionColumn";
final String microchipNumberColumn = "microchipNumberColumn";
final String speciesColumn = "speciesColumn";
final String birthDateColumn = "birthDateColumn";
final String animalCastratedColumn = "animalCastratedColumn";
final String coatColorColumn = "coatColorColumn";
final String breedColumn = "breedColumn";
final String sizeCmColumn = "sizeCmColumn";
final String dateMicrochipColumn = "dateMicrochipColumn";
final String idVetColumn = "vetColumn";
final String idAnimalColumn = "idAnimalColumn";
final String idMedicationsColumn = "idMedicationsColumn";
final String dateMedicationColumn = "dateMedicationColumn";

class DatabaseConnect {

  static final DatabaseConnect _instance = DatabaseConnect.internal();

  factory DatabaseConnect() => _instance;

  DatabaseConnect.internal();

  static Database _db;

  Future<Database> get db async {
    if(_db != null){
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "surca.db");
    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $userLoginTable($idColumn INTEGER PRIMARY KEY,"
              "$nameColumn TEXT, $emailColumn VARCHAR(255) UNIQUE,"
              "$passwordColumn TEXT, $telephoneColumn1 TEXT, $telephoneColumn2 TEXT,"
              "$cityColumn TEXT, $stateColumn VARCHAR(2), $levelsOfAccessColumn VARCHAR(10))"
      );
      await db.execute(
          "CREATE TABLE $medicationsTable($idColumn INTEGER PRIMARY KEY,"
              "$nameColumn TEXT UNIQUE, $createdByColumn TEXT,"
              "$createdDateColumn TEXT, $removedColumn INTEGER(1) DEFAULT 0, $registeredColumn INTEGER(1) DEFAULT 0,"
              "$editedColumn INTEGER(1) DEFAULT 0)"
      );
      await db.execute(
          "CREATE TABLE $incidentsTable($idColumn INTEGER PRIMARY KEY,"
              "$nameColumn TEXT UNIQUE, $commentsColumn TEXT, $createdByColumn TEXT,"
              "$createdDateColumn TEXT, $removedColumn INTEGER(1) DEFAULT 0, $registeredColumn INTEGER(1) DEFAULT 0,"
              "$editedColumn INTEGER(1) DEFAULT 0)"
      );
      await db.execute(
          "CREATE TABLE $userTable($idColumn INTEGER PRIMARY KEY,"
              "$nameColumn TEXT, $emailColumn VARCHAR(255) UNIQUE,"
              "$passwordColumn TEXT, $telephoneColumn1 TEXT, $telephoneColumn2 TEXT,"
              "$cityColumn TEXT, $stateColumn VARCHAR(2),$createdByColumn TEXT,"
              "$createdDateColumn TEXT, $levelsOfAccessColumn VARCHAR(10),"
              "$removedColumn INTEGER(1) DEFAULT 0, $registeredColumn INTEGER(1) DEFAULT 0,"
              "$editedColumn INTEGER(1) DEFAULT 0)"
      );
      await db.execute(
          "CREATE TABLE $tutorTable($idColumn INTEGER PRIMARY KEY,"
              "$nameColumn TEXT, $motherNameColumn TEXT, "
              "$telephoneColumn1 TEXT, $telephoneColumn2 TEXT,"
              "$cpfColumn VARCHAR(15),$rgColumn VARCHAR(10), $stateColumn VARCHAR(2), $cityColumn TEXT,"
              "$cepColumn VARCHAR(15), $neighborhoodColumn TEXT, "
              "$streetColumn TEXT, $numberColumn INTEGER(5), $professionColumn TEXT, "
              "$complementColumn TEXT, $createdByColumn TEXT,"
              "$createdDateColumn TEXT, "
              "$removedColumn INTEGER(1) DEFAULT 0, $registeredColumn INTEGER(1) DEFAULT 0,"
              "$editedColumn INTEGER(1) DEFAULT 0)"
      );
      await db.execute(
          "CREATE TABLE $animalTable($idColumn INTEGER PRIMARY KEY,"
              "$nameColumn TEXT, $microchipNumberColumn VARCHAR(20) UNIQUE, "
              "$speciesColumn TEXT, $birthDateColumn TEXT,"
              "$animalCastratedColumn INTEGER(0),$coatColorColumn VARCHAR(10),"
              "$breedColumn VARCHAR(2), $sizeCmColumn INTEGER(3),"
              "$dateMicrochipColumn TEXT, $commentsColumn TEXT, $createdByColumn TEXT,"
              "$createdDateColumn TEXT, "
              "$removedColumn INTEGER(1) DEFAULT 0, $registeredColumn INTEGER(1) DEFAULT 0,"
              "$editedColumn INTEGER(1) DEFAULT 0,"
              "$idVetColumn INTEGER, $idTutorColumn INTEGER,"
              "FOREIGN KEY($idVetColumn) REFERENCES $vetTable($idColumn), "
              "FOREIGN KEY($idTutorColumn) REFERENCES $tutorTable($idColumn))"
      );
      await db.execute(
          "CREATE TABLE $vetTable($idColumn INTEGER PRIMARY KEY,"
              "$crmvColumn VARCHAR(20) UNIQUE, $idUserColumn INTEGER UNIQUE,"
              "FOREIGN KEY($idUserColumn) REFERENCES $userTable($idColumn))"
      );
      await db.execute(
          "CREATE TABLE $tutorIncidentsTable($idColumn INTEGER PRIMARY KEY,"
              "$idIncidentsColumn INTEGER, $idTutorColumn INTEGER,"
              "FOREIGN KEY($idIncidentsColumn) REFERENCES $incidentsTable($idColumn),"
              "FOREIGN KEY($idTutorColumn) REFERENCES $tutorTable($idColumn))"
      );
      await db.execute(
          "CREATE TABLE $animalMedicationsTable($idColumn INTEGER PRIMARY KEY,"
              "$idAnimalColumn INTEGER, $idMedicationsColumn INTEGER,"
              "$dateMedicationColumn TEXT, "
              "FOREIGN KEY($idAnimalColumn) REFERENCES $animalTable($idColumn),"
              "FOREIGN KEY($idMedicationsColumn) REFERENCES $medicationsTable($idColumn))"
      );
    });
  }

  Future<UserLogin> saveContact(UserLogin user) async {
    Database dbContact = await db;
    user.id = await dbContact.insert(userLoginTable, user.toMap());
    return user;
  }

  Future<Medications> saveMedications(Medications medications) async {
    Database dbContact = await db;
    medications.id = await dbContact.insert(medicationsTable, medications.toMap());
    return medications;
  }

  Future<User> saveUser(User user) async {
    Database dbContact = await db;
    user.id = await dbContact.insert(userTable, user.toMap());
    return user;
  }

  Future<Tutor> saveTutor(Tutor tutor) async {
    Database dbContact = await db;
    tutor.id = await dbContact.insert(tutorTable, tutor.toMap());
    return tutor;
  }

  Future<Animal> saveAnimal(Animal animal) async {
    Database dbContact = await db;
    animal.id = await dbContact.insert(animalTable, animal.toMap());
    return animal;
  }

  Future<Vet> saveVet(Vet vet) async {
    Database dbContact = await db;
    if(vet.userId  != null)await dbContact.insert(userTable, vet.user.toMap());
    vet.id = await dbContact.insert(vetTable, vet.toMap());
    return vet;
  }

  Future<TutorsIncidents> saveTutorIncidents(TutorsIncidents tutorsIncidents) async {
    Database dbContact = await db;
    tutorsIncidents.id = await dbContact.insert(tutorIncidentsTable, tutorsIncidents.toMap());
    return tutorsIncidents;
  }

  Future<AnimalMedications> saveAnimalMedications(AnimalMedications animalMedications) async {
    Database dbContact = await db;
    animalMedications.id = await dbContact.insert(animalMedicationsTable, animalMedications.toMap());
    return animalMedications;
  }

  Future<Vet> saveOnlyVet(Vet vet) async {
    Database dbContact = await db;
    vet.id = await dbContact.insert(vetTable, vet.toMap());
    return vet;
  }

  Future<Incidents> saveIncidents(Incidents incidents) async {
    Database dbContact = await db;
    incidents.id = await dbContact.insert(incidentsTable, incidents.toMap());
    return incidents;
  }

  Future<int> updateMedication(Medications medications) async {
    Database dbContact = await db;
    return await dbContact.update(medicationsTable, medications.toMap(), where: "$idColumn = ?", whereArgs: [medications.id]);
  }

  Future<int> updateVet(Vet vet) async {
    Database dbContact = await db;
    return await dbContact.update(vetTable, vet.toMap(), where: "$idColumn = ?", whereArgs: [vet.id]);
  }

  Future<int> updateAnimal(Animal animal) async {
    Database dbContact = await db;
    return await dbContact.update(animalTable, animal.toMap(), where: "$idColumn = ?", whereArgs: [animal.id]);
  }

  Future<int> updateUser(User user) async {
    Database dbContact = await db;
    return await dbContact.update(userTable, user.toMap(), where: "$idColumn = ?", whereArgs: [user.id]);
  }

  Future<int> updateIncidents(Incidents incidents) async {
    Database dbContact = await db;
    return await dbContact.update(incidentsTable, incidents.toMap(), where: "$idColumn = ?", whereArgs: [incidents.id]);
  }

  Future<int> updateTutor(Tutor tutor) async {
    Database dbContact = await db;
    return await dbContact.update(tutorTable, tutor.toMap(), where: "$idColumn = ?", whereArgs: [tutor.id]);
  }

  Future<UserLogin> getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(userLoginTable,
        columns: [idColumn, nameColumn, emailColumn, cityColumn, stateColumn, passwordColumn, telephoneColumn1, telephoneColumn2],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if(maps.length > 0){
      return UserLogin.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<UserLogin> getContactEmail() async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(userLoginTable,
        columns: [idColumn, nameColumn, emailColumn, cityColumn, stateColumn, passwordColumn, telephoneColumn1, telephoneColumn2],
        where: "$emailColumn = ?",
        whereArgs: [LoginDatabase.email]);
    if(maps.length > 0){
      return UserLogin.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<Medications> getMedications(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(medicationsTable,
        columns: [idColumn, nameColumn, removedColumn, registeredColumn, editedColumn],
        where: "$idColumn == ?",
        whereArgs: [id]);
    if(maps.length > 0){
      return Medications.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<Animal> getAnimal(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.rawQuery("SELECT $animalTable.$idColumn, $animalTable.$nameColumn, $animalTable.$removedColumn, "
        "$animalTable.$registeredColumn, $animalTable.$editedColumn, $animalTable.$commentsColumn, "
        "$animalTable.$microchipNumberColumn, $animalTable.$speciesColumn, $animalTable.$birthDateColumn,"
        " $animalTable.$animalCastratedColumn ,$animalTable.$coatColorColumn, $tutorTable.$nameColumn as name,"
        "$animalTable.$breedColumn, $animalTable.$sizeCmColumn, $animalTable.$dateMicrochipColumn, "
        "$animalTable.$createdDateColumn, $animalTable.$idVetColumn, $animalTable.$idTutorColumn, $vetTable.$crmvColumn, $tutorTable.$cpfColumn "
        " FROM $animalTable JOIN $vetTable ON $vetTable.$idColumn = $animalTable.$idVetColumn"
        " JOIN $tutorTable ON $tutorTable.$idColumn = $animalTable.$idTutorColumn"
        " WHERE $animalTable.$idColumn == $id");
    if(maps.length > 0){
      return Animal.fromMap(maps.first);
    } else {
      return null;
    }
  }


  Future<Incidents> getIncidents(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(incidentsTable,
        columns: [idColumn, nameColumn, commentsColumn, removedColumn, registeredColumn, editedColumn],
        where: "$idColumn == ?",
        whereArgs: [id]);
    if(maps.length > 0){
      return Incidents.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<User> getUser(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(userTable,
        columns: [idColumn, nameColumn, emailColumn, cityColumn,
          stateColumn, telephoneColumn1, telephoneColumn2, levelsOfAccessColumn,
          removedColumn, registeredColumn, editedColumn],
        where: "$idColumn == ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<Vet> getVet(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(vetTable,
        columns: [idColumn, crmvColumn, idUserColumn],
        where: "$idUserColumn == ?",
        whereArgs: [id]);
    if(maps.length > 0){
      return Vet.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<Vet> getVetByCrmv(String crmv) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(vetTable,
        columns: [idColumn, crmvColumn, idUserColumn],
        where: "$crmvColumn == ?",
        whereArgs: [crmv]);
    if(maps.length > 0){
      return Vet.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<Tutor> getTutor(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(tutorTable,
        columns: [idColumn, nameColumn, motherNameColumn,
          cpfColumn, rgColumn, cityColumn, streetColumn, numberColumn,
          cepColumn, streetColumn, neighborhoodColumn, complementColumn, professionColumn,
          stateColumn, telephoneColumn1, telephoneColumn2,
          removedColumn, registeredColumn, editedColumn],
        where: "$idColumn == ?",
        whereArgs: [id]);
    if(maps.length > 0){
      return Tutor.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<Tutor> getTutorByCpf(String cpf) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(tutorTable,
        columns: [idColumn, nameColumn, motherNameColumn,
          cpfColumn, rgColumn, cityColumn, streetColumn, numberColumn,
          cepColumn, streetColumn, neighborhoodColumn, complementColumn, professionColumn,
          stateColumn, telephoneColumn1, telephoneColumn2,
          removedColumn, registeredColumn, editedColumn],
        where: "$cpfColumn == ?",
        whereArgs: [cpf]);
    if(maps.length > 0){
      return Tutor.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await db;
    return await dbContact.delete(userLoginTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> deleteTutorIncidents(int id) async {
    Database dbContact = await db;
    return await dbContact.delete(tutorIncidentsTable, where: "$idTutorColumn = ?", whereArgs: [id]);
  }

  Future<int> deleteMedicationsByIdAnimal(int id) async {
    Database dbContact = await db;
    return await dbContact.delete(animalMedicationsTable, where: "$idAnimalColumn = ?", whereArgs: [id]);
  }

  Future<int> deleteMedications(int id) async {
    Database dbContact = await db;
    return await dbContact.delete(medicationsTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateContact(UserLogin contact) async {
    Database dbContact = await db;
    return await dbContact.update(userLoginTable,
        contact.toMap(),
        where: "$idColumn = ?",
        whereArgs: [contact.id]);
  }

  Future<int> truncateUserLogin() async {
    Database dbContact = await db;
    return await dbContact.delete(userLoginTable);
  }

  Future<int> truncateTutor() async {
    Database dbContact = await db;
    return await dbContact.delete(tutorTable);
  }

  Future<int> truncateAnimal() async {
    Database dbContact = await db;
    return await dbContact.delete(animalTable);
  }

  Future<int> truncateIncidents() async {
    Database dbContact = await db;
    return await dbContact.delete(incidentsTable);
  }

  Future<int> truncateUsers() async {
    Database dbContact = await db;
    return await dbContact.delete(userTable);
  }

  Future<int> truncateIncidentsWithTutor() async {
    Database dbContact = await db;
    return await dbContact.delete(tutorIncidentsTable);
  }

  Future<int> truncateAnimalMedications() async {
    Database dbContact = await db;
    return await dbContact.delete(animalMedicationsTable);
  }


  Future<int> truncateVets() async {
    Database dbContact = await db;
    return await dbContact.delete(vetTable);
  }

  Future<int> truncateMedications() async {
    Database dbContact = await db;
    return await dbContact.delete(medicationsTable);
  }

  Future<List> getAllContacts() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $userLoginTable");
    List<UserLogin> listContact = List();
    for(Map m in listMap){
      listContact.add(UserLogin.fromMap(m));
    }
    return listContact;
  }

  Future<List> getAllMedications() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $medicationsTable WHERE $removedColumn == 0");
    List<Medications> listContact = List();
    for(Map m in listMap){
      listContact.add(Medications.fromMap(m));
    }
    return listContact;
  }

  Future<List> getAllAnimals() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $animalTable WHERE $removedColumn == 0");
    List<Animal> listContact = List();
    for(Map m in listMap){
      listContact.add(Animal.fromMap(m));
    }
    return listContact;
  }

  Future<List> getAllAnimalsRemoved() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $animalTable WHERE $removedColumn == 1");
    List<Animal> listContact = List();
    for(Map m in listMap){
      listContact.add(Animal.fromMap(m));
    }
    return listContact;
  }

  Future<List> getAllUser() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $userTable WHERE $removedColumn == 0");
    List<User> listContact = List();
    for(Map m in listMap){
      listContact.add(User.fromMap(m));
    }
    return listContact;
  }

  Future<List> getAllUserRemoved() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $userTable WHERE $removedColumn == 1");
    List<User> listContact = List();
    for(Map m in listMap){
      listContact.add(User.fromMap(m));
    }
    return listContact;
  }

  Future<List> getAllIncidents() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $incidentsTable WHERE $removedColumn == 0");
    List<Incidents> listContact = List();
    for(Map m in listMap){
      listContact.add(Incidents.fromMap(m));
    }
    return listContact;
  }

  Future<List> getAllIncidentsRemoved() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $incidentsTable WHERE $removedColumn == 1");
    List<Incidents> listContact = List();
    for(Map m in listMap){
      listContact.add(Incidents.fromMap(m));
    }
    return listContact;
  }

  Future<List> getAllMedicationsRemoved() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $medicationsTable WHERE $removedColumn == 1");
    List<Medications> listContact = List();
    for(Map m in listMap){
      listContact.add(Medications.fromMap(m));
    }
    return listContact;
  }

  Future<List> getAllIncidentsWhere(column, value) async {
    Database dbContact = await db;
    var columnName;
    List listMap;
    value = value.replaceAll("\'", "");
    switch(column){
      case "Nome":
        columnName = nameColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $incidentsTable WHERE $removedColumn == 0 AND $columnName == '$value' LIMIT 1");
        break;
      case "Removidos":
        columnName = nameColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $incidentsTable WHERE $removedColumn == 1 AND $columnName == '$value' LIMIT 1");
        break;
    }
    List<Incidents> listContact = List();
    for(Map m in listMap){
      listContact.add(Incidents.fromMap(m));
    }
    return listContact;
  }

  Future<List> getAllMedicationsWhere(column, value) async {
    Database dbContact = await db;
    var columnName;
    List listMap;
    value = value.replaceAll("\'", "");
    switch(column){
      case "Nome":
        columnName = nameColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $medicationsTable WHERE $removedColumn == 0 AND $columnName == '$value' LIMIT 1");
        break;
      case "Removidos":
        columnName = nameColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $medicationsTable WHERE $removedColumn == 1 AND $columnName == '$value' LIMIT 1");
        break;
    }
    List<Medications> listContact = List();
    for(Map m in listMap){
      listContact.add(Medications.fromMap(m));
    }
    return listContact;
  }

  Future<List> getAllAnimalsWhere(column, value) async {
    Database dbContact = await db;
    var columnName;
    List listMap;
    value = value.replaceAll("\'", "");
    switch(column){
      case "Nome":
        columnName = nameColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $animalTable WHERE $removedColumn == 0 AND $columnName == '$value' LIMIT 1");
        break;
      case "Microchip":
        columnName = microchipNumberColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $animalTable WHERE $removedColumn == 0 AND $columnName == '$value' LIMIT 1");
        break;
      case "Espécie":
        columnName = speciesColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $animalTable WHERE $removedColumn == 0 AND $columnName == '$value' LIMIT 1");
        break;
      case "Raça":
        columnName = breedColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $animalTable WHERE $removedColumn == 0 AND $columnName == '$value' LIMIT 1");
        break;
      case "Removidos":
        columnName = nameColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $animalTable WHERE $removedColumn == 1 AND $columnName == '$value' LIMIT 1");
        break;
    }
    List<Animal> listContact = List();
    for(Map m in listMap){
      listContact.add(Animal.fromMap(m));
    }
    return listContact;
  }

  Future<List> getAllUsersWhere(column, value) async {
    Database dbContact = await db;
    var columnName;
    List listMap;
    value = value.replaceAll("\'", "");
    switch(column){
      case "Nome":
        columnName = nameColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $userTable WHERE $removedColumn == 0 AND $columnName == '$value' LIMIT 1");
        break;
      case "Email":
        columnName = emailColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $userTable WHERE $removedColumn == 0 AND $columnName == '$value' LIMIT 1");
        break;
      case "Removidos":
        columnName = nameColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $userTable WHERE $removedColumn == 1 AND $columnName == '$value' LIMIT 1");
        break;
    }
    List<User> listContact = List();
    for(Map m in listMap){
      listContact.add(User.fromMap(m));
    }
    return listContact;
  }

  Future<List> getAllTutorWhere(column, value) async {
    Database dbContact = await db;
    var columnName;
    List listMap;
    value = value.replaceAll("\'", "");
    switch(column){
      case "Nome":
        columnName = nameColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tutorTable WHERE $removedColumn == 0 AND $columnName == '$value' LIMIT 1");
        break;
      case "CPF":
        columnName = cpfColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tutorTable WHERE $removedColumn == 0 AND $columnName == '$value' LIMIT 1");
        break;
      case "RG":
        columnName = rgColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tutorTable WHERE $removedColumn == 0 AND $columnName == '$value' LIMIT 1");
        break;
      case "Removidos":
        columnName = nameColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tutorTable WHERE $removedColumn == 1 AND $columnName == '$value' LIMIT 1");
        break;
    }
    List<Tutor> listContact = List();
    for(Map m in listMap){
      listContact.add(Tutor.fromMap(m));
    }
    return listContact;
  }

  Future<List> getAllIncidentsByIdTutor(int id) async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT $tutorIncidentsTable.$idColumn, $tutorIncidentsTable.$idIncidentsColumn,"
        " $incidentsTable.$nameColumn"
        " FROM $tutorIncidentsTable"
        " JOIN $incidentsTable ON $incidentsTable.$idColumn = $tutorIncidentsTable.$idIncidentsColumn"
        " WHERE $idTutorColumn == $id");
    List<TutorsIncidents> listContact = List();
    for(Map m in listMap){
      listContact.add(TutorsIncidents.fromMap(m));
    }
    return listContact;
  }

  Future<List> getAllMedicationsByIdAnimal(int id) async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT $animalMedicationsTable.$idColumn, $animalMedicationsTable.$idMedicationsColumn,"
        " $animalMedicationsTable.$dateMedicationColumn, $medicationsTable.$nameColumn"
        " FROM $animalMedicationsTable"
        " JOIN $medicationsTable ON $medicationsTable.$idColumn = $animalMedicationsTable.$idMedicationsColumn"
        " WHERE $idAnimalColumn == $id");
    List<AnimalMedications> listContact = List();
    for(Map m in listMap){
      listContact.add(AnimalMedications.fromMap(m));
    }
    return listContact;
  }

  Future<List> getAllTutors() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $tutorTable WHERE $removedColumn == 0");
    List<Tutor> listContact = List();
    for(Map m in listMap){
      listContact.add(Tutor.fromMap(m));
    }
    return listContact;
  }

  Future<List> getAllTutorsRemoved() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $tutorTable WHERE $removedColumn == 1");
    List<Tutor> listContact = List();
    for(Map m in listMap){
      listContact.add(Tutor.fromMap(m));
    }
    return listContact;
  }

  Future<List> getLike(title, column, value) async {
    Database dbContact = await db;
    var tableName;
    var columnName;
    List listMap;
    value = value.replaceAll("\'", "");
    switch(title){
      case "Incidentes":
        tableName = incidentsTable;
        break;
      case "Medicações":
        tableName = medicationsTable;
        break;
      case "Animais":
        tableName = animalTable;
        break;
      case "Usuários":
        tableName = userTable;
        break;
      case "Tutores":
        tableName = tutorTable;
        break;
    }
    switch(column){
      case "Nome":
        columnName = nameColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tableName WHERE $removedColumn == 0 AND $columnName LIKE '$value%' LIMIT 5");
        break;
      case "Microchip":
        columnName = microchipNumberColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tableName WHERE $removedColumn == 0 AND $columnName LIKE '$value%' LIMIT 5");
        break;
      case "Espécie":
        columnName = speciesColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tableName WHERE $removedColumn == 0 AND $columnName LIKE '$value%' LIMIT 5");
        break;
      case "Raça":
        columnName = breedColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tableName WHERE $removedColumn == 0 AND $columnName LIKE '$value%' LIMIT 5");
        break;
      case "Email":
        columnName = emailColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tableName WHERE $removedColumn == 0 AND $columnName LIKE '$value%' LIMIT 5");
        break;
      case "CPF":
        columnName = cpfColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tableName WHERE $removedColumn == 0 AND $columnName LIKE '$value%' LIMIT 5");
        break;
      case "RG":
        columnName = rgColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tableName WHERE $removedColumn == 0 AND $columnName LIKE '$value%' LIMIT 5");
        break;
      case "Removidos":
        columnName = nameColumn;
        listMap = await dbContact.rawQuery("SELECT * FROM $tableName WHERE $removedColumn == 1 AND $columnName LIKE '$value%' LIMIT 5");
        break;
    }
    List listContact = List();
    for(Map m in listMap){
      listContact.add(m[columnName]);
    }
    return listContact;
  }

  Future<int> getNumber() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(await dbContact.rawQuery("SELECT COUNT(*) FROM $userLoginTable"));
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }

}