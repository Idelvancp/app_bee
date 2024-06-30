import 'package:sqflite/sqflite.dart';
import 'package:app_bee/models/collect.dart';
import 'package:app_bee/database/databaseHelper.dart';

class CollectsDatabase {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Insere um novo Collects no banco de dados
  Future<void> insertCollect(Collect collect) async {
    print(
        "Dentro de Inset Collect ${collect.date} ${collect.amountHoney} ${collect.amountPropolis} ${collect.amountRoyalJelly} ${collect.amountWax} ${collect.apiaryId} ${collect.hiveId} ${collect.createdAt} ${collect.updatedAt}");
    final db = await _databaseHelper.database;
    await db
        .insert(
      'collects',
      collect.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    )
        .catchError((error) {
      print("Error inserting inspection: $error");
    });
  }

  // Recupera collects do banco de dados
  Future<List<Collect>> getCollects() async {
    print("Dentro de Colletc");
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('collects');
/*
    maps.forEach((table) {
      print(
          'Coletas id ${table['id']} data ${table['date']} Mel ${table['honey']} Propolies ${table['propolis']} Cera ${table['wax']} Geleia${table['royal_jelly']} ${table['hive_id']} ${table['apiary_id']}');
    });*/
    return List.generate(maps.length, (i) {
      return Collect.fromMap(maps[i]);
    });
  }

  // Recupera collects do banco de dados
  Future<List> getCollectsWithHiveName() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''SELECT 
    collect.*,
    honey_box.tag,
    specie.name AS specie_name,
    apiary.name AS apiary_name 
    FROM 
      collects collect  
    INNER JOIN 
      hives hive 
      ON hive.id = collect.hive_id
    INNER JOIN 
      species specie  
      ON specie.id = hive.specie_id
    INNER JOIN 
      honey_boxes honey_box 
      ON honey_box.id = hive.honey_box_id
    INNER JOIN 
      apiaries apiary 
      ON apiary.id = collect.apiary_id''');
    maps.forEach((table) {
      print(
          'Tages ${table['specie_name']} ${table['apiary_name']} ${table['tag']}');
    });
    return maps;
  }

  // Deleta uma collect do banco de dados
  Future<void> deleteCollect(int id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'collects',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> collectsPerApiary(int apiaryId) async {
    print("Estou ${apiaryId}");
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      '''
    SELECT 
      collect.*,
      hive.*,
      honey_box.*,
      specie.*
    FROM 
      collects collect
    INNER JOIN 
      apiaries apiary 
    ON collect.apiary_id = apiary.id
    INNER JOIN 
      hives hive 
    ON hive.id = collect.hive_id
    INNER JOIN 
      honey_boxes honey_box 
    ON hive.honey_box_id = honey_box.id
    INNER JOIN 
      species specie 
    ON hive.specie_id = specie.id
    WHERE 
      collect.apiary_id = ?
  ''',
      [apiaryId],
    );
    print('Tamanho ${maps.length}');

    maps.forEach((table) {
      print('Coleta ${table['tag']}');
    });
    return maps;
  }
}
