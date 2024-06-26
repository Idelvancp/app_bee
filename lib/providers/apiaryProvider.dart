import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/apiary.dart';
import 'package:app_bee/models/floralResource.dart';
import 'package:app_bee/database/apiariesDatabaseHelper.dart';

class ApiaryProvider with ChangeNotifier {
  List<Apiary> _apiaries = [];
  List<Apiary> get apiary => [..._apiaries];
  List<Apiary> _apiariesOnly = [];
  List<Apiary> get apiaryOnly => [..._apiariesOnly];

  int get apiariesCount {
    return _apiaries.length;
  }

  void addApiaryFromData(Map<String, Object> data) {
    // Recuperar a lista de FloralResource do formData
    List<FloralResource> floralResources =
        data['fResources'] as List<FloralResource>;
    // Agora você pode usar floralResources como precisar
//    for (var resource in floralResources) {
    //    print('Selected Floral Resource: ${resource.name}');
    // }
    final newApiary = Apiary(
      cityId: data['cityId'] as int,
      stateId: data['stateId'] as int,
      name: data['name'].toString(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    addApiary(newApiary, floralResources);
  }

  Future<void> addApiary(Apiary newApiary, List fResouces) async {
    _apiaries.add(newApiary);
    await ApiariesDatabase().insertApiary(newApiary, fResouces);
    notifyListeners();
  }

  Future<void> loadApiaries() async {
    final List<Apiary> loadedApiaries = await ApiariesDatabase().getApiaries();
    _apiaries = loadedApiaries;
    notifyListeners();
  }

  Future<void> loadApiariesOnly() async {
    final List<Apiary> loadedApiariesOnly =
        await ApiariesDatabase().getApiariesOnly();
    _apiariesOnly = loadedApiariesOnly;
    notifyListeners();
  }

// Novo método para buscar e imprimir apiários e seus recursos florais
  Future<void> fetchAndPrintApiaries() async {
    final apiariesFromDb = await ApiariesDatabase().getApiaries();
    _apiaries.clear();
    _apiaries.addAll(apiariesFromDb);
    notifyListeners();

    for (var apiary in _apiaries) {
      print('Apiary: ${apiary.name}');
      for (var floralResource in apiary.floralResources) {
        print('  Floral Resource: ${floralResource.name}');
      }
      for (var hive in apiary.hives) {
        print('Hive ${hive.id}');
      }
    }
  }
}
