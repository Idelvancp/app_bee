import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/hive.dart';
import 'package:app_bee/database/databaseHelper.dart';

class HiveProvider with ChangeNotifier {
  final List<Hive> _hives = [];
  List<Hive> get hive => [..._hives];
  final List _hiveDetails = [];
  List get hiveDetail => [..._hiveDetails];

  int get hivesCount {
    return _hives.length;
  }

  void loadHives() async {
    final hives = await DatabaseHelper().getHives();
    _hives.clear();
    _hives.addAll(hives);
    notifyListeners();
  }

  void loadHivesDetails() async {
    final hivesAllData = await DatabaseHelper().getHiveDetails();
    _hiveDetails.clear();
    _hiveDetails.addAll(hivesAllData);
    notifyListeners();
  }

  void addHiveFromData(Map<String, Object> data) {
    final now = DateTime.now();
    final newHive = Hive(
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
