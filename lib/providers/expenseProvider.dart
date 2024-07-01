import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/expense.dart';
import 'package:app_bee/database/expensesDatabaseHelper.dart';

class ExpenseProvider with ChangeNotifier {
  final List _expenses = [];
  List<Map<String, dynamic>> get expenses => [..._expenses];

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
      typeExpenseId: data['type_expense_id'] as int,
      apiaryId: data['apiary_id'] as int,
      cost: data['cost'] as double,
      date: DateTime.parse(data['date'].toString()),
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
