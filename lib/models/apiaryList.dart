import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/data/dummy_data.dart';
import 'package:app_bee/models/apiary.dart';

class ApiaryList with ChangeNotifier {
  final List<Apiary> _apiaries = DUMMY_APIARIES;
  List<Apiary> get apiary => [..._apiaries];

  int get apiariesCount {
    return _apiaries.length;
  }

  void addApiaryFromData(Map<String, Object> data) {
    final newApiary = Apiary(
      id: Random().nextInt(10000),
      name: data['name'].toString(),
      state: data['state'].toString(),
      city: data['city'].toString(),
      // biome: _formData['biome'] as String,
      //date: DateTime.parse(_formData['date'] as String),
    );
    addApiary(newApiary);
  }

  void addApiary(Apiary apiary) {
    _apiaries.add(apiary);
    notifyListeners();
  }
}
