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
    print("Insert Inspection Transaction");

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
    hive.*,
    honey_box.tag,
    specie.name AS specie_name,
    specie.created_at AS specie_created_at,
    specie.updated_at AS specie_updated_at,
    apiary.name AS apiary_name,
    apiary.city_id AS apiary_city_id,
    apiary.state_id AS apiary_state_id,
    apiary.created_at AS apiary_created_at,
    apiary.updated_at AS apiary_updated_at        
  FROM 
    hives hive  
    INNER JOIN 
    honey_boxes honey_box 
    ON hive.honey_box_id = honey_box.id
INNER JOIN 
    species specie  
    ON hive.specie_id = specie.id
INNER JOIN 
    apiaries apiary 
    ON hive.apiary_id = apiary.id''');

    maps.forEach((table) {
      print(
          'Tages ${table['tag']} ${table['apiary_name']} ${table['specie_name']}');
    });
    return maps;
  }
}
