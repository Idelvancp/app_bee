import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/expense.dart';
import 'package:app_bee/database/expensesDatabaseHelper.dart';
import 'package:app_bee/database/databaseHelper.dart';

class ExpenseProvider with ChangeNotifier {
  final List<Expense> _expenses = [];
  List<Expense> get expenses => [..._expenses];

  int get expensesCount {
    return _expenses.length;
  }

  void loadExpenses() async {
    final expenses = await ExpenseDatabase().getExpenses();
    _expenses.clear();
    _expenses.addAll(expenses);
    notifyListeners();
  }

  void addExpenseFromData(Map<String, Object> data) {
    final now = DateTime.now();
    final newExpense = Expense(
      id: Random().nextInt(10000),
      cost: data['cost'] as double,
      date: DateTime.parse(data['date'].toString()),
      typeExpenseId: data['type_expense_id'] as int,
      createdAt: DateTime.parse(now.toString()),
      updatedAt: DateTime.parse(now.toString()),
    );
    addExpense(newExpense);
  }

  Future<void> addExpense(Expense expense) async {
    _expenses.add(expense);
    await ExpenseDatabase().insertExpense(expense);
    notifyListeners();
  }
}
