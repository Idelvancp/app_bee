import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/expense.dart';
import 'package:app_bee/database/expensesDatabaseHelper.dart';

class ExpenseProvider with ChangeNotifier {
  final List _expenses = [];
  List<Map<String, dynamic>> get expenses => [..._expenses];

  final List _expensesByYear = [];
  List get expensesByYear => [..._expensesByYear];

  int get expensesCount {
    return _expenses.length;
  }

  void loadExpenses() async {
    final expenses = await ExpenseDatabase().getExpenses();
    _expenses.clear();
    _expenses.addAll(expenses);
    notifyListeners();
  }

  void loadExpensesByYear() async {
    final expenses = await ExpenseDatabase().getExpensesByYear();
    _expensesByYear.clear();
    _expensesByYear.addAll(expenses);
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
    notifyListeners();
    await ExpenseDatabase().insertExpense(expense);
  }

  Future<void> deleteExpense(int id) async {
    _expenses.removeWhere((expense) => expense['id'] == id);
    await ExpenseDatabase().deleteExpense(id);
    notifyListeners();
  }

  // Função para somar e retornar todos os gastos por ano
  Map<int, double> getTotalExpensesByYear() {
    Map<int, double> totalExpensesByYear = {};

    for (var expense in _expensesByYear) {
      DateTime expenseDate = DateTime.parse(expense['expense_date']);
      int year = expenseDate.year;
      double cost = expense['expense_cost'];

      if (totalExpensesByYear.containsKey(year)) {
        totalExpensesByYear[year] = totalExpensesByYear[year]! + cost;
      } else {
        totalExpensesByYear[year] = cost;
      }
    }
    totalExpensesByYear.forEach((year, totalExpense) {
      print(
          'Ano: $year, Total de Gastos: R\$ ${totalExpense.toStringAsFixed(2)}');
    });

    return totalExpensesByYear;
  }

  // Função para somar e retornar todos os gastos por apiário
  Map<String, double> getTotalExpensesByApiary() {
    Map<String, double> totalExpensesByApiary = {};

    for (var expense in _expensesByYear) {
      String apiaryName = expense['apiary_name'];
      double cost = expense['expense_cost'];

      if (totalExpensesByApiary.containsKey(apiaryName)) {
        totalExpensesByApiary[apiaryName] =
            totalExpensesByApiary[apiaryName]! + cost;
      } else {
        totalExpensesByApiary[apiaryName] = cost;
      }
    }

    totalExpensesByApiary.forEach((apiary, totalExpense) {
      print(
          'Apiário: $apiary, Total de Gastos: R\$ ${totalExpense.toStringAsFixed(2)}');
    });

    return totalExpensesByApiary;
  }

  // Função para somar e retornar todos os gastos por tipo de despesa
  Map<String, double> getTotalExpensesByType() {
    Map<String, double> totalExpensesByType = {};

    for (var expense in _expensesByYear) {
      String typeName = expense['expense_type'];
      double cost = expense['expense_cost'];

      if (totalExpensesByType.containsKey(typeName)) {
        totalExpensesByType[typeName] = totalExpensesByType[typeName]! + cost;
      } else {
        totalExpensesByType[typeName] = cost;
      }
    }

    totalExpensesByType.forEach((type, totalExpense) {
      print(
          'Tipo de Despesa: $type, Total de Gastos: R\$ ${totalExpense.toStringAsFixed(2)}');
    });

    return totalExpensesByType;
  }
}
