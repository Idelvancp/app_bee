// specie_database.dart

import 'package:sqflite/sqflite.dart';
import 'package:app_bee/models/specie.dart';
import 'package:app_bee/database/databaseHelper.dart';

class SpecieDatabase {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Insere um novo Specie no banco de dados
  Future<void> insertSpecie(Specie specie) async {
    final db = await _databaseHelper.database;
    await db.insert(
      'species',
      specie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Recupera species do banco de dados
  Future<List<Specie>> getSpecies() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('species');

    return List.generate(maps.length, (i) {
      return Specie.fromMap(maps[i]);
    });
  }
}
