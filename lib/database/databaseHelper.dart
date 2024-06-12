import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:app_bee/models/specie.dart';
import 'package:app_bee/models/typeHive.dart';
import 'package:app_bee/models/hive.dart';
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
    print("Estou no DBBBBBBBBBBBBBBBBBBBBBBBBB");
    await db.execute(
      'CREATE TABLE typesHives(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, created_at TEXT, updated_at TEXT)',
    );
    await db.execute(
      'CREATE TABLE floralResources(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, created_at TEXT, updated_at TEXT)',
    );
    await db.execute(
      'CREATE TABLE apiaries(id INTEGER PRIMARY KEY AUTOINCREMENT, floralResourcesId INTEGER REFERENCES floralResource(id), created_at TEXT, updated_at TEXT)',
    );

    await db.execute(
      'CREATE TABLE hives(id INTEGER PRIMARY KEY AUTOINCREMENT, typeHiveId INTEGER REFERENCES typesHives(id),specieId INTEGER REFERENCES species(id), apiaryId INTEGER REFERENCES apiaries(id), created_at TEXT, updated_at TEXT)',
    );
    print("Estou no DBBBBBBBBBBBBBBBBBBBBBBBBB");
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
      'typesHives',
      typeHive.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Recupera TypeHives do banco de dados

  Future<List<TypeHive>> getTypesHives() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('typesHives');

    return List.generate(maps.length, (i) {
      return TypeHive.fromMap(maps[i]);
    });
  }

  // Insere um novo Floral Resources no banco de dados
  Future<void> insertFloralResource(FloralResource floralResource) async {
    final db = await database;
    await db.insert(
      'floralResources',
      floralResource.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Recupera Floral Resources do banco de dados

  Future<List<FloralResource>> getFloralResources() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('floralResources');

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
}
