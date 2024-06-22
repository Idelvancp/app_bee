import 'package:sqflite/sqflite.dart';

import 'package:app_bee/database/databaseHelper.dart';
import 'package:app_bee/models/hive.dart';
import 'package:app_bee/models/honeyBox.dart';

class honeyBoxDatabase {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

// Insere um novo Floral Resources no banco de dados
  Future<void> insertHoneyBox(HoneyBox honeyBox) async {
    final db = await _databaseHelper.database;

    await db.insert(
      'honey_boxes',
      honeyBox.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT hb. *, th.name FROM honey_boxes hb  INNER JOIN types_hives th WHERE hb.type_hive_id = th.id;');
  }

  Future<List<HoneyBoxWithTypeName>> getHoneyBoxesWithTypeNames() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT hb. *, th.name FROM honey_boxes hb  INNER JOIN types_hives th WHERE hb.type_hive_id = th.id;');

    //       final List<Map<String, dynamic>> maps = await db.rawQuery(
    //     'SELECT hb. *, th. * FROM honey_boxes hb  INNER JOIN types_hives th WHERE hb.type_hive_id = th.id;');
    maps.forEach((table) {
      print(
          '${table['name']}, ${table['number_frames']}, ${table['busy_frames']}');
    });
    return List<HoneyBoxWithTypeName>.from(
        maps.map((map) => HoneyBoxWithTypeName.fromMap(map)));
  }

  Future<List<HoneyBox>> getHoneyBoxes() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('honey_boxes');
    maps.forEach((table) {
      print(
          '${table['name']}, ${table['number_frames']}, ${table['busy_frames']}');
    });
    return List.generate(maps.length, (i) {
      return HoneyBox.fromMap(maps[i]);
    });
  }
}
