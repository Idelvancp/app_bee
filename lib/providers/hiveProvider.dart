import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/hive.dart';
import 'package:app_bee/database/hivesDatabaseHelper.dart';

class HiveProvider with ChangeNotifier {
  final List _hivesScreen = [];
  List get hivesScreen => [..._hivesScreen];

  final List _hiveDetails = [];
  List get hiveDetail => [..._hiveDetails];

  final List _isnpectionsHives = [];
  List get isnpectionsHives => [..._isnpectionsHives];

  int get hivesCount {
    return _hivesScreen.length;
  }

  void loadIsnpectionsHives() async {
    final hives = await HiveDatabase().getHivesWithLatestInspection2();
    _isnpectionsHives.clear();
    _isnpectionsHives.addAll(hives);
    notifyListeners();
  }

  void loadHives() async {
    final hives = await HiveDatabase().getHivesScreen();
    _hivesScreen.clear();
    _hivesScreen.addAll(hives);
    notifyListeners();
  }

  void loadHivesDetails() async {
    final hivesAllData = await HiveDatabase().getHiveDetails();
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
    _hivesScreen.add(hive);
    await HiveDatabase().insertHive(hive);
    notifyListeners();
  }
}
