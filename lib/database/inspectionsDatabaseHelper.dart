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

      print("Inspection added: $inspection");
    }).catchError((error) {
      print("Error inserting inspection: $error");
    });
  }

  Future<List<Map<String, dynamic>>> hivesInspections(int apiaryId) async {
    print("Estou ${apiaryId}");
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      '''
    SELECT 
      inspection.*,
      hive.*,
      population.*,
      environment.*,
      product.*
    FROM 
      inspections inspection
    INNER JOIN 
      hives hive 
      ON inspection.hive_id = hive.id
    INNER JOIN
      population_data population
      ON inspection.population_data_id = population.id
    INNER JOIN
      environment_data environment
      ON inspection.environment_data_id = environment.id
    INNER JOIN
      products product
      ON inspection.product_id = product.id
    WHERE 
      hive.apiary_id = ?
  ''',
      [apiaryId],
    );

    maps.forEach((table) {
      print('');
    });
    return maps;
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

  Future<List> getInspectionScreen() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''SELECT 
    inspection.type_inspection_id,
    inspection.date,
    hive.*,
    population.*, 
    environment.*,
    product.*,
    honey_box.tag
  FROM 
    inspections inspection  
    INNER JOIN 
    hives hive 
    ON hive.id = inspection.hive_id
    INNER JOIN 
    honey_boxes honey_box 
    ON hive.honey_box_id = honey_box.id
    INNER JOIN 
    population_data population  
    ON population.id = inspection.population_data_id
    INNER JOIN 
    environment_data environment 
    ON environment.id = inspection.environment_data_id
    INNER JOIN 
    products product 
    ON product.id = inspection.product_id
    ''');

    maps.forEach((table) {
      print(
          'Dados da Inspeção ${table['tag']}, ${table['age_queen']}, ${table['number_bees']}');
    });
    return maps;
  }
}
