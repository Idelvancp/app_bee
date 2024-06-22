import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_bee/models/inspection.dart';
import 'package:app_bee/database/inspectionDataBase.dart';

class InspectionProvider with ChangeNotifier {
  final List<Inspection> _inspections = [];
  List<Inspection> get inspection => [..._inspections];

  int get inspectionsCount {
    return _inspections.length;
  }

  void loadInspections() async {
    final inspections = await InspectionDatabase().getInspections();
    _inspections.clear();
    _inspections.addAll(inspections);
    notifyListeners();
  }

  void addInspectionFromData(Map<String, Object> data) {
    final now = DateTime.now();
    final newInspection = Inspection(
      id: Random().nextInt(10000),
      date: data['date'] as DateTime,
      hiveId: data['hive_id'] as int,
      typeInspectionId: data['type_inspection_id'] as int,
      populationDataId: data['population_data_id'] as int,
      productId: data['product_id'] as int,
      envionrimentDataId: data['environment_data_id'] as int,
      createdAt: DateTime.parse(now.toString()),
      updatedAt: DateTime.parse(now.toString()),
    );
    addInspection(newInspection);
  }

  Future<void> addInspection(Inspection inspection) async {
    _inspections.add(inspection);
    await InspectionDatabase().insertInspection(inspection);
    notifyListeners();
  }
}
