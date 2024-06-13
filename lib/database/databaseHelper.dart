import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:app_bee/models/specie.dart';
import 'package:app_bee/models/typeHive.dart';
import 'package:app_bee/models/hive.dart';
import 'package:app_bee/models/apiary.dart';
import 'package:app_bee/models/honeyBox.dart';
import 'package:app_bee/models/floralResource.dart';

// Classe singleton para gerenciar o banco de dados
class DatabaseHelper {
  // Instância única da classe
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  // Construtor interno
  DatabaseHelper._internal();

  // Getter para o banco de dados
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inicializa o banco de dados
  Future<Database> _initDatabase() async {
    // Obtém o caminho do banco de dados no dispositivo
    String path = join(await getDatabasesPath(), 'bee.db');
    // Abre o banco de dados e chama _onCreate se o banco de dados ainda não existir
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Cria a tabela de species
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE species(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, created_at TEXT, updated_at TEXT)',
    );
    await db.execute(
      'CREATE TABLE types_hives(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, created_at TEXT, updated_at TEXT)',
    );
    await db.execute(
      'CREATE TABLE floral_resources(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, created_at TEXT, updated_at TEXT)',
    );
    await db.execute(
      'CREATE TABLE apiaries(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, created_at TEXT, updated_at TEXT)',
    );
    await db.execute(
      'CREATE TABLE apiaries_floral_resources(apiary_id INTEGER, floral_resource_id INTEGER, FOREIGN KEY (apiary_id) REFERENCES apiaries (id), FOREIGN KEY (floral_resource_id) REFERENCES floral_resources (id), PRIMARY KEY (apiary_id, floral_resource_id))',
    );
    await db.execute(
      'CREATE TABLE honey_boxes(id INTEGER PRIMARY KEY AUTOINCREMENT, number_frames INTEGER, busy_frames INTEGER, type_hive_id INTEGER REFERENCES types_hives(id), created_at TEXT, updated_at TEXT)',
    );

/*
    await db.execute(
      'CREATE TABLE hives(id INTEGER PRIMARY KEY AUTOINCREMENT, specie_id INTEGER, type_hive_id INTEGER, FOREIGN KEY (specie_id) REFERENCES species (id), FOREIGN KEY (type_hive_id) REFERENCES types_hives (id), specie_id, created_at TEXT, updated_at TEXT)',
    );
    */
  }

  // Insere um novo Specie no banco de dados
  Future<void> insertSpecie(Specie specie) async {
    final db = await database;
    await db.insert(
      'species',
      specie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Recupera species os species do banco de dados

  Future<List<Specie>> getSpecies() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('species');

    return List.generate(maps.length, (i) {
      return Specie.fromMap(maps[i]);
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

  // Insere um novo Floral Resources no banco de dados
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

  // Insere uma nova Hive no banco de dados
  Future<void> insertHive(Hive hive) async {
    final db = await database;
    await db.insert(
      'hives',
      hive.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Recupera hives os hives do banco de dados

  Future<List<Hive>> getHives() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('hives');

    return List.generate(maps.length, (i) {
      return Hive.fromMap(maps[i]);
    });
  }

// Insere um novo Apiary no banco de dados
  Future<void> insertApiary(Apiary apiary, List fResources) async {
    final db = await database;
    await db.transaction((txn) async {
      int apiaryId = await txn.insert(
        'apiaries',
        apiary.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      for (var fResource in fResources) {
        await txn.insert(
          'apiaries_floral_resources',
          {
            'apiary_id': apiaryId,
            'floral_resource_id': fResource.id,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

// Recupera os Apiaries do banco de dados
  Future<List<Apiary>> getApiaries() async {
    final db = await database;
    final List<Map<String, dynamic>> apiaryMaps = await db.query('apiaries');

    List<Apiary> apiaries = [];
    for (var apiaryMap in apiaryMaps) {
      int apiaryId = apiaryMap['id'];

      final List<Map<String, dynamic>> floralResourceMaps = await db.query(
        'apiaries_floral_resources',
        where: 'apiary_id = ?',
        whereArgs: [apiaryId],
      );

      List<FloralResource> floralResources = [];
      for (var floralResourceMap in floralResourceMaps) {
        int floralResourceId = floralResourceMap['floral_resource_id'];

        final List<Map<String, dynamic>> resourceMap = await db.query(
          'floral_resources',
          where: 'id = ?',
          whereArgs: [floralResourceId],
        );

        if (resourceMap.isNotEmpty) {
          floralResources.add(FloralResource.fromMap(resourceMap.first));
        }
      }

      apiaries.add(
          Apiary.fromMap(apiaryMap).copyWith(floralResources: floralResources));
    }

    return apiaries;
  }

  // Insere um novo Floral Resources no banco de dados
  Future<void> insertHoneyBox(HoneyBox honeyBox) async {
    final db = await database;
    print("Estou na Table Honey BOx");
    // Comando para listar todas as tabelas no banco de dados

    List<Map<String, dynamic>> tables =
        await db.rawQuery("SELECT * FROM sqlite_master WHERE type='table'");

    // Imprime as tabelas existentes
    print("Tabelas no banco de dados:");
    tables.forEach((table) {
      print(table['name']);
    });

    await db.insert(
      'honey_boxes',
      honeyBox.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Recupera Floral Resources do banco de dados

  Future<List<HoneyBox>> getHoneyBoxes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('honey_boxes');

    return List.generate(maps.length, (i) {
      return HoneyBox.fromMap(maps[i]);
    });
  }
}
