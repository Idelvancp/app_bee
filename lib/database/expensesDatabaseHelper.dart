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
  /*Future<List<Expense>> getExpenses() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('expenses');

    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  } */
  //  'SELECT hb. *, th.name FROM honey_boxes hb  INNER JOIN types_hives th WHERE hb.type_hive_id = th.id;');

  Future<List> getExpenses() async {
    print("Aqui2");
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''SELECT 
    expense. *,
    apiary.name AS apiary_name,
    type_expense.name As type_expense_name          
    FROM 
    expenses expense  
    INNER JOIN 
    apiaries apiary 
    ON expense.apiary_id = apiary.id
    INNER JOIN 
    types_expenses type_expense 
    ON expense.type_expense_id = type_expense.id
  ''');
    maps.forEach((table) {
      print('Tagessssssssss ${table['apiary_name']} ');
    });
    return maps;
  }
}
