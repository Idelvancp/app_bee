// typeInspections_database.dart
import 'package:sqflite/sqflite.dart';
import 'package:app_bee/models/typeInspection.dart';
import 'package:app_bee/database/databaseHelper.dart';

class TypeInspectionDatabase {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Insere um novo TypeInspection no banco de dados
  Future<void> insertTypeInspection(TypeInspection typeInspections) async {
    final db = await _databaseHelper.database;
    await db.insert(
      'types_inspections',
      typeInspections.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Recupera typesInspections do banco de dados
  Future<List<TypeInspection>> getTypesInspections() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('types_inspections');

    return List.generate(maps.length, (i) {
      return TypeInspection.fromMap(maps[i]);
    });
  }
}
