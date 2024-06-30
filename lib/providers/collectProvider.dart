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

  final List _collectsPerApiary = [];
  List get collectsPerApiary => [..._collectsPerApiary];

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

  Future<void> loadCollectsForApiary(int apiaryId) async {
    final collects = await CollectsDatabase().collectsPerApiary(apiaryId);
    _collectsPerApiary.clear();
    _collectsPerApiary.addAll(collects);
    notifyListeners();
  }

  Map<int, double> getTotalHoneyByYear() {
    Map<int, double> totals = {};
    for (var colletct in _collectsPerApiary) {
      int year = DateTime.parse(colletct['date']).year;
      totals[year] = (totals[year] ?? 0) + (colletct['honey'] as double);
    }
    return totals;
  }

  Map<int, double> getTotalPropolisByYear() {
    Map<int, double> totals = {};
    for (var colletct in _collectsPerApiary) {
      int year = DateTime.parse(colletct['date']).year;
      totals[year] = (totals[year] ?? 0) + (colletct['propolis'] as double);
    }
    return totals;
  }

  Map<int, double> getTotalWaxByYear() {
    Map<int, double> totals = {};
    for (var colletct in _collectsPerApiary) {
      int year = DateTime.parse(colletct['date']).year;
      totals[year] = (totals[year] ?? 0) + (colletct['wax'] as double);
    }
    return totals;
  }

  Map<int, double> getTotalRoyalJellyByYear() {
    Map<int, double> totals = {};
    for (var colletct in _collectsPerApiary) {
      int year = DateTime.parse(colletct['date']).year;
      totals[year] = (totals[year] ?? 0) + (colletct['royal_jelly'] as double);
    }
    return totals;
  }

  Map<int, Map<String, dynamic>> getMaxHoneyByYear() {
    Map<int, Map<String, dynamic>> maxHoneyPerYear = {};

    for (var collect in _collectsPerApiary) {
      int year = DateTime.parse(collect['date']).year;
      double honey = collect['honey'] as double;
      String tag = collect['tag'];
      String specie = collect['name']
          as String; // Supondo que 'tag' é a chave para a tag no mapa da coleta
      if (!maxHoneyPerYear.containsKey(year)) {
        maxHoneyPerYear[year] = {'honey': honey, 'tag': tag, 'specie': specie};
      } else if (maxHoneyPerYear[year]!['honey'] as double < honey) {
        maxHoneyPerYear[year]!['honey'] = honey;
        maxHoneyPerYear[year]!['tag'] = tag;
        maxHoneyPerYear[year]!['specie'] = specie;
      }
    }

    return maxHoneyPerYear;
  }

  Map<int, Map<String, dynamic>> getMaxPropolisByYear() {
    Map<int, Map<String, dynamic>> maxPropolisPerYear = {};

    for (var collect in collectsPerApiary) {
      int year = DateTime.parse(collect['date']).year;
      double propolis = collect['propolis'] as double;
      String tag = collect['tag'];
      String specie = collect['name'] as String;
      if (!maxPropolisPerYear.containsKey(year)) {
        maxPropolisPerYear[year] = {
          'propolis': propolis,
          'tag': tag,
          'specie': specie
        };
      } else if (maxPropolisPerYear[year]!['propolis'] as double < propolis) {
        maxPropolisPerYear[year]!['propolis'] = propolis;
        maxPropolisPerYear[year]!['tag'] = tag;
        maxPropolisPerYear[year]!['specie'] = specie;
      }
    }
    return maxPropolisPerYear;
  }

  Map<int, Map<String, dynamic>> getMaxWaxByYear() {
    Map<int, Map<String, dynamic>> maxWaxPerYear = {};

    for (var collect in collectsPerApiary) {
      int year = DateTime.parse(collect['date']).year;
      double wax = collect['wax'] as double;
      String tag = collect['tag'];
      String specie = collect['name'] as String;
      if (!maxWaxPerYear.containsKey(year)) {
        maxWaxPerYear[year] = {'wax': wax, 'tag': tag, 'specie': specie};
      } else if (maxWaxPerYear[year]!['wax'] as double < wax) {
        maxWaxPerYear[year]!['wax'] = wax;
        maxWaxPerYear[year]!['tag'] = tag;
        maxWaxPerYear[year]!['specie'] = specie;
      }
    }
    return maxWaxPerYear;
  }

  Map<int, Map<String, dynamic>> getMaxRoyalJellyByYear() {
    Map<int, Map<String, dynamic>> maxRoyalJellyPerYear = {};

    for (var collect in collectsPerApiary) {
      int year = DateTime.parse(collect['date']).year;
      double royal_jelly = collect['royal_jelly'] as double;
      String tag = collect['tag'];
      String specie = collect['name'] as String;
      if (!maxRoyalJellyPerYear.containsKey(year)) {
        maxRoyalJellyPerYear[year] = {
          'royal_jelly': royal_jelly,
          'tag': tag,
          'specie': specie
        };
      } else if (maxRoyalJellyPerYear[year]!['royal_jelly'] as double <
          royal_jelly) {
        maxRoyalJellyPerYear[year]!['royal_jelly'] = royal_jelly;
        maxRoyalJellyPerYear[year]!['tag'] = tag;
        maxRoyalJellyPerYear[year]!['specie'] = specie;
      }
    }
    return maxRoyalJellyPerYear;
  }
}
