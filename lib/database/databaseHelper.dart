import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:app_bee/models/typeHive.dart';
import 'package:app_bee/models/hive.dart';
import 'package:app_bee/models/floralResource.dart';
import 'dart:developer';
import 'dart:math';

// Classe singleton para gerenciar o banco de dados
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'bee.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createTableSpecies(db);
    await _createTableTypesInspections(db);
    await _createTableTypesHives(db);
    await _createTableFloralResources(db);
    await _createTableApiaries(db);
    await _createTableApiariesFloralResources(db);
    await _createTableHoneyBoxes(db);
    await _createTableHives(db);
    await _createTableProducts(db);
    await _createTableEnvironmentData(db);
    await _createTablePopulationData(db);
    await _createTableInspections(db);
    await _createTableTypesExpenses(db);
    await _createTableExpenses(db);
    print("Database tables created successfully!");
    await _insertInitialData(db);
    print("Database initialized with initial data!");
  }

  Future<void> _createTableSpecies(Database db) async {
    await db.execute('''
      CREATE TABLE species (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        created_at TEXT,
        updated_at TEXT
      )
    ''');
  }

  Future<void> _createTableTypesInspections(Database db) async {
    await db.execute('''
      CREATE TABLE types_inspections (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        created_at TEXT,
        updated_at TEXT
      )
    ''');
  }

  Future<void> _createTableTypesHives(Database db) async {
    await db.execute('''
      CREATE TABLE types_hives (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        created_at TEXT,
        updated_at TEXT
      )
    ''');
  }

  Future<void> _createTableFloralResources(Database db) async {
    await db.execute('''
      CREATE TABLE floral_resources (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        created_at TEXT,
        updated_at TEXT
      )
    ''');
  }

  Future<void> _createTableApiaries(Database db) async {
    await db.execute('''
      CREATE TABLE apiaries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        city_id INTEGER,
        state_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        created_at TEXT,
        updated_at TEXT
      )
    ''');
  }

  Future<void> _createTableApiariesFloralResources(Database db) async {
    await db.execute('''
      CREATE TABLE apiaries_floral_resources (
        apiary_id INTEGER NOT NULL,
        floral_resource_id INTEGER,
        FOREIGN KEY (apiary_id) REFERENCES apiaries (id),
        FOREIGN KEY (floral_resource_id) REFERENCES floral_resources (id),
        PRIMARY KEY (apiary_id, floral_resource_id)
      )
    ''');
  }

  Future<void> _createTableHoneyBoxes(Database db) async {
    await db.execute('''
      CREATE TABLE honey_boxes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tag TEXT NOT NULL,
        busy INTEGER NOT NULL CHECK (busy IN (0, 1)),
        number_frames INTEGER,
        busy_frames INTEGER,
        type_hive_id INTEGER REFERENCES types_hives(id),
        created_at TEXT,
        updated_at TEXT
      )
    ''');
  }

  Future<void> _createTableHives(Database db) async {
    await db.execute('''
      CREATE TABLE hives (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        honey_box_id INTEGER REFERENCES honey_boxes(id),
        apiary_id INTEGER REFERENCES apiaries(id),
        specie_id INTEGER REFERENCES species(id),
        created_at TEXT,
        updated_at TEXT
      )
    ''');
  }

  Future<void> _createTableProducts(Database db) async {
    await db.execute('''
      CREATE TABLE collects (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        honey REAL,
        propolis REAL,
        wax REAL,
        royal_jelly REAL,
        hive_id INTEGER REFERENCES hives(id),
        apiary_id INTEGER REFERENCES apiaries(id),
        created_at TEXT,
        updated_at TEXT
      )
    ''');
  }

  Future<void> _createTableEnvironmentData(Database db) async {
    await db.execute('''
      CREATE TABLE environment_data (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        internal_temperature REAL,
        external_temperature REAL,
        internal_humidity REAL,
        external_humidity REAL,
        wind_speed REAL,
        cloud INT,
        created_at TEXT,
        updated_at TEXT
      )
    ''');
  }

  Future<void> _createTablePopulationData(Database db) async {
    await db.execute('''
      CREATE TABLE population_data (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        number_bees INT,
        age_queen REAL,
        spawning_queen TEXT,
        larvae_presence_distribution TEXT,
        larvae_health_development TEXT,
        pupa_presence_distribution TEXT,
        pupa_health_development TEXT,
        created_at TEXT,
        updated_at TEXT
      )
    ''');
  }

  Future<void> _createTableInspections(Database db) async {
    await db.execute('''
      CREATE TABLE inspections (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        hive_id INTEGER REFERENCES hives(id),
        apiary_id INTEGER REFERENCES apiaries(id),
        type_inspection_id TEXT,
        population_data_id INTEGER REFERENCES population_data(id),
        environment_data_id INTEGER REFERENCES environment_data(id),
        created_at TEXT,
        updated_at TEXT
      )
    ''');
  }

  Future<void> _createTableTypesExpenses(Database db) async {
    await db.execute('''
      CREATE TABLE types_expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        created_at TEXT,
        updated_at TEXT
      )
    ''');
  }

  Future<void> _createTableExpenses(Database db) async {
    await db.execute('''
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cost REAL NOT NULL,
        apiary_id INTEGER,
        date TEXT NOT NULL,
        type_expense_id INTEGER REFERENCES types_expenses(id),
        created_at TEXT,
        updated_at TEXT
      )
    ''');
  }

  Future<void> _insertInitialData(Database db) async {
    await _insertInitialSpecies(db);
    await _insertInitialTypesHives(db);
    await _insertInitialTypesInspections(db);
    await _insertInitialFloralResources(db);
    await _insertInitialTypesExpenses(db);
    await _insertInitialHoneyBoxes(db);
  }

  Future<void> _insertInitialSpecies(Database db) async {
    const initialSpecies = [
      {
        'name': 'Apis mellifera',
        'created_at': '2023-06-28',
        'updated_at': '2023-06-28'
      },
      {
        'name': 'Apis cerana',
        'created_at': '2023-06-28',
        'updated_at': '2023-06-28'
      },
      // Mais espécies aqui...
    ];
    for (var species in initialSpecies) {
      await db.insert('species', species);
    }
  }

  Future<void> _insertInitialTypesHives(Database db) async {
    const initialTypesHives = [
      {
        'name': 'Langstroth',
        'created_at': '2023-06-28',
        'updated_at': '2023-06-28'
      },
      {
        'name': 'Top-bar',
        'created_at': '2023-06-28',
        'updated_at': '2023-06-28'
      },
      {'name': 'Pnn', 'created_at': '2023-06-28', 'updated_at': '2023-06-28'},
      // Mais tipos de colmeias aqui...
    ];
    for (var typeHive in initialTypesHives) {
      await db.insert('types_hives', typeHive);
    }
  }

  Future<void> _insertInitialTypesInspections(Database db) async {
    const initialTypesInspections = [
      {
        'name': 'Rotina',
        'created_at': '2023-06-28',
        'updated_at': '2023-06-28'
      },
      {
        'name': 'Coleta',
        'created_at': '2023-06-28',
        'updated_at': '2023-06-28'
      },
      // Mais tipos de inspeções aqui...
    ];
    for (var typeInspection in initialTypesInspections) {
      await db.insert('types_inspections', typeInspection);
    }
  }

  Future<void> _insertInitialFloralResources(Database db) async {
    const initialFloralResources = [
      {
        'name': 'Aroeira',
        'created_at': '2023-06-28',
        'updated_at': '2023-06-28'
      },
      {
        'name': 'Mameleiro',
        'created_at': '2023-06-28',
        'updated_at': '2023-06-28'
      },
      {
        'name': 'Angico',
        'created_at': '2023-06-28',
        'updated_at': '2023-06-28'
      },
      {
        'name': 'Bamburrar',
        'created_at': '2023-06-28',
        'updated_at': '2023-06-28'
      },
      // Mais recursos florais aqui...
    ];
    for (var floralResource in initialFloralResources) {
      await db.insert('floral_resources', floralResource);
    }
  }

  Future<void> _insertInitialTypesExpenses(Database db) async {
    const initialTypesExpenses = [
      {
        'name': 'Food Supplies',
        'created_at': '2023-06-28',
        'updated_at': '2023-06-28'
      },
      {
        'name': 'Veterinary Services',
        'created_at': '2023-06-28',
        'updated_at': '2023-06-28'
      },
      // Mais tipos de despesas aqui...
    ];
    for (var typeExpense in initialTypesExpenses) {
      await db.insert('types_expenses', typeExpense);
    }
  }

  Future<void> _insertInitialHoneyBoxes(Database db) async {
    final Random random = Random();

    List<Map<String, dynamic>> honeyBoxes = [];

    for (int i = 1; i <= 10; i++) {
      String tag = 'LANG${i.toString().padLeft(2, '0')}';
      int busy = 1;
      int numberFrames = random.nextInt(5) + 4; // Valores aleatórios de 4 a 8
      int busyFrames =
          random.nextInt(numberFrames + 1); // Menor ou igual a numberFrames
      int typeHiveId = random.nextInt(3) + 1; // Random number 1, 2, or 3

      honeyBoxes.add({
        'tag': tag,
        'busy': busy,
        'number_frames': numberFrames,
        'busy_frames': busyFrames,
        'type_hive_id': typeHiveId,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    }

    honeyBoxes.forEach((honeyBox) async {
      await db.insert('honey_boxes', honeyBox);
    });
  }

  // Insere um novo TypeHive no banco de dados
  Future<void> insertTypeHive(TypeHive typeHive) async {
    final db = await database;
    await db.insert(
      'types_hives',
      typeHive.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Recupera TypeHives do banco de dados
  Future<List<TypeHive>> getTypesHives() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('types_hives');

    return List.generate(maps.length, (i) {
      return TypeHive.fromMap(maps[i]);
    });
  }

  // Insere um novo Floral Resource no banco de dados
  Future<void> insertFloralResource(FloralResource floralResource) async {
    final db = await database;
    await db.insert(
      'floral_resources',
      floralResource.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Recupera Floral Resources do banco de dados
  Future<List<FloralResource>> getFloralResources() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('floral_resources');

    return List.generate(maps.length, (i) {
      return FloralResource.fromMap(maps[i]);
    });
  }

  // Insere um novo Apiary no banco de dados
}
