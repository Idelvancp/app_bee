import 'package:sqflite/sqflite.dart';
import 'package:app_bee/models/apiary.dart';
import 'package:app_bee/models/hive.dart';
import 'package:app_bee/models/floralResource.dart';
import 'package:app_bee/database/databaseHelper.dart';

class ApiariesDatabase {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> insertApiary(Apiary apiary, List fResources) async {
    final db = await _databaseHelper.database;
    await db.transaction((txn) async {
      int apiaryId = await txn.insert(
        'apiaries',
        apiary.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      for (var fResource in fResources) {
        await txn.insert(
          'apiaries_floral_resources',
          {
            'apiary_id': apiaryId,
            'floral_resource_id': fResource.id,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  // Recupera species do banco de dados
  Future<List<Apiary>> getApiariesOnly() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('apiaries');

    return List.generate(maps.length, (i) {
      return Apiary.fromMap(maps[i]);
    });
  }

// Recupera Apiaries do banco de dados
  Future<List<Apiary>> getApiaries() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> apiaryMaps = await db.query('apiaries');

    List<Apiary> apiaries = [];
    for (var apiaryMap in apiaryMaps) {
      int apiaryId = apiaryMap['id'];

      final List<Map<String, dynamic>> hivesMaps = await db.query(
        'hives',
        where: 'apiary_id = ?',
        whereArgs: [apiaryId],
      );
      List<Hive> hives = [];
      for (var hiveMap in hivesMaps) {
        int hiveId = hiveMap['id'];
        final List<Map<String, dynamic>> hivesMap =
            await db.query('hives', where: 'id = ?', whereArgs: [hiveId]);
        if (hivesMap.isNotEmpty) {
          hives.add(Hive.fromMap(hivesMap.first));
        }
      }

      final List<Map<String, dynamic>> floralResourceMaps = await db.query(
        'apiaries_floral_resources',
        where: 'apiary_id = ?',
        whereArgs: [apiaryId],
      );

      List<FloralResource> floralResources = [];
      for (var floralResourceMap in floralResourceMaps) {
        int floralResourceId = floralResourceMap['floral_resource_id'];

        final List<Map<String, dynamic>> resourceMap = await db.query(
          'floral_resources',
          where: 'id = ?',
          whereArgs: [floralResourceId],
        );

        if (resourceMap.isNotEmpty) {
          floralResources.add(FloralResource.fromMap(resourceMap.first));
        }
      }

      apiaries.add(Apiary.fromMap(apiaryMap)
          .copyWith(floralResources: floralResources, hives: hives));
    }

    return apiaries;
  }
}
