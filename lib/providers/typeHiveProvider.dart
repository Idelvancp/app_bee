import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/database/databaseHelper.dart';
import 'package:app_bee/models/typeHive.dart';

class TypeHiveProvider with ChangeNotifier {
  final List<TypeHive> _typesHives = [];
  List<TypeHive> get typeHive => [..._typesHives];

  int get typesHiveCount {
    return _typesHives.length;
  }

  void loadTypesHives() async {
    final hives = await DatabaseHelper().getTypesHives();
    _typesHives.clear();
    _typesHives.addAll(hives);
    notifyListeners();
  }

  void addTypeHiveFromData(Map<String, Object> data) {
    final now = DateTime.now();
    final newTypeHive = TypeHive(
      name: data['name'].toString(),
      createdAt: DateTime.parse(now.toString()),
      updatedAt: DateTime.parse(now.toString()),
    );
    addTypeHive(newTypeHive);
  }

  Future<void> addTypeHive(TypeHive typeHive) async {
    _typesHives.add(typeHive);
    await DatabaseHelper().insertTypeHive(typeHive);
    notifyListeners();
  }
}
