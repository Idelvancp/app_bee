import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/typeExpense.dart';
import 'package:app_bee/database/databaseHelper.dart';

class TypeExpenseProvider with ChangeNotifier {
  final List<TypeExpense> _typeExpenses = [];
  List<TypeExpense> get typeExpenses => [..._typeExpenses];

  int get typeExpensesCount {
    return _typeExpenses.length;
  }

  void loadTypeExpenses() async {
    final typeExpenses = await DatabaseHelper().getTypeExpenses();
    _typeExpenses.clear();
    _typeExpenses.addAll(typeExpenses.map((map) => TypeExpense.fromMap(map)));
    notifyListeners();
  }

  void addTypeExpenseFromData(Map<String, Object> data) {
    final now = DateTime.now();
    final newTypeExpense = TypeExpense(
      id: Random().nextInt(10000),
      name: data['name'].toString(),
      createdAt: DateTime.parse(now.toString()),
      updatedAt: DateTime.parse(now.toString()),
    );
    addTypeExpense(newTypeExpense);
  }

  Future<void> addTypeExpense(TypeExpense typeExpense) async {
    _typeExpenses.add(typeExpense);
    await DatabaseHelper().insertTypeExpense(typeExpense.toMap());
    notifyListeners();
  }
}
