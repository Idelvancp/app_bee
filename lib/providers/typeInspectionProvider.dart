import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/typeInspection.dart';
import 'package:app_bee/database/typeInspectionDataBase.dart';

class TypeInspectionProvider with ChangeNotifier {
  final List<TypeInspection> _typesInspections = [];
  List<TypeInspection> get typeInspection => [..._typesInspections];

  int get typesInspectionsCount {
    return _typesInspections.length;
  }

  void loadTypeInspections() async {
    final typesInspections =
        await TypeInspectionDatabase().getTypesInspections();
    _typesInspections.clear();
    _typesInspections.addAll(typesInspections);
    notifyListeners();
  }

  void addTypeInspectionFromData(Map<String, Object> data) {
    final now = DateTime.now();
    final newTypeInspection = TypeInspection(
      id: Random().nextInt(10000),
      name: data['name'].toString(),
      createdAt: DateTime.parse(now.toString()),
      updatedAt: DateTime.parse(now.toString()),
    );
    addTypeInspection(newTypeInspection);
  }

  Future<void> addTypeInspection(TypeInspection typeInspection) async {
    _typesInspections.add(typeInspection);
    await TypeInspectionDatabase().insertTypeInspection(typeInspection);
    notifyListeners();
  }
}
