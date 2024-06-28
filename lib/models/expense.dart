import 'package:app_bee/models/apiary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Expense with ChangeNotifier {
  final int? id;
  final double cost;
  final int apiaryId;
  final DateTime date;
  final int typeExpenseId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Expense({
    this.id,
    required this.cost,
    required this.date,
    required this.apiaryId,
    required this.typeExpenseId,
    required this.createdAt,
    this.updatedAt,
  });

  // Converte um Expense em um Map para salvar no banco de dados
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cost': cost,
      'apiary_id': apiaryId,
      'date': date.toIso8601String(), // Convertendo para string ISO 8601
      'type_expense_id': typeExpenseId,
      'created_at':
          createdAt.toIso8601String(), // Convertendo para string ISO 8601
      'updated_at':
          updatedAt?.toIso8601String(), // Convertendo para string ISO 8601
    };
  }

  // Converte um Map em um objeto Expense
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      cost: map['cost'],
      apiaryId: map['apriary_id'],
      date: DateTime.parse(map['date']), // Convertendo de string ISO 8601
      typeExpenseId: map['type_expense_id'],
      createdAt:
          DateTime.parse(map['created_at']), // Convertendo de string ISO 8601
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }
}
