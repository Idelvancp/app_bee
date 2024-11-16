import 'package:sqflite/sqflite.dart';
import 'package:app_bee/models/floralResource.dart';
import 'package:app_bee/database/databaseHelper.dart';

class FloralResourcesDatabase {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

// Insere um novo Floral Resource no banco de dados
  Future<void> insertFloralResource(FloralResource floralResource) async {
    final db = await _databaseHelper.database;
    await db.insert(
      'floral_resources',
      floralResource.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// Recupera Floral Resources do banco de dados
  Future<List<FloralResource>> getFloralResources() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('floral_resources');

    return List.generate(maps.length, (i) {
      return FloralResource.fromMap(maps[i]);
    });
  }
}
