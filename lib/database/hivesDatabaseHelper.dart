import 'package:sqflite/sqflite.dart';
import 'package:app_bee/models/hive.dart';
import 'package:app_bee/database/databaseHelper.dart';

class HiveDatabase {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Insere uma nova Hive no banco de dados
  Future<void> insertHive(Hive hive) async {
    final db = await _databaseHelper.database;
    await db.insert(
      'hives',
      hive.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Recupera hives do banco de dados
  Future<List<Hive>> getHives() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('hives');

    return List.generate(maps.length, (i) {
      return Hive.fromMap(maps[i]);
    });
  }

  // Deleta uma hive do banco de dados
  Future<void> deleteHive(int id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'hives',
      where: 'id = ?',
      whereArgs: [id],
    );
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

  Future<List> getHivesScreen() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''SELECT 
    hive.*,
    honey_box.tag AS honey_box_tag,
    specie.name AS specie_name,
    apiary.name AS apiary_name,
    apiary.city_id AS apiary_city_id,
    apiary.state_id AS apiary_state_id
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
          'Tages ${table['type_inspection_id']} ${table['apiary_name']} ${table['specie_name']}');
    });
    return maps;
  }

  Future<List> getHiveDetails() async {
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
    inspections inspection  
    ON hive.id = inspection.hive_id
INNER JOIN 
    apiaries apiary 
    ON hive.apiary_id = apiary.id''');

    maps.forEach((table) {
      print(
          'Tages ${table['type_inspection_id']} ${table['apiary_name']} ${table['specie_name']}');
    });
    return maps;
  }

  Future<List> getHivesWithLatestInspection2() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT 
  i.id,
  i.date,
  i.hive_id,
  i.apiary_id,
  i.type_inspection_id,
  i.population_data_id,
  i.environment_data_id,
  p.number_bees,
  p.age_queen,
  p.spawning_queen,
  p.larvae_presence_distribution,
  p.larvae_health_development,
  p.pupa_presence_distribution,
  p.pupa_health_development,
  e.internal_temperature,
  e.external_temperature,
  e.internal_humidity,
  e.external_humidity,
  e.wind_speed,
  e.cloud,
  honey_box.tag
FROM 
  inspections i
INNER JOIN 
  population_data p ON i.population_data_id = p.id
INNER JOIN 
  environment_data e ON i.environment_data_id = e.id
INNER JOIN 
  hives hive ON i.hive_id = hive.id
INNER JOIN 
  honey_boxes honey_box  ON  honey_box.id = hive.honey_box_id
WHERE 
  i.date = (
    SELECT MAX(date) 
    FROM inspections 
    WHERE hive_id = i.hive_id
  )
  ''');
/*
    maps.forEach((table) {
      print(
          'Inspection in Apiary ${table['tag']} ${table['number_bees']} ${table['larvae_health_development']}');
    });
*/
    return maps;
  }

  // Recupera hives por apiary_id
  Future<List<Map<String, dynamic>>> getHivesByApiaryId(int apiaryId) async {
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
      hives  hive
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
}
