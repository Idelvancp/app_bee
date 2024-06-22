// inspections_database.dart

import 'package:sqflite/sqflite.dart';
import 'package:app_bee/models/inspection.dart';
import 'package:app_bee/database/databaseHelper.dart';

class InspectionDatabase {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Insere um novo Inspection no banco de dados
  Future<void> insertInspection(Inspection inspections) async {
    final db = await _databaseHelper.database;
    await db.insert(
      'inspections',
      inspections.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Recupera inspections do banco de dados
  Future<List<Inspection>> getInspections() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('inspections');

    return List.generate(maps.length, (i) {
      return Inspection.fromMap(maps[i]);
    });
  }
}
