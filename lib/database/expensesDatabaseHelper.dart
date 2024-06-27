import 'package:sqflite/sqflite.dart';
import 'package:app_bee/models/expense.dart';
import 'package:app_bee/database/databaseHelper.dart';

class ExpenseDatabase {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Insere um novo Expense no banco de dados
  Future<void> insertExpense(Expense expense) async {
    final db = await _databaseHelper.database;
    await db.insert(
      'expenses',
      expense.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Recupera expenses do banco de dados
  Future<List<Expense>> getExpenses() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('expenses');

    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }
}
