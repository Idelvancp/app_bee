import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/collect.dart';
import 'package:app_bee/database/collectsDatabaseHelper.dart';

class CollectProvider with ChangeNotifier {
  final List<Collect> _collects = [];
  List<Collect> get collect => [..._collects];

  final List _collectsScreen = [];
  List get collectsScreen => [..._collectsScreen];

  int get collectsCount {
    return _collects.length;
  }

  void loadCollects() async {
    final collects = await CollectsDatabase().getCollects();
    _collects.clear();
    _collects.addAll(collects);
    notifyListeners();
  }

  void getCollectsScreen() async {
    final collects = await CollectsDatabase().getCollectsWithHiveName();
    _collectsScreen.clear();
    _collectsScreen.addAll(collects);
    notifyListeners();
  }

  void addCollectFromData(Map<String, Object> data) {
    final now = DateTime.now();
    final newCollect = Collect(
      date: DateTime.parse(data['date'].toString()),
      amountHoney: data['amountHoney'] as double,
      amountPropolis: data['amountPropolis'] as double,
      amountWax: data['amountWax'] as double,
      amountRoyalJelly: data['amountRoyalJelly'] as double,
      apiaryId: data['apiaryId'] as int,
      hiveId: data['hiveId'] as int,
      createdAt: DateTime.parse(now.toString()),
      updatedAt: DateTime.parse(now.toString()),
    );
    addCollect(newCollect);
  }

  Future<void> addCollect(Collect collect) async {
    _collects.add(collect);
    await CollectsDatabase().insertCollect(collect);
    notifyListeners();
  }

  Future<void> deleteCollect(Collect collect) async {
    _collects.remove(collect);
    await CollectsDatabase().deleteCollect(collect.id!);
    notifyListeners();
  }
}
