import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/specie.dart';
import 'package:app_bee/database/databaseHelper.dart';

class SpecieProvider with ChangeNotifier {
  final List<Specie> _species = [];
  List<Specie> get specie => [..._species];

  int get speciesCount {
    return _species.length;
  }

  void loadSpecies() async {
    final hives = await DatabaseHelper().getSpecies();
    _species.clear();
    _species.addAll(hives);
    notifyListeners();
  }

  void addSpecieFromData(Map<String, Object> data) {
    final now = DateTime.now();
    final newSpecie = Specie(
      id: Random().nextInt(10000),
      name: data['name'].toString(),
      createdAt: DateTime.parse(now.toString()),
      updatedAt: DateTime.parse(now.toString()),
    );
    addSpecie(newSpecie);
  }

  Future<void> addSpecie(Specie specie) async {
    _species.add(specie);
    await DatabaseHelper().insertSpecie(specie);
    notifyListeners();
  }
}
