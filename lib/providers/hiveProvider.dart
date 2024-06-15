import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/hive.dart';
import 'package:app_bee/database/databaseHelper.dart';

class HiveProvider with ChangeNotifier {
  final List<Hive> _hives = [];
  List<Hive> get hive => [..._hives];

  int get hivesCount {
    return _hives.length;
  }

  void loadHives() async {
    final hives = await DatabaseHelper().getHives();
    _hives.clear();
    _hives.addAll(hives);
    notifyListeners();
  }

  void addHiveFromData(Map<String, Object> data) {
    final now = DateTime.now();
    final newHive = Hive(
      id: Random().nextInt(10000),
      honeyBoxId: data['honeyBoxId'] as int,
      specieId: data['specieId'] as int,
      apiaryId: data['apiaryId'] as int,
      createdAt: DateTime.parse(now.toString()),
      updatedAt: DateTime.parse(now.toString()),
    );
    addHive(newHive);
  }

  Future<void> addHive(Hive hive) async {
    _hives.add(hive);
    await DatabaseHelper().insertHive(hive);
    notifyListeners();
  }
}
