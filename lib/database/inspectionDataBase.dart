// inspections_database.dart

import 'package:sqflite/sqflite.dart';
import 'package:app_bee/models/inspection.dart';
import 'package:app_bee/database/databaseHelper.dart';
import 'package:app_bee/models/populationData.dart';
import 'package:app_bee/models/environmentData.dart';
import 'package:app_bee/models/products.dart';

class InspectionDatabase {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Insere um novo Inspection no banco de dados
  Future<void> insertInspectionEnvironmentPopulation(
      Inspection inspections) async {
    final db = await _databaseHelper.database;
    await db.insert(
      'inspections',
      inspections.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertInspection(
      Inspection inspection,
      PopulationData populationData,
      EnvironmentData environmentData,
      Product product) async {
    final db = await _databaseHelper.database;

    await db.transaction((txn) async {
      // Inserir population_data e obter o id gerado
      int populationDataId = await txn.insert(
        'population_data',
        populationData.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Inserir environment_data e obter o id gerado
      int environmentDataId = await txn.insert(
        'environment_data',
        environmentData.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Inserir products e obter o id gerado
      int productId = await txn.insert(
        'products',
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Atualizar os IDs nas inspeções antes de inserir
      inspection.populationDataId = populationDataId;
      inspection.environmentDataId = environmentDataId;
      inspection.productId = productId;

      // Inserir inspection
      await txn.insert(
        'inspections',
        inspection.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  // Recupera inspections do banco de dados
  Future<List<Inspection>> getInspections() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('inspections');
    maps.forEach((table) {
      print('Tages ${table['1d']}');
    });
    return List.generate(maps.length, (i) {
      return Inspection.fromMap(maps[i]);
    });
  }
}
