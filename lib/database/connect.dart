import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/database/columns_names.dart';

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
              "$nameColumn TEXT NOT NULL, $emailColumn VARCHAR(255) UNIQUE NOT NULL,"
              "$passwordColumn TEXT NOT NULL, $telephoneColumn1 TEXT NOT NULL, $telephoneColumn2 TEXT,"
              "$cityColumn TEXT NOT NULL, $stateColumn VARCHAR(2) NOT NULL, $levelsOfAccessColumn VARCHAR(10) NOT NULL)"
      );
      await db.execute(
          "CREATE TABLE $medicationsTable($idColumn INTEGER PRIMARY KEY,"
              "$nameColumn TEXT UNIQUE NOT NULL, $createdByColumn TEXT, $lastModifiedByColumn TEXT,"
              "$createdDateColumn TEXT, $removedColumn INTEGER(1) DEFAULT 0, $registeredColumn INTEGER(1) DEFAULT 0,"
              "$editedColumn INTEGER(1) DEFAULT 0)"
      );
      await db.execute(
          "CREATE TABLE $incidentsTable($idColumn INTEGER PRIMARY KEY,"
              "$nameColumn TEXT UNIQUE NOT NULL, $lastModifiedByColumn TEXT, $commentsColumn TEXT NOT NULL, $createdByColumn TEXT,"
              "$createdDateColumn TEXT, $removedColumn INTEGER(1) DEFAULT 0, $registeredColumn INTEGER(1) DEFAULT 0,"
              "$editedColumn INTEGER(1) DEFAULT 0)"
      );
      await db.execute(
          "CREATE TABLE $userTable($idColumn INTEGER PRIMARY KEY,"
              "$nameColumn TEXT NOT NULL, $emailColumn VARCHAR(255) UNIQUE NOT NULL,"
              " $telephoneColumn1 TEXT NOT NULL, $telephoneColumn2 TEXT,"
              "$cityColumn TEXT NOT NULL, $stateColumn VARCHAR(2) NOT NULL,$createdByColumn TEXT,"
              "$createdDateColumn TEXT, $levelsOfAccessColumn VARCHAR(10) NOT NULL,"
              "$removedColumn INTEGER(1) DEFAULT 0, $registeredColumn INTEGER(1) DEFAULT 0,"
              "$editedColumn INTEGER(1) DEFAULT 0)"
      );
      await db.execute(
          "CREATE TABLE $tutorTable($idColumn INTEGER PRIMARY KEY,"
              "$nameColumn TEXT NOT NULL, $lastModifiedByColumn TEXT, $motherNameColumn TEXT NOT NULL, "
              "$telephoneColumn1 TEXT NOT NULL, $telephoneColumn2 TEXT,"
              "$cpfColumn VARCHAR(15) NOT NULL,$rgColumn VARCHAR(10) NOT NULL, $stateColumn VARCHAR(2) NOT NULL, $cityColumn TEXT NOT NULL,"
              "$cepColumn VARCHAR(15) NOT NULL, $neighborhoodColumn TEXT NOT NULL, "
              "$streetColumn TEXT NOT NULL, $numberColumn INTEGER(5) NOT NULL, $professionColumn TEXT NOT NULL, "
              "$complementColumn TEXT, $createdByColumn TEXT,"
              "$createdDateColumn TEXT, "
              "$removedColumn INTEGER(1) DEFAULT 0, $registeredColumn INTEGER(1) DEFAULT 0,"
              "$editedColumn INTEGER(1) DEFAULT 0)"
      );
      await db.execute(
          "CREATE TABLE $animalTable($idColumn INTEGER PRIMARY KEY,"
              "$nameColumn TEXT NOT NULL, $lastModifiedByColumn TEXT, $microchipNumberColumn VARCHAR(20) UNIQUE NOT NULL, "
              "$speciesColumn TEXT NOT NULL,"
              "$genreColumn TEXT NOT NULL, $castratedColumn tinyint(1) NOT NULL,"
              "$birthDateColumn TEXT NOT NULL,"
              "$coatColorColumn VARCHAR(10) NOT NULL,"
              "$breedColumn VARCHAR(2) NOT NULL, $sizeCmColumn VARCHAR(13) NOT NULL,"
              "$dateMicrochipColumn TEXT NOT NULL, $commentsColumn TEXT, $createdByColumn TEXT,"
              "$createdDateColumn TEXT, "
              "$removedColumn INTEGER(1) DEFAULT 0, $registeredColumn INTEGER(1) DEFAULT 0,"
              "$editedColumn INTEGER(1) DEFAULT 0,"
              "$idVetColumn INTEGER NOT NULL, $idTutorColumn INTEGER NOT NULL,"
              "FOREIGN KEY($idVetColumn) REFERENCES $vetTable($idColumn), "
              "FOREIGN KEY($idTutorColumn) REFERENCES $tutorTable($idColumn))"
      );
      await db.execute(
          "CREATE TABLE $vetTable($idColumn INTEGER PRIMARY KEY,"
              "$crmvColumn VARCHAR(20) UNIQUE NOT NULL, $idUserColumn INTEGER UNIQUE NOT NULL,"
              "FOREIGN KEY($idUserColumn) REFERENCES $userTable($idColumn))"
      );
      await db.execute(
          "CREATE TABLE $tutorIncidentsTable("
              "$idIncidentsColumn INTEGER NOT NULL, $idTutorColumn INTEGER NOT NULL,"
              "FOREIGN KEY($idIncidentsColumn) REFERENCES $incidentsTable($idColumn),"
              "FOREIGN KEY($idTutorColumn) REFERENCES $tutorTable($idColumn))"
      );
      await db.execute(
          "CREATE TABLE $animalMedicationsTable($idAnimalColumn INTEGER NOT NULL, $idMedicationsColumn INTEGER NOT NULL,"
              "$dateMedicationColumn TEXT NOT NULL, "
              "FOREIGN KEY($idAnimalColumn) REFERENCES $animalTable($idColumn),"
              "FOREIGN KEY($idMedicationsColumn) REFERENCES $medicationsTable($idColumn))"
      );
    });
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }

}