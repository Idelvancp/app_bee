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

  // Deleta uma despesa do banco de dados pelo ID
  Future<void> deleteExpense(int id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Recupera expenses do banco de dados
  Future<List<Map<String, dynamic>>> getExpenses() async {
    print("Aqui2");
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT 
      expense.*,
      apiary.name AS apiary_name,
      type_expense.name AS type_expense_name
    FROM 
      expenses expense
    INNER JOIN 
      apiaries apiary ON expense.apiary_id = apiary.id
    INNER JOIN 
      types_expenses type_expense ON expense.type_expense_id = type_expense.id
    ''');
    maps.forEach((table) {
      print('Tagessssssssss ${table['id']} ');
    });
    return maps;
  }

  Future<List<Map<String, dynamic>>> getExpensesByYear() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT 
      e.cost AS expense_cost,
      e.date AS expense_date,
      a.name AS apiary_name,
      te.name AS expense_type
    FROM 
      expenses e
    INNER JOIN 
      apiaries a ON e.apiary_id = a.id
    INNER JOIN 
      types_expenses te ON e.type_expense_id = te.id
    ORDER BY 
      e.date ASC
    ''');

    maps.forEach((table) {
      print(
          'Valor: ${table['expense_cost']} Apiário: ${table['apiary_name']} ');
    });
    return maps;
  }
}
