import 'package:sqflite/sqflite.dart';
import 'package:app_bee/models/typeExpense.dart';
import 'package:app_bee/database/databaseHelper.dart';

class TypesExpansesDatabase {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

// Insere um novo TypeExpense no banco de dados
  Future<void> insertTypeExpense(Map<String, dynamic> typeExpense) async {
    final db = await _databaseHelper.database;
    await db.insert(
      'types_expenses',
      typeExpense,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// Recupera TypeExpenses do banco de dados
  Future<List<Map<String, dynamic>>> getTypeExpenses() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('types_expenses');

    return maps;
  }

  // Deleta um TypeExpense do banco de dados
  Future<void> deleteTypeExpense(int id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'types_expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
