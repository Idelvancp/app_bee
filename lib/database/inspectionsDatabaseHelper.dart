// inspections_database.dart

import 'package:sqflite/sqflite.dart';
import 'package:app_bee/models/inspection.dart';
import 'package:app_bee/database/databaseHelper.dart';
import 'package:app_bee/models/populationData.dart';
import 'package:app_bee/models/environmentData.dart';
import 'package:app_bee/models/collect.dart';

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
  ) async {
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

      // Atualizar os IDs nas inspeções antes de inserir
      inspection.populationDataId = populationDataId;
      inspection.environmentDataId = environmentDataId;

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

  Future<List> getLastInspectionHive(int hiveId) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      '''
    SELECT 
      inspection.*,
      hive.*,
      population.*,
      environment.*
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
    WHERE 
      hive.id = ?
    ORDER BY inspection.date DESC
    LIMIT 1
  ''',
      [hiveId],
    );

    return maps;
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
    WHERE 
      hive.apiary_id = ?
  ''',
      [apiaryId],
    );

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
    ''');

    maps.forEach((table) {
      print(
          'Dados da Inspeção ${table['tag']}, Data ${table['date']}, ${table['number_bees']}');
    });
    return maps;
  }

  Future<List> getHivesWithLatestInspection() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT 
      h.*,
      hb.tag AS honey_box_tag,
      s.name AS specie_name,
      a.name AS apiary_name,
      i.*,  -- Todos os campos da tabela inspections
      p.*   -- Todos os campos da tabela population_data
    FROM 
      hives h
      INNER JOIN honey_boxes hb ON h.honey_box_id = hb.id
      INNER JOIN species s ON h.specie_id = s.id
      INNER JOIN apiaries a ON h.apiary_id = a.id
      INNER JOIN (
        SELECT 
          MAX(date) AS date,
          hive_id
        FROM inspections
        GROUP BY hive_id
      ) latest_inspection ON h.id = latest_inspection.hive_id
      INNER JOIN inspections i ON latest_inspection.date = i.date AND h.id = i.hive_id
      INNER JOIN population_data p ON i.population_data_id = p.id
  ''');

    return maps;
  }
}
