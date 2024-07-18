import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/specie.dart';
import 'package:app_bee/database/speciesDatabaseHelper.dart';

class SpecieProvider with ChangeNotifier {
  final List<Specie> _species = [];
  List<Specie> get specie => [..._species];

  int get speciesCount {
    return _species.length;
  }

  void loadSpecies() async {
    final species = await SpecieDatabase().getSpecies();
    _species.clear();
    _species.addAll(species);
    notifyListeners();
  }

  void saveSpecie(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    final now = DateTime.now();
    final specie = Specie(
      id: hasId ? data['id'] as int : null,
      name: data['name'].toString(),
      createdAt: DateTime.parse(now.toString()),
      updatedAt: DateTime.parse(now.toString()),
    );

    if (hasId) {
      updateSpecie(specie);
    } else {
      addSpecie(specie);
    }
  }

  Future<void> addSpecie(Specie specie) async {
    _species.add(specie);
    await SpecieDatabase().insertSpecie(specie);
    notifyListeners();
  }

  Future<void> deleteSpecie(Specie specie) async {
    _species.remove(specie);
    await SpecieDatabase().deleteSpecie(specie.id!);
    notifyListeners();
  }

  Future<void> updateSpecie(Specie specie) async {
    final index = _species.indexWhere((s) => s.id == specie.id);
    if (index >= 0) {
      _species[index] = specie;
      await SpecieDatabase().updateSpecie(specie);
      notifyListeners();
    }
  }
}
